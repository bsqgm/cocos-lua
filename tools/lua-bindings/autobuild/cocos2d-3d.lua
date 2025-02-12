-- AUTO BUILD, DON'T MODIFY!

dofile "autobuild/cocos2d-3d-types.lua"

NAME = "cocos2d_3d"
PATH = "../../frameworks/libxgame/src/lua-bindings"
HEADERS = [[
    #include "lua-bindings/lua_conv.h"
    #include "lua-bindings/lua_conv_manual.h"
    #include "cclua/xlua.h"
    #include "cocos2d.h"
    #include "3d/CC3DProgramInfo.h"
]]
CHUNK = nil

typeconv 'cocos2d::MeshVertexAttrib'
    .var('type', 'cocos2d::backend::VertexFormat type')
    .var('vertexAttrib', 'cocos2d::shaderinfos::VertexKey vertexAttrib')


typeconf 'cocos2d::NTextureData::Usage'
    .supercls(nil)
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .enum('Unknown', 'cocos2d::NTextureData::Usage::Unknown')
    .enum('None', 'cocos2d::NTextureData::Usage::None')
    .enum('Diffuse', 'cocos2d::NTextureData::Usage::Diffuse')
    .enum('Emissive', 'cocos2d::NTextureData::Usage::Emissive')
    .enum('Ambient', 'cocos2d::NTextureData::Usage::Ambient')
    .enum('Specular', 'cocos2d::NTextureData::Usage::Specular')
    .enum('Shininess', 'cocos2d::NTextureData::Usage::Shininess')
    .enum('Normal', 'cocos2d::NTextureData::Usage::Normal')
    .enum('Bump', 'cocos2d::NTextureData::Usage::Bump')
    .enum('Transparency', 'cocos2d::NTextureData::Usage::Transparency')
    .enum('Reflection', 'cocos2d::NTextureData::Usage::Reflection')

typeconf 'cocos2d::shaderinfos::VertexKey'
    .supercls(nil)
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .enum('VERTEX_ATTRIB_POSITION', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_POSITION')
    .enum('VERTEX_ATTRIB_COLOR', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_COLOR')
    .enum('VERTEX_ATTRIB_TEX_COORD', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_TEX_COORD')
    .enum('VERTEX_ATTRIB_TEX_COORD1', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_TEX_COORD1')
    .enum('VERTEX_ATTRIB_TEX_COORD2', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_TEX_COORD2')
    .enum('VERTEX_ATTRIB_TEX_COORD3', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_TEX_COORD3')
    .enum('VERTEX_ATTRIB_NORMAL', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_NORMAL')
    .enum('VERTEX_ATTRIB_BLEND_WEIGHT', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_BLEND_WEIGHT')
    .enum('VERTEX_ATTRIB_BLEND_INDEX', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_BLEND_INDEX')
    .enum('VERTEX_ATTRIB_TANGENT', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_TANGENT')
    .enum('VERTEX_ATTRIB_BINORMAL', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_BINORMAL')
    .enum('VERTEX_ATTRIB_MAX', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_MAX')
    .enum('VERTEX_ATTRIB_TEX_COORDS', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_TEX_COORDS')
    .enum('VERTEX_ATTRIB_ERROR', 'cocos2d::shaderinfos::VertexKey::VERTEX_ATTRIB_ERROR')

typeconf 'cocos2d::shaderinfos::Uniformkey'
    .supercls(nil)
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .enum('UNIFORM_AMBIENT_COLOR', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_AMBIENT_COLOR')
    .enum('UNIFORM_P_MATRIX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_P_MATRIX')
    .enum('UNIFORM_MULTIVIEW_P_MATRIX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_MULTIVIEW_P_MATRIX')
    .enum('UNIFORM_MV_MATRIX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_MV_MATRIX')
    .enum('UNIFORM_MVP_MATRIX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_MVP_MATRIX')
    .enum('UNIFORM_MULTIVIEW_MVP_MATRIX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_MULTIVIEW_MVP_MATRIX')
    .enum('UNIFORM_NORMAL_MATRIX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_NORMAL_MATRIX')
    .enum('UNIFORM_TIME', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_TIME')
    .enum('UNIFORM_SIN_TIME', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_SIN_TIME')
    .enum('UNIFORM_COS_TIME', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_COS_TIME')
    .enum('UNIFORM_RANDOM01', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_RANDOM01')
    .enum('UNIFORM_SAMPLER0', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_SAMPLER0')
    .enum('UNIFORM_SAMPLER1', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_SAMPLER1')
    .enum('UNIFORM_SAMPLER2', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_SAMPLER2')
    .enum('UNIFORM_SAMPLER3', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_SAMPLER3')
    .enum('UNIFORM_MAX', 'cocos2d::shaderinfos::Uniformkey::UNIFORM_MAX')

typeconf 'cocos2d::NTextureData'
    .supercls(nil)
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .var('id', 'std::string id')
    .var('filename', 'std::string filename')
    .var('type', 'cocos2d::NTextureData::Usage type')
    .var('wrapS', 'cocos2d::backend::SamplerAddressMode wrapS')
    .var('wrapT', 'cocos2d::backend::SamplerAddressMode wrapT')

typeconf 'cocos2d::Mesh'
    .supercls('cocos2d::Ref')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'static cocos2d::Mesh *create(const std::vector<float> &positions, const std::vector<float> &normals, const std::vector<float> &texs, const std::vector<unsigned short> &indices)', 'static cocos2d::Mesh *create(const std::vector<float> &vertices, int perVertexSizeInFloat, const std::vector<unsigned short> &indices, const std::vector<MeshVertexAttrib> &attribs)')
    .func(nil, 'cocos2d::backend::Buffer *getVertexBuffer()')
    .func(nil, 'bool hasVertexAttrib(cocos2d::shaderinfos::VertexKey attrib)')
    .func(nil, 'ssize_t getMeshVertexAttribCount()')
    .func(nil, 'const cocos2d::MeshVertexAttrib &getMeshVertexAttribute(int idx)')
    .func(nil, 'int getVertexSizeInBytes()')
    .func(nil, 'void setTexture(const std::string &texPath)', 'void setTexture(cocos2d::Texture2D *tex)', 'void setTexture(cocos2d::Texture2D *tex, cocos2d::NTextureData::Usage usage, @optional bool cacheFileName)', 'void setTexture(const std::string &texPath, cocos2d::NTextureData::Usage usage)')
    .func(nil, 'cocos2d::Texture2D *getTexture()', 'cocos2d::Texture2D *getTexture(cocos2d::NTextureData::Usage usage)')
    .func(nil, 'void setVisible(bool visible)')
    .func(nil, 'bool isVisible()')
    .func(nil, 'cocos2d::MeshSkin *getSkin()')
    .func(nil, 'cocos2d::backend::ProgramState *getProgramState()')
    .func(nil, 'const std::string &getName()')
    .func(nil, 'void setBlendFunc(const cocos2d::BlendFunc &blendFunc)')
    .func(nil, 'const cocos2d::BlendFunc &getBlendFunc()')
    .func(nil, 'cocos2d::CustomCommand::PrimitiveType getPrimitiveType()')
    .func(nil, 'ssize_t getIndexCount()')
    .func(nil, 'cocos2d::CustomCommand::IndexFormat getIndexFormat()')
    .func(nil, 'cocos2d::backend::Buffer *getIndexBuffer()')
    .func(nil, 'void setProgramState(cocos2d::backend::ProgramState *programState)')
    .func(nil, 'void draw(cocos2d::Renderer *renderer, float globalZ, const cocos2d::Mat4 &transform, uint32_t flags, unsigned int lightMask, const cocos2d::Vec4 &color, bool forceDepthWrite)')
    .func(nil, 'void setSkin(cocos2d::MeshSkin *skin)')
    .func(nil, 'void setName(const std::string &name)')
    .func(nil, 'void calculateAABB()')
    .func(nil, 'void setForce2DQueue(bool force2D)')
    .func(nil, 'std::string getTextureFileName()')
    .func(nil, 'Mesh()')
    .prop('vertexBuffer', nil, nil)
    .prop('meshVertexAttribCount', nil, nil)
    .prop('vertexSizeInBytes', nil, nil)
    .prop('visible', nil, nil)
    .prop('skin', nil, nil)
    .prop('programState', nil, nil)
    .prop('name', nil, nil)
    .prop('blendFunc', nil, nil)
    .prop('primitiveType', nil, nil)
    .prop('indexCount', nil, nil)
    .prop('indexFormat', nil, nil)
    .prop('indexBuffer', nil, nil)
    .prop('textureFileName', nil, nil)

typeconf 'cocos2d::MeshSkin'
    .supercls('cocos2d::Ref')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'ssize_t getBoneCount()')
    .func(nil, 'cocos2d::Bone3D *getBoneByIndex(unsigned int index)')
    .func(nil, 'cocos2d::Bone3D *getBoneByName(const std::string &id)')
    .func(nil, 'int getBoneIndex(cocos2d::Bone3D *bone)')
    .func(nil, 'ssize_t getMatrixPaletteSize()')
    .func(nil, 'ssize_t getMatrixPaletteSizeInBytes()')
    .func(nil, 'cocos2d::Bone3D *getRootBone()')
    .func(nil, 'MeshSkin()')
    .func(nil, 'void removeAllBones()')
    .func(nil, 'void addSkinBone(cocos2d::Bone3D *bone)')
    .func(nil, 'const cocos2d::Mat4 &getInvBindPose(const cocos2d::Bone3D *bone)')
    .prop('boneCount', nil, nil)
    .prop('matrixPaletteSize', nil, nil)
    .prop('matrixPaletteSizeInBytes', nil, nil)
    .prop('rootBone', nil, nil)

typeconf 'cocos2d::BillBoard::Mode'
    .supercls(nil)
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .enum('VIEW_POINT_ORIENTED', 'cocos2d::BillBoard::Mode::VIEW_POINT_ORIENTED')
    .enum('VIEW_PLANE_ORIENTED', 'cocos2d::BillBoard::Mode::VIEW_PLANE_ORIENTED')

typeconf 'cocos2d::BillBoard'
    .supercls('cocos2d::Sprite')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'static cocos2d::BillBoard *create(@optional cocos2d::BillBoard::Mode mode)', 'static cocos2d::BillBoard *create(const std::string &filename, @optional cocos2d::BillBoard::Mode mode)', 'static cocos2d::BillBoard *create(const std::string &filename, const cocos2d::Rect &rect, @optional cocos2d::BillBoard::Mode mode)')
    .func(nil, 'static cocos2d::BillBoard *createWithTexture(cocos2d::Texture2D *texture, @optional cocos2d::BillBoard::Mode mode)')
    .func(nil, 'void setMode(cocos2d::BillBoard::Mode mode)')
    .func(nil, 'cocos2d::BillBoard::Mode getMode()')
    .func(nil, 'BillBoard()')
    .prop('mode', nil, nil)

typeconf 'cocos2d::Sprite3DMaterial::MaterialType'
    .supercls(nil)
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .enum('UNLIT', 'cocos2d::Sprite3DMaterial::MaterialType::UNLIT')
    .enum('UNLIT_NOTEX', 'cocos2d::Sprite3DMaterial::MaterialType::UNLIT_NOTEX')
    .enum('VERTEX_LIT', 'cocos2d::Sprite3DMaterial::MaterialType::VERTEX_LIT')
    .enum('DIFFUSE', 'cocos2d::Sprite3DMaterial::MaterialType::DIFFUSE')
    .enum('DIFFUSE_NOTEX', 'cocos2d::Sprite3DMaterial::MaterialType::DIFFUSE_NOTEX')
    .enum('BUMPED_DIFFUSE', 'cocos2d::Sprite3DMaterial::MaterialType::BUMPED_DIFFUSE')
    .enum('CUSTOM', 'cocos2d::Sprite3DMaterial::MaterialType::CUSTOM')

typeconf 'cocos2d::Sprite3DMaterial'
    .supercls('cocos2d::Material')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'cocos2d::Sprite3DMaterial::MaterialType getMaterialType()')
    .func(nil, 'static cocos2d::Sprite3DMaterial *createBuiltInMaterial(cocos2d::Sprite3DMaterial::MaterialType type, bool skinned)', 'static void createBuiltInMaterial()')
    .func(nil, 'static cocos2d::Sprite3DMaterial *createWithFilename(const std::string &path)')
    .func(nil, 'static cocos2d::Sprite3DMaterial *createWithProgramState(cocos2d::backend::ProgramState *programState)')
    .func(nil, 'void setTexture(cocos2d::Texture2D *tex, cocos2d::NTextureData::Usage usage)')
    .func(nil, 'static void releaseBuiltInMaterial()')
    .func(nil, 'static void releaseCachedMaterial()')
    .prop('materialType', nil, nil)

typeconf 'cocos2d::Sprite3D'
    .supercls('cocos2d::Node')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'static cocos2d::Sprite3D *create()', 'static cocos2d::Sprite3D *create(const std::string &modelPath)', 'static cocos2d::Sprite3D *create(const std::string &modelPath, const std::string &texturePath)')
    .func(nil, 'void setTexture(const std::string &texFile)', 'void setTexture(cocos2d::Texture2D *texture)')
    .func(nil, 'cocos2d::Mesh *getMeshByIndex(int index)')
    .func(nil, 'cocos2d::Mesh *getMeshByName(const std::string &name)')
    .func(nil, 'std::vector<Mesh *> getMeshArrayByName(const std::string &name)')
    .func(nil, 'cocos2d::Mesh *getMesh()')
    .func(nil, 'ssize_t getMeshCount()')
    .func(nil, 'cocos2d::Skeleton3D *getSkeleton()')
    .func(nil, 'cocos2d::AttachNode *getAttachNode(const std::string &boneName)')
    .func(nil, 'void removeAttachNode(const std::string &boneName)')
    .func(nil, 'void removeAllAttachNode()')
    .func(nil, 'void setBlendFunc(const cocos2d::BlendFunc &blendFunc)')
    .func(nil, 'const cocos2d::BlendFunc &getBlendFunc()')
    .func(nil, 'void setForceDepthWrite(bool value)')
    .func(nil, 'bool isForceDepthWrite()')
    .func(nil, 'void setCullFace(cocos2d::CullFaceSide side)')
    .func(nil, 'void setCullFaceEnabled(bool enable)')
    .func(nil, 'void setLightMask(unsigned int mask)')
    .func(nil, 'unsigned int getLightMask()')
    .func(nil, 'void setForce2DQueue(bool force2D)')
    .func(nil, 'const Vector<cocos2d::Mesh *> &getMeshes()')
    .func(nil, 'Sprite3D()')
    .func(nil, 'bool initWithFile(const std::string &path)')
    .func(nil, 'bool loadFromCache(const std::string &path)')
    .func(nil, 'void genMaterial(@optional bool useLight)')
    .func(nil, 'void addMesh(cocos2d::Mesh *mesh)')
    .func(nil, 'void onAABBDirty()')
    .func(nil, 'void afterAsyncLoad(void *param)')
    .callback {
        FUNCS =  {
            'static void createAsync(const std::string &modelPath, @local const std::function<void (Sprite3D *, void *)> &callback, void *callbackparam)',
            'static void createAsync(const std::string &modelPath, const std::string &texturePath, @local const std::function<void (Sprite3D *, void *)> &callback, void *callbackparam)'
        },
        TAG_MAKER = 'createAsync',
        TAG_MODE = 'OLUA_TAG_REPLACE',
        TAG_STORE = nil,
        TAG_SCOPE = 'object',
    }
    .prop('mesh', nil, nil)
    .prop('meshCount', nil, nil)
    .prop('skeleton', nil, nil)
    .prop('blendFunc', nil, nil)
    .prop('forceDepthWrite', nil, nil)
    .prop('lightMask', nil, nil)
    .prop('meshes', nil, nil)

typeconf 'cocos2d::AttachNode'
    .supercls('cocos2d::Node')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'static cocos2d::AttachNode *create(cocos2d::Bone3D *attachBone)')
    .func(nil, 'AttachNode()')

typeconf 'cocos2d::Bone3D'
    .supercls('cocos2d::Ref')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'const cocos2d::Mat4 &getInverseBindPose()')
    .func(nil, 'void updateWorldMat()')
    .func(nil, 'const cocos2d::Mat4 &getWorldMat()')
    .func(nil, 'const std::string &getName()')
    .func(nil, 'void clearBoneBlendState()')
    .func(nil, 'static cocos2d::Bone3D *create(const std::string &id)')
    .func(nil, 'void setInverseBindPose(const cocos2d::Mat4 &m)')
    .func(nil, 'void setOriPose(const cocos2d::Mat4 &m)')
    .func(nil, 'void resetPose()')
    .func(nil, 'cocos2d::Bone3D *getParentBone()')
    .func(nil, 'ssize_t getChildBoneCount()')
    .func(nil, 'cocos2d::Bone3D *getChildBoneByIndex(int index)')
    .func(nil, 'void addChildBone(cocos2d::Bone3D *bone)')
    .func(nil, 'void removeChildBoneByIndex(int index)')
    .func(nil, 'void removeChildBone(cocos2d::Bone3D *bone)')
    .func(nil, 'void removeAllChildBone()')
    .prop('inverseBindPose', nil, nil)
    .prop('worldMat', nil, nil)
    .prop('name', nil, nil)
    .prop('parentBone', nil, nil)
    .prop('childBoneCount', nil, nil)

typeconf 'cocos2d::Skeleton3D'
    .supercls('cocos2d::Ref')
    .reg_luatype(true)
    .chunk(nil)
    .require(nil)
    .func(nil, 'ssize_t getBoneCount()')
    .func(nil, 'cocos2d::Bone3D *getBoneByIndex(unsigned int index)')
    .func(nil, 'cocos2d::Bone3D *getBoneByName(const std::string &id)')
    .func(nil, 'ssize_t getRootCount()')
    .func(nil, 'cocos2d::Bone3D *getRootBone(int index)')
    .func(nil, 'int getBoneIndex(cocos2d::Bone3D *bone)')
    .func(nil, 'void updateBoneMatrix()')
    .func(nil, 'Skeleton3D()')
    .func(nil, 'void removeAllBones()')
    .func(nil, 'void addBone(cocos2d::Bone3D *bone)')
    .prop('boneCount', nil, nil)
    .prop('rootCount', nil, nil)
