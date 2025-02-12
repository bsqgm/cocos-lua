/**
 * The MIT License (MIT)
 *
 * Copyright (c) 2019-2021 codetypes@gmail.com
 *
 * https://github.com/zhongfq/olua
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#ifndef __OLUA_HPP__
#define __OLUA_HPP__

#include "olua.h"

#include <string>
#include <functional>
#include <set>
#include <vector>
#include <map>
#include <unordered_map>

#define olua_noapi(api) static_assert(false, #api" is not defined")

template <typename T>
inline T *olua_toobj(lua_State *L, int idx);

#ifndef OLUA_HAVE_MAINTHREAD
static lua_State *olua_mainthread(lua_State *L)
{
    lua_State *mt = NULL;
    if (L) {
        olua_rawgeti(L, LUA_REGISTRYINDEX, LUA_RIDX_MAINTHREAD);
        luaL_checktype(L, -1, LUA_TTHREAD);
        mt = lua_tothread(L, -1);
        lua_pop(L, 1);
    }
    return mt;
}
#endif

/**
 * Help to check whether callback is run on the host thread of lua vm.
 * It would be inserted into the start of callback block.
 */
#ifndef OLUA_HAVE_CHECKHOSTTHREAD
#define olua_checkhostthread() ((void)0)
#endif

/**
 * Help you to delete ref when the function prototype don't provide enough
 * information. You can record some information in olua_startcmpref and
 * delete ref in olua_endcmpref by compare.
 *
 * prototype:
 *  void olua_startcmpref(lua_State *L, int idx, const char *refname);
 *  void olua_endcmpref(lua_State *L, int idx, const char *refname);
 *
 * example:
 *  static int func(lua_State *L)
 *  {
 *      ...
 *      olua_startcmpref(L);
 *      self->removeChildren();
 *      olua_endcmpref(L);
 *      ...
 *  }
 */

#ifndef OLUA_HAVE_CMPREF
#define olua_startcmpref(L, i, name) olua_noapi(olua_startcmpref)
#define olua_endcmpref(L, i, name)   olua_noapi(olua_endcmpref)
#endif

/**
 * Help you to get calling stack when thow lua error in c++ internal
 * implementation. olua_startinvoke would be inserted into the start of
 * function block and olua_endinvoke would be inserted before each
 * return expression.
 *
 * example:
 *  static int func(lua_State *L)
 *  {
 *      olua_startinvoke(L);
 *      ...
 *      ...
 *      if (cond) {
 *          olua_endinvoke(L);
 *          return 2;
 *      }
 *      ...
 *      olua_endinvoke(L);
 *      return 1;
 *  }
 */
#ifndef OLUA_HAVE_TRACEINVOKING
#define olua_startinvoke(L) ((void)L)
#define olua_endinvoke(L)   ((void)L)
#endif

/**
 * Handle the status of object after push, you can do some jobs
 * according to the object status. For example, retain object in push and
 * release object in __gc method.
 *
 *  #define OLUA_HAVE_POSTPUSH
 *  template <typename T> void olua_postpush(lua_State *L, T* obj, int status)
 *  {
 *      if (std::is_base_of<Object, T>::value && (status == OLUA_OBJ_NEW
 *          || status == OLUA_OBJ_UPDATE)) {
 *          ((Object *)obj)->retain();
 *      }
 *  }
 */
template <typename T>
void olua_postpush(lua_State *L, T* obj, int status);
#ifndef OLUA_HAVE_POSTPUSH
template <typename T>
void olua_postpush(lua_State *L, T* obj, int status) {}
#endif

/**
 * Handle the status of object after new.
 *
 * example:
 *  static int Object_new(lua_State *L)
 *  {
 *      olua_startinvoke(L);
 *      Object *obj = new Object();
 *      olua_push_cppobj(L, obj, "Object");
 *      olua_postnew(L, obj);
 *      olua_endinvoke(L);
 *      return 1;
 *  }
 *
 *  #define OLUA_HAVE_POSTNEW
 *  template <typename T> void olua_postnew(lua_State *L, T *obj)
 *  {
 *      if (std::is_base_of<Object, T>::value) {
 *          ((Object *)obj)->autorelease();
 *      } else {
 *          olua_assert(obj == olua_toobj<T>(L, -1), "must be same object");
 *          olua_setownership(L, -1, OLUA_OWNERSHIP_VM);
 *      }
 *  }
 *
 */
template <typename T>
void olua_postnew(lua_State *L, T *obj);
#ifndef OLUA_HAVE_POSTNEW
template <typename T>
void olua_postnew(lua_State *L, T *obj)
{
    olua_assert(obj == olua_toobj<T>(L, -1), "must be same object");
    olua_setownership(L, -1, OLUA_OWNERSHIP_VM);
}
#endif

/**
 * delete object which belong to lua vm.
 */
template <typename T>
void olua_postgc(lua_State *L, int idx);
#ifndef OLUA_HAVE_POSTGC
template <typename T>
void olua_postgc(lua_State *L, int idx)
{
    if (olua_getownership(L, idx) == OLUA_OWNERSHIP_VM) {
        T *obj = olua_toobj<T>(L, idx);
        olua_setrawobj(L, idx, nullptr);
        if (std::is_void<T>()) {
            free(obj);
        } else {
            delete obj;
        }
    }
}
#endif

/**
 * register or get lua type for c++ class.
 */
#ifdef OLUA_HAVE_LUATYPE
void olua_registerluatype(lua_State *L, const char *type, const char *cls);
const char *olua_getluatype(lua_State *L, const char *cls);
#else
static inline void olua_registerluatype(lua_State *L, const char *type, const char *cls)
{
    lua_pushstring(L, type);
    lua_pushstring(L, cls);
    lua_rawset(L, LUA_REGISTRYINDEX);
}
static inline const char *olua_getluatype(lua_State *L, const char *cls)
{
    return olua_optfieldstring(L, LUA_REGISTRYINDEX, cls, nullptr);
}
#endif

template <typename T>
inline void olua_registerluatype(lua_State *L, const char *cls)
{
    olua_registerluatype(L, typeid(T).name(), cls);
}

template <typename T>
const char *olua_getluatype(lua_State *L, const T *obj, const char *cls)
{
    const char *preferred;
    
    // try obj RTTI
    if (olua_likely(obj)) {
        preferred = olua_getluatype(L, typeid(*obj).name());
        if (olua_likely(preferred)) {
            return preferred;
        }
    }
    
    // try class RTTI
    preferred = olua_getluatype(L, typeid(T).name());
    if (olua_likely(preferred)) {
        return preferred;
    }
    
    return cls;
}

template <>
inline const char *olua_getluatype<void>(lua_State *L, const void *obj, const char *cls)
{
    return cls == NULL ? OLUA_VOIDCLS : cls;
}

template <typename T>
inline const char *olua_getluatype(lua_State *L)
{
    return olua_getluatype<T>(L, nullptr, nullptr);
}

// manipulate userdata api
template <typename T>
inline bool olua_isa(lua_State *L, int idx)
{
    return olua_isa(L, idx, olua_getluatype<T>(L));
}

template <typename T>
inline void *olua_pushclassobj(lua_State *L)
{
    return olua_pushclassobj(L, olua_getluatype<T>(L));
}

template <typename T>
inline T *olua_toobj(lua_State *L, int idx)
{
    return (T *)olua_toobj(L, idx, olua_getluatype<T>(L));
}

template <typename T>
inline T *olua_checkobj(lua_State *L, int idx)
{
    return (T *)olua_checkobj(L, idx, olua_getluatype<T>(L));
}

template <typename T>
int olua_pushobj(lua_State *L, const T *value, const char *cls)
{
    cls = olua_getluatype(L, value, cls);
    olua_postpush(L, (T *)value, olua_pushobj(L, (void *)value, cls));
    return 1;
}

template <typename T>
inline int olua_pushobj(lua_State *L, const T *value)
{
    return olua_pushobj<T>(L, value, nullptr);
}

// convertor between c++ and lua, use for code generation
#define olua_push_std_string(L, v)      ((lua_pushstring(L, (v).c_str())), 1)
#define olua_check_std_string(L, i, v)  (*(v) = olua_checkstring(L, (i)))
#define olua_is_std_string(L, i)        (olua_isstring(L, (i)))

#define olua_to_cppobj(L, i, v, c)      (olua_to_obj(L, (i), (v), (c)))
#define olua_check_cppobj(L, i, v, c)   (olua_check_obj(L, (i), (v), (c)))
#define olua_is_cppobj(L, i, c)         (olua_is_obj(L, (i), (c)))

template <typename T>
inline int olua_push_cppobj(lua_State *L, const T *value, const char *cls)
{
    return olua_pushobj<T>(L, value, cls);
}

template <typename T>
inline int olua_push_cppobj(lua_State *L, const T *value)
{
    return olua_pushobj<T>(L, value, nullptr);
}

// map & array functions
template <class K, class V>
void olua_insert_map(std::map<K, V> *map, K key, V value)
{
    map->insert(std::make_pair(key, value));
}

template <class K, class V>
void olua_insert_map(std::unordered_map<K, V> *map, K key, V value)
{
    map->insert(std::make_pair(key, value));
}

template <class K, class V>
void olua_foreach_map(const std::map<K, V> *map, const std::function<void(K, V)> &callback)
{
    for (auto itor : (*map)) {
        callback(itor.first, itor.second);
    }
}

template <class K, class V>
void olua_foreach_map(const std::unordered_map<K, V> *map, const std::function<void(K, V)> &callback)
{
    for (auto itor : (*map)) {
        callback(itor.first, itor.second);
    }
}

template <class K,  class V, template<class...> class Map>
int olua_push_map(lua_State *L, const Map<K, V> *map, const std::function<void(K, V)> &push)
{
    lua_newtable(L);
    olua_foreach_map<K, V>(map, [=](K key, V value) {
        push(key, value);
        lua_rawset(L, -3);
    });
    return 1;
}

template <class K,  class V, template<class...> class Map>
void olua_check_map(lua_State *L, int idx, Map<K, V> *map, const std::function<void(K *, V *)> &check)
{
    idx = lua_absindex(L, idx);
    luaL_checktype(L, idx, LUA_TTABLE);
    lua_pushnil(L);
    while (lua_next(L, idx)) {
        K key;
        V value;
        check(&key, &value);
        olua_insert_map<K, V>(map, key, value);
        lua_pop(L, 1);
    }
}

template <class T>
void olua_insert_array(std::vector<T> *array, T value)
{
    array->push_back(value);
}

template <class T>
void olua_insert_array(std::set<T> *array, T value)
{
    array->insert(value);
}

template <class T>
void olua_foreach_array(const std::vector<T> *array, const std::function<void(T)> &callback)
{
    for (auto itor : (*array)) {
        callback(itor);
    }
}

template <class T>
void olua_foreach_array(const std::set<T> *array, const std::function<void(T)> &callback)
{
    for (auto itor : (*array)) {
        callback(itor);
    }
}

template <class T, template<class...> class Array>
int olua_push_array(lua_State *L, const Array<T> *array, const std::function<void(T)> &push)
{
    int idx = 0;
    lua_newtable(L);
    olua_foreach_array<T>(array, [=](T value) mutable {
        push(value);
        lua_rawseti(L, -2, ++idx);
    });
    return 1;
}

template <class T, template<class...> class Array>
void olua_check_array(lua_State *L, int idx, Array<T> *array, const std::function<void(T *)> &check)
{
    idx = lua_absindex(L, idx);
    luaL_checktype(L, idx, LUA_TTABLE);
    int total = (int)lua_rawlen(L, idx);
    for (int i = 1; i <= total; i++) {
        T obj;
        lua_rawgeti(L, idx, i);
        check(&obj);
        olua_insert_array<T>(array, obj);
        lua_pop(L, 1);
    }
}

template <typename T, template<class...> class Array>
void olua_pack_array(lua_State *L, int idx, Array<T> *array, const std::function<void(T *)> &check)
{
    idx = lua_absindex(L, idx);
    int total = (int)(lua_gettop(L) - (idx - 1));
    for (int i = 0; i < total; i++) {
        T obj;
        lua_pushvalue(L, idx + i);
        check(&obj);
        olua_insert_array<T>(array, obj);
        lua_pop(L, 1);
    }
}

// std::vector
static inline bool olua_is_std_vector(lua_State *L, int idx)
{
    return olua_istable(L, idx);
}

template <class T>
void olua_foreach_std_vector(const std::vector<T> *array, const std::function<void(T)> &callback)
{
    olua_foreach_array<T, std::vector>(array, callback);
}

template <class T>
int olua_push_std_vector(lua_State *L, const std::vector<T> *array, const std::function<void(T)> &push)
{
    return olua_push_array<T, std::vector>(L, array, push);
}

template <class T>
void olua_check_std_vector(lua_State *L, int idx, std::vector<T> *array, const std::function<void(T *)> &check)
{
    return olua_check_array<T, std::vector>(L, idx, array, check);
}

// std::set
static inline bool olua_is_std_set(lua_State *L, int idx)
{
    return olua_istable(L, idx);
}

template <class T>
void olua_foreach_std_set(const std::set<T> *array, const std::function<void(T)> &callback)
{
    olua_foreach_array<T, std::set>(array, callback);
}

template <class T>
int olua_push_std_set(lua_State *L, const std::set<T> *array, const std::function<void(T)> &push)
{
    return olua_push_array<T, std::set>(L, array, push);
}

template <class T>
void olua_check_std_set(lua_State *L, int idx, std::set<T> *array, const std::function<void(T *)> &check)
{
    return olua_check_array<T, std::set>(L, idx, array, check);
}

// std::unordered_map
static inline bool olua_is_std_unordered_map(lua_State *L, int idx)
{
    return olua_istable(L, idx);
}

template <class K, class V>
void olua_foreach_std_unordered_map(const std::unordered_map<K, V> *map, const std::function<void(K, V)> &callback)
{
    olua_foreach_map<K, V, std::unordered_map>(map, callback);
}

template <class K,  class V>
int olua_push_std_unordered_map(lua_State *L, const std::unordered_map<K, V> *map, const std::function<void(K, V)> &push)
{
    return olua_push_map<K, V, std::unordered_map>(L, map, push);
}

template <class K,  class V>
void olua_check_std_unordered_map(lua_State *L, int idx, std::unordered_map<K, V> *map, const std::function<void(K *, V *)> &check)
{
    olua_check_map<K, V, std::unordered_map>(L, idx, map, check);
}

// std::map
static inline bool olua_is_std_map(lua_State *L, int idx)
{
    return olua_istable(L, idx);
}

template <class K, class V>
void olua_foreach_std_map(const std::map<K, V> *map, const std::function<void(K, V)> callback)
{
    olua_foreach_map<K, V, std::map>(map, &callback);
}

template <class K,  class V>
int olua_push_std_map(lua_State *L, const std::map<K, V> *map, const std::function<void(K, V)> &push)
{
    return olua_push_map<K, V, std::map>(L, map, push);
}

template <class K,  class V>
void olua_check_std_map(lua_State *L, int idx, std::map<K, V> *map, const std::function<void(K *, V *)> &check)
{
    olua_check_map<K, V, std::map>(L, idx, map, check);
}

// callback
template <typename T>
bool olua_is_callback(lua_State *L, int idx)
{
    if (olua_isfunction(L, idx)) {
        return true;
    }
    if (olua_istable(L, idx)) {
        const char *cls = olua_optfieldstring(L, idx, "classname", NULL);
        return cls && strcmp(cls, olua_getluatype<T>(L)) == 0;
    }
    return false;
}

template <typename T>
int olua_push_callback(lua_State *L, const T *value)
{
    if (!(olua_isfunction(L, -1) || olua_isnil(L, -1))) {
        luaL_error(L, "execpt 'function' or 'nil'");
    } else {
        lua_createtable(L, 0, 2);
        lua_pushvalue(L, -2);
        olua_rawsetf(L, -2, "callback");
        lua_pushstring(L, olua_getluatype<T>(L));
        olua_rawsetf(L, -2, "classname");
        lua_replace(L, -2);
    }
    return 1;
}

template <typename T>
void olua_check_callback(lua_State *L, int idx, T *value)
{
    if (olua_istable(L, idx)) {
        olua_rawgetf(L, idx, "callback");
        lua_replace(L, idx);
    }
}

// std::function
template <typename T>
int olua_push_std_function(lua_State *L, const std::function<T> *value)
{
    if (!(olua_isfunction(L, -1) || olua_isnil(L, -1))) {
        luaL_error(L, "execpt 'function' or 'nil'");
    }
    return 1;
}

template <typename T>
void olua_check_std_function(lua_State *L, int idx, std::function<T> *value)
{
}

static inline bool olua_is_std_function(lua_State *L, int idx)
{
    return olua_isfunction(L, idx);
}

#endif
