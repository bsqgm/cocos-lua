module 'cocos2d_backend'

path = '../../frameworks/libxgame/src/lua-bindings'

headers = [[
#include "lua-bindings/lua_conv.h"
#include "lua-bindings/lua_conv_manual.h"
#include "cocos2d.h"
#include "cclua/xlua.h"
]]

make_luacls = function (cppname)
    cppname = string.gsub(cppname, "^cocos2d::backend::", "ccb.")
    cppname = string.gsub(cppname, "::", ".")
    return cppname
end

include "conf/exclude-type.lua"

exclude 'cocos2d::backend::RenderPassDescriptor'

typedef 'cocos2d::backend::UniformLocation'

typeconf 'cocos2d::backend::BufferUsage'
typeconf 'cocos2d::backend::BufferType'
typeconf 'cocos2d::backend::ShaderStage'
typeconf 'cocos2d::backend::VertexFormat'
typeconf 'cocos2d::backend::PixelFormat'
typeconf 'cocos2d::backend::TextureUsage'
typeconf 'cocos2d::backend::IndexFormat'
typeconf 'cocos2d::backend::VertexStepMode'
typeconf 'cocos2d::backend::PrimitiveType'
typeconf 'cocos2d::backend::TextureType'
typeconf 'cocos2d::backend::SamplerAddressMode'
typeconf 'cocos2d::backend::SamplerFilter'
typeconf 'cocos2d::backend::StencilOperation'
typeconf 'cocos2d::backend::CompareFunction'
typeconf 'cocos2d::backend::BlendOperation'
typeconf 'cocos2d::backend::BlendFactor'
typeconf 'cocos2d::backend::ColorWriteMask'
typeconf 'cocos2d::backend::CullMode'
typeconf 'cocos2d::backend::Winding'
typeconf 'cocos2d::backend::TextureCubeFace'
typeconf 'cocos2d::backend::ProgramType'
typeconf 'cocos2d::backend::Uniform'
typeconf 'cocos2d::backend::Attribute'
typeconf 'cocos2d::backend::FeatureType'
typeconf 'cocos2d::backend::Buffer'
typeconf 'cocos2d::backend::RenderPipeline'
typeconf 'cocos2d::backend::DepthStencilState'
typeconf 'cocos2d::backend::VertexLayout'

typeconf 'cocos2d::backend::CommandBuffer'
    .callback {name = 'captureScreen', tag_scope = 'once', tag_mode = 'OLUA_TAG_NEW'}

typeconf 'cocos2d::backend::Device'
    .insert({
        'newProgram',
        'newRenderPipeline',
        'newTexture',
        'newBuffer',
        'newCommandBuffer'
    }, {
        after = [[
            ret->autorelease();
        ]]
    })

typeconf 'cocos2d::backend::DeviceInfo'
typeconf 'cocos2d::backend::ShaderCache'
typeconf 'cocos2d::backend::ShaderModule'
typeconf 'cocos2d::backend::ProgramCache'

typeconf 'cocos2d::backend::ProgramState'
    .chunk([[
        static inline void olua_check_value(lua_State *L, int idx, cocos2d::Vec2 *value)
        {
            olua_check_cocos2d_Vec2(L, idx, value);
        }

        static inline void olua_check_value(lua_State *L, int idx, cocos2d::Vec3 *value)
        {
            olua_check_cocos2d_Vec3(L, idx, value);
        }

        static inline void olua_check_value(lua_State *L, int idx, cocos2d::Vec4 *value)
        {
            olua_check_cocos2d_Vec4(L, idx, value);
        }

        static inline void olua_check_value(lua_State *L, int idx, cocos2d::Mat4 *value)
        {
            olua_check_cocos2d_Mat4(L, idx, value);
        }

        static inline void olua_check_value(lua_State *L, int idx, int *value)
        {
            *value = (int)olua_checkinteger(L, idx);
        }

        static inline void olua_check_value(lua_State *L, int idx, float *value)
        {
            *value = (float)olua_checknumber(L, idx);
        }

        template <typename T> int _cocos2d_backend_ProgramState_setUniform(lua_State *L)
        {
            cocos2d::backend::UniformLocation location;
            T value;
            auto self = olua_toobj<cocos2d::backend::ProgramState>(L, 1);
            if (olua_isstring(L, 2)) {
                location = self->getUniformLocation(olua_checkstring(L, 2));
            } else {
                olua_check_cocos2d_backend_UniformLocation(L, 2, &location);
            }
            olua_check_value(L, 3, &value);
            self->setUniform(location, &value, sizeof(T));
            return 0;
        }

        template <typename T> int _cocos2d_backend_ProgramState_setUniformv(lua_State *L)
        {
            cocos2d::backend::UniformLocation location;
            auto self = olua_toobj<cocos2d::backend::ProgramState>(L, 1);
            if (olua_isstring(L, 2)) {
                location = self->getUniformLocation(olua_checkstring(L, 2));
            } else {
                olua_check_cocos2d_backend_UniformLocation(L, 2, &location);
            }
            luaL_checktype(L, 3, LUA_TTABLE);
            int len = (int)lua_rawlen(L, 3);
            T *value = new T[len]();
            for (int i = 0; i < len; i++) {
                lua_rawgeti(L, 3, i + 1);
                T v;
                olua_check_value(L, -1, &v);
                lua_pop(L, 1);
                value[i] = v;
            }
            self->setUniform(location, value, sizeof(T) * len);
            delete []value;
            return 0;
        }
    ]])
    .exclude 'setCallbackUniform'
    .exclude 'getCallbackUniforms'
    .exclude 'getVertexUniformBuffer'
    .exclude 'getFragmentUniformBuffer'
    .func('getVertexLayout', [[
        {
            auto self = olua_toobj<cocos2d::backend::ProgramState>(L, 1);
            olua_push_cppobj<cocos2d::backend::VertexLayout>(L, self->getVertexLayout().get());
            olua_addref(L, 1, "vertexLayout", -1, OLUA_MODE_SINGLE);
            return 1;
        }
    ]])
    .func('setUniformVec2', [[
        {
            _cocos2d_backend_ProgramState_setUniform<cocos2d::Vec2>(L);
            return 0;
        }
    ]])
    .func('setUniformVec3', [[
        {
            _cocos2d_backend_ProgramState_setUniform<cocos2d::Vec3>(L);
            return 0;
        }
    ]])
    .func('setUniformVec4', [[
        {
            _cocos2d_backend_ProgramState_setUniform<cocos2d::Vec4>(L);
            return 0;
        }
    ]])
    .func('setUniformMat4', [[
        {
            _cocos2d_backend_ProgramState_setUniform<cocos2d::Mat4>(L);
            return 0;
        }
    ]])
    .func('setUniformInt', [[
        {
            _cocos2d_backend_ProgramState_setUniform<int>(L);
            return 0;
        }
    ]])
    .func('setUniformFloat', [[
        {
            _cocos2d_backend_ProgramState_setUniform<float>(L);
            return 0;
        }
    ]])
    .func('setUniformVec2v', [[
        {
            _cocos2d_backend_ProgramState_setUniformv<cocos2d::Vec2>(L);
            return 0;
        }
    ]])
    .func('setUniformVec3v', [[
        {
            _cocos2d_backend_ProgramState_setUniformv<cocos2d::Vec3>(L);
            return 0;
        }
    ]])
    .func('setUniformVec4v', [[
        {
            _cocos2d_backend_ProgramState_setUniformv<cocos2d::Vec4>(L);
            return 0;
        }
    ]])
    .func('setUniformMat4v', [[
        {
            _cocos2d_backend_ProgramState_setUniformv<cocos2d::Mat4>(L);
            return 0;
        }
    ]])
    .func('setUniformIntv', [[
        {
            _cocos2d_backend_ProgramState_setUniformv<int>(L);
            return 0;
        }
    ]])
    .func('setUniformFloatv', [[
        {
            _cocos2d_backend_ProgramState_setUniformv<float>(L);
            return 0;
        }
    ]])

typeconf 'cocos2d::backend::Program'

typeconf 'cocos2d::backend::TextureBackend'
    .callback {
        name = 'getBytes',
        tag_mode = 'OLUA_TAG_NEW',
        tag_scope = 'once',
    }

typeconf 'cocos2d::backend::Texture2DBackend'
typeconf 'cocos2d::backend::TextureCubemapBackend'
