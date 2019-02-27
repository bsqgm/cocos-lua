//
// generated by tolua
//
#include "xgame/lua-bindings/lua_xgame.h"
#include "xgame/xfilesystem.h"
#include "xgame/xlua.h"
#include "xgame/xlua-conv.h"
#include "xgame/xpreferences.h"
#include "xgame/xruntime.h"
#include "xgame/xtimer.h"

static int _kernel_runtime_clearStorage(lua_State *L)
{
    lua_settop(L, 0);
    
    xgame::runtime::clearStorage();
    
    return 0;
}

static int _kernel_runtime_launch(lua_State *L)
{
    lua_settop(L, 1);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    bool ret = (bool)xgame::runtime::launch(arg1);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_runtime_restart(lua_State *L)
{
    lua_settop(L, 0);
    
    bool ret = (bool)xgame::runtime::restart();
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_runtime_isRestarting(lua_State *L)
{
    lua_settop(L, 0);
    
    bool ret = (bool)xgame::runtime::isRestarting();
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_runtime_setAntialias(lua_State *L)
{
    lua_settop(L, 2);
    bool arg1 = (bool)xluacv_to_bool(L, 1);
    unsigned int arg2 = (unsigned int)xluacv_to_uint(L, 2);
    xgame::runtime::setAntialias(arg1, arg2);
    
    return 0;
}

static int _kernel_runtime_isAntialias(lua_State *L)
{
    lua_settop(L, 0);
    
    bool ret = (bool)xgame::runtime::isAntialias();
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_runtime_getNumSamples(lua_State *L)
{
    lua_settop(L, 0);
    
    unsigned int ret = (unsigned int)xgame::runtime::getNumSamples();
    xluacv_push_uint(L, ret);
    return 1;
}

static int _kernel_runtime_getPackageName(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::runtime::getPackageName();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_runtime_getVersion(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::runtime::getVersion();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_runtime_getVersionBuild(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::runtime::getVersionBuild();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_runtime_getChannel(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::runtime::getChannel();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_runtime_getOS(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::runtime::getOS();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_runtime_getDeviceInfo(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::runtime::getDeviceInfo();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int luaopen_kernel_runtime(lua_State *L)
{
    xluacls_class(L, "kernel.runtime", nullptr);
    xluacls_setfunc(L, "clearStorage", _kernel_runtime_clearStorage);
    xluacls_setfunc(L, "launch", _kernel_runtime_launch);
    xluacls_setfunc(L, "restart", _kernel_runtime_restart);
    xluacls_setfunc(L, "isRestarting", _kernel_runtime_isRestarting);
    xluacls_setfunc(L, "setAntialias", _kernel_runtime_setAntialias);
    xluacls_setfunc(L, "isAntialias", _kernel_runtime_isAntialias);
    xluacls_setfunc(L, "getNumSamples", _kernel_runtime_getNumSamples);
    xluacls_property(L, "packageName", _kernel_runtime_getPackageName, nullptr);
    xluacls_property(L, "version", _kernel_runtime_getVersion, nullptr);
    xluacls_property(L, "versionBuild", _kernel_runtime_getVersionBuild, nullptr);
    xluacls_property(L, "channel", _kernel_runtime_getChannel, nullptr);
    xluacls_property(L, "os", _kernel_runtime_getOS, nullptr);
    xluacls_property(L, "deviceInfo", _kernel_runtime_getDeviceInfo, nullptr);
    
    lua_newtable(L);
    luaL_setmetatable(L, "kernel.runtime");
    
    return 1;
}
static int _kernel_filesystem_shortPath(lua_State *L)
{
    lua_settop(L, 2);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    size_t arg2 = (size_t)xluacv_opt_uint(L, 2, 60);
    const std::string ret = (std::string)xgame::filesystem::shortPath(arg1, arg2);
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_filesystem_createDirectory(lua_State *L)
{
    lua_settop(L, 2);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    bool arg2 = (bool)xluacv_opt_bool(L, 2, false);
    bool ret = (bool)xgame::filesystem::createDirectory(arg1, arg2);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_remove(lua_State *L)
{
    lua_settop(L, 1);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    bool ret = (bool)xgame::filesystem::remove(arg1);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_exist(lua_State *L)
{
    lua_settop(L, 1);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    bool ret = (bool)xgame::filesystem::exist(arg1);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_isFile(lua_State *L)
{
    lua_settop(L, 1);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    bool ret = (bool)xgame::filesystem::isFile(arg1);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_isDirectory(lua_State *L)
{
    lua_settop(L, 1);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    bool ret = (bool)xgame::filesystem::isDirectory(arg1);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_rename(lua_State *L)
{
    lua_settop(L, 2);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    const std::string & arg2 = (std::string)xluacv_to_std_string(L, 2);
    bool ret = (bool)xgame::filesystem::rename(arg1, arg2);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_copy(lua_State *L)
{
    lua_settop(L, 2);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    const std::string & arg2 = (std::string)xluacv_to_std_string(L, 2);
    bool ret = (bool)xgame::filesystem::copy(arg1, arg2);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_write(lua_State *L)
{
    lua_settop(L, 3);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    const char * arg2 = (char*)xluacv_to_string(L, 2);
    size_t arg3 = (size_t)xluacv_to_uint(L, 3);
    bool ret = (bool)xgame::filesystem::write(arg1, arg2, arg3);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_read(lua_State *L)
{
    lua_settop(L, 1);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    cocos2d::Data ret = (cocos2d::Data)xgame::filesystem::read(arg1);
    xluacv_push_ccdata(L, ret);
    return 1;
}

static int _kernel_filesystem_unzip(lua_State *L)
{
    lua_settop(L, 2);
    const std::string & arg1 = (std::string)xluacv_to_std_string(L, 1);
    const std::string & arg2 = (std::string)xluacv_to_std_string(L, 2);
    bool ret = (bool)xgame::filesystem::unzip(arg1, arg2);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_filesystem_getWritablePath(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::filesystem::getWritablePath();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_filesystem_getCacheDirectory(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::filesystem::getCacheDirectory();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_filesystem_getDocumentDirectory(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::filesystem::getDocumentDirectory();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_filesystem_getTmpDirectory(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::filesystem::getTmpDirectory();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_filesystem_getSDCardDirectory(lua_State *L)
{
    lua_settop(L, 0);
    
    const std::string ret = (std::string)xgame::filesystem::getSDCardDirectory();
    xluacv_push_std_string(L, ret);
    return 1;
}

static int luaopen_kernel_filesystem(lua_State *L)
{
    xluacls_class(L, "kernel.filesystem", nullptr);
    xluacls_setfunc(L, "shortPath", _kernel_filesystem_shortPath);
    xluacls_setfunc(L, "createDirectory", _kernel_filesystem_createDirectory);
    xluacls_setfunc(L, "remove", _kernel_filesystem_remove);
    xluacls_setfunc(L, "exist", _kernel_filesystem_exist);
    xluacls_setfunc(L, "isFile", _kernel_filesystem_isFile);
    xluacls_setfunc(L, "isDirectory", _kernel_filesystem_isDirectory);
    xluacls_setfunc(L, "rename", _kernel_filesystem_rename);
    xluacls_setfunc(L, "copy", _kernel_filesystem_copy);
    xluacls_setfunc(L, "write", _kernel_filesystem_write);
    xluacls_setfunc(L, "read", _kernel_filesystem_read);
    xluacls_setfunc(L, "unzip", _kernel_filesystem_unzip);
    xluacls_property(L, "writablePath", _kernel_filesystem_getWritablePath, nullptr);
    xluacls_property(L, "cacheDirectory", _kernel_filesystem_getCacheDirectory, nullptr);
    xluacls_property(L, "documentDirectory", _kernel_filesystem_getDocumentDirectory, nullptr);
    xluacls_property(L, "tmpDirectory", _kernel_filesystem_getTmpDirectory, nullptr);
    xluacls_property(L, "sdCardDirectory", _kernel_filesystem_getSDCardDirectory, nullptr);
    
    lua_newtable(L);
    luaL_setmetatable(L, "kernel.filesystem");
    
    return 1;
}
static int _kernel_preferences_getBoolean(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    bool arg2 = (bool)xluacv_opt_bool(L, 2, false);
    bool ret = (bool)xgame::preferences::getBoolean(arg1, arg2);
    xluacv_push_bool(L, ret);
    return 1;
}

static int _kernel_preferences_setBoolean(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    bool arg2 = (bool)xluacv_to_bool(L, 2);
    xgame::preferences::setBoolean(arg1, arg2);
    
    return 0;
}

static int _kernel_preferences_getFloat(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    float arg2 = (float)xluacv_opt_number(L, 2, 0);
    float ret = (float)xgame::preferences::getFloat(arg1, arg2);
    xluacv_push_number(L, ret);
    return 1;
}

static int _kernel_preferences_setFloat(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    float arg2 = (float)xluacv_to_number(L, 2);
    xgame::preferences::setFloat(arg1, arg2);
    
    return 0;
}

static int _kernel_preferences_getDouble(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    double arg2 = (double)xluacv_opt_number(L, 2, 0);
    double ret = (double)xgame::preferences::getDouble(arg1, arg2);
    xluacv_push_number(L, ret);
    return 1;
}

static int _kernel_preferences_setDouble(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    double arg2 = (double)xluacv_to_number(L, 2);
    xgame::preferences::setDouble(arg1, arg2);
    
    return 0;
}

static int _kernel_preferences_getInteger(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    int arg2 = (int)xluacv_opt_int(L, 2, 0);
    int ret = (int)xgame::preferences::getInteger(arg1, arg2);
    xluacv_push_int(L, ret);
    return 1;
}

static int _kernel_preferences_setInteger(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    int arg2 = (int)xluacv_to_int(L, 2);
    xgame::preferences::setInteger(arg1, arg2);
    
    return 0;
}

static int _kernel_preferences_getString(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    const char * arg2 = (char*)xluacv_opt_string(L, 2, "");
    std::string ret = (std::string)xgame::preferences::getString(arg1, arg2);
    xluacv_push_std_string(L, ret);
    return 1;
}

static int _kernel_preferences_setString(lua_State *L)
{
    lua_settop(L, 2);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    const char * arg2 = (char*)xluacv_to_string(L, 2);
    xgame::preferences::setString(arg1, arg2);
    
    return 0;
}

static int _kernel_preferences_deleteKey(lua_State *L)
{
    lua_settop(L, 1);
    const char * arg1 = (char*)xluacv_to_string(L, 1);
    xgame::preferences::deleteKey(arg1);
    
    return 0;
}

static int _kernel_preferences_flush(lua_State *L)
{
    lua_settop(L, 0);
    
    xgame::preferences::flush();
    
    return 0;
}

static int luaopen_kernel_preferences(lua_State *L)
{
    xluacls_class(L, "kernel.preferences", nullptr);
    xluacls_setfunc(L, "getBoolean", _kernel_preferences_getBoolean);
    xluacls_setfunc(L, "setBoolean", _kernel_preferences_setBoolean);
    xluacls_setfunc(L, "getFloat", _kernel_preferences_getFloat);
    xluacls_setfunc(L, "setFloat", _kernel_preferences_setFloat);
    xluacls_setfunc(L, "getDouble", _kernel_preferences_getDouble);
    xluacls_setfunc(L, "setDouble", _kernel_preferences_setDouble);
    xluacls_setfunc(L, "getInteger", _kernel_preferences_getInteger);
    xluacls_setfunc(L, "setInteger", _kernel_preferences_setInteger);
    xluacls_setfunc(L, "getString", _kernel_preferences_getString);
    xluacls_setfunc(L, "setString", _kernel_preferences_setString);
    xluacls_setfunc(L, "deleteKey", _kernel_preferences_deleteKey);
    xluacls_setfunc(L, "flush", _kernel_preferences_flush);
    
    lua_newtable(L);
    luaL_setmetatable(L, "kernel.preferences");
    
    return 1;
}
int luaopen_xgame(lua_State *L)
{
    xlua_require(L, "kernel.runtime", luaopen_kernel_runtime);
    xlua_require(L, "kernel.filesystem", luaopen_kernel_filesystem);
    xlua_require(L, "kernel.preferences", luaopen_kernel_preferences);
    return 0;
}