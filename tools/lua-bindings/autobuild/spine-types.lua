-- AUTO BUILD, DON'T MODIFY!

local olua = require "olua"
local typedef = olua.typedef

typedef {
    CONV = 'olua_$$_int',
    CPPCLS = 'spine::PropertyId',
    DECLTYPE = 'lua_Integer',
}

typedef {
    CONV = 'olua_$$_spine_String',
    CPPCLS = 'spine::String',
}

typedef {
    CONV = 'olua_$$_spine_EventData',
    CPPCLS = 'spine::EventData',
}

typedef {
    CONV = 'olua_$$_spine_Color',
    CPPCLS = 'spine::Color',
}

typedef {
    CONV = 'olua_$$_spine_Vector',
    CPPCLS = 'spine::Vector',
}

typedef {
    CPPCLS = 'spine::EventType',
    LUACLS = 'sp.EventType',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::AttachmentType',
    LUACLS = 'sp.AttachmentType',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::TransformMode',
    LUACLS = 'sp.TransformMode',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::BlendMode',
    LUACLS = 'sp.BlendMode',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PositionMode',
    LUACLS = 'sp.PositionMode',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SpacingMode',
    LUACLS = 'sp.SpacingMode',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RotateMode',
    LUACLS = 'sp.RotateMode',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::MixBlend',
    LUACLS = 'sp.MixBlend',
    DECLTYPE = "lua_Unsigned",
    CONV = 'olua_$$_uint',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SpineObject *',
    LUACLS = 'sp.SpineObject',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Event *',
    LUACLS = 'sp.Event',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::EventData *',
    LUACLS = 'sp.EventData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Updatable *',
    LUACLS = 'sp.Updatable',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::AnimationStateListener',
    LUACLS = 'sp.AnimationStateListener',
    DECLTYPE = 'std::function<void (spine::AnimationState *, spine::EventType, spine::TrackEntry *, spine::Event *)>',
    CONV = 'olua_$$_spine_AnimationStateListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::AnimationState *',
    LUACLS = 'sp.AnimationState',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::AnimationStateData *',
    LUACLS = 'sp.AnimationStateData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Animation *',
    LUACLS = 'sp.Animation',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::ConstraintData *',
    LUACLS = 'sp.ConstraintData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::IkConstraintData *',
    LUACLS = 'sp.IkConstraintData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::BoneData *',
    LUACLS = 'sp.BoneData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SlotData *',
    LUACLS = 'sp.SlotData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::IkConstraint *',
    LUACLS = 'sp.IkConstraint',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::TransformConstraint *',
    LUACLS = 'sp.TransformConstraint',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::TransformConstraintData *',
    LUACLS = 'sp.TransformConstraintData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PathConstraintData *',
    LUACLS = 'sp.PathConstraintData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SkeletonBounds *',
    LUACLS = 'sp.SkeletonBounds',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SkeletonClipping *',
    LUACLS = 'sp.SkeletonClipping',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Timeline *',
    LUACLS = 'sp.Timeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::CurveTimeline *',
    LUACLS = 'sp.CurveTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::CurveTimeline1 *',
    LUACLS = 'sp.CurveTimeline1',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::CurveTimeline2 *',
    LUACLS = 'sp.CurveTimeline2',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::AttachmentTimeline *',
    LUACLS = 'sp.AttachmentTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RGBATimeline *',
    LUACLS = 'sp.RGBATimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RGBTimeline *',
    LUACLS = 'sp.RGBTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::AlphaTimeline *',
    LUACLS = 'sp.AlphaTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RGBA2Timeline *',
    LUACLS = 'sp.RGBA2Timeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RGB2Timeline *',
    LUACLS = 'sp.RGB2Timeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::DeformTimeline *',
    LUACLS = 'sp.DeformTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::DrawOrderTimeline *',
    LUACLS = 'sp.DrawOrderTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::EventTimeline *',
    LUACLS = 'sp.EventTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::IkConstraintTimeline *',
    LUACLS = 'sp.IkConstraintTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PathConstraintMixTimeline *',
    LUACLS = 'sp.PathConstraintMixTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PathConstraintPositionTimeline *',
    LUACLS = 'sp.PathConstraintPositionTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PathConstraintSpacingTimeline *',
    LUACLS = 'sp.PathConstraintSpacingTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::TranslateTimeline *',
    LUACLS = 'sp.TranslateTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::ShearTimeline *',
    LUACLS = 'sp.ShearTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::TransformConstraintTimeline *',
    LUACLS = 'sp.TransformConstraintTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::ScaleTimeline *',
    LUACLS = 'sp.ScaleTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RotateTimeline *',
    LUACLS = 'sp.RotateTimeline',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::VertexEffect *',
    LUACLS = 'sp.VertexEffect',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SwirlVertexEffect *',
    LUACLS = 'sp.SwirlVertexEffect',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::JitterVertexEffect *',
    LUACLS = 'sp.JitterVertexEffect',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Polygon *',
    LUACLS = 'sp.Polygon',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Skin *',
    LUACLS = 'sp.Skin',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Atlas *',
    LUACLS = 'sp.Atlas',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Bone *',
    LUACLS = 'sp.Bone',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Slot *',
    LUACLS = 'sp.Slot',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Attachment *',
    LUACLS = 'sp.Attachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::VertexAttachment *',
    LUACLS = 'sp.VertexAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::ClippingAttachment *',
    LUACLS = 'sp.ClippingAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::BoundingBoxAttachment *',
    LUACLS = 'sp.BoundingBoxAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::MeshAttachment *',
    LUACLS = 'sp.MeshAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PathAttachment *',
    LUACLS = 'sp.PathAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PathConstraint *',
    LUACLS = 'sp.PathConstraint',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::PointAttachment *',
    LUACLS = 'sp.PointAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::RegionAttachment *',
    LUACLS = 'sp.RegionAttachment',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::TrackEntry *',
    LUACLS = 'sp.TrackEntry',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SkeletonData *',
    LUACLS = 'sp.SkeletonData',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::Skeleton *',
    LUACLS = 'sp.Skeleton',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SkeletonRenderer *',
    LUACLS = 'sp.SkeletonRenderer',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::StartListener',
    LUACLS = 'sp.StartListener',
    DECLTYPE = 'std::function<void (spine::TrackEntry *)>',
    CONV = 'olua_$$_spine_StartListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::InterruptListener',
    LUACLS = 'sp.InterruptListener',
    DECLTYPE = 'std::function<void (spine::TrackEntry *)>',
    CONV = 'olua_$$_spine_InterruptListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::EndListener',
    LUACLS = 'sp.EndListener',
    DECLTYPE = 'std::function<void (spine::TrackEntry *)>',
    CONV = 'olua_$$_spine_EndListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::DisposeListener',
    LUACLS = 'sp.DisposeListener',
    DECLTYPE = 'std::function<void (spine::TrackEntry *)>',
    CONV = 'olua_$$_spine_DisposeListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::CompleteListener',
    LUACLS = 'sp.CompleteListener',
    DECLTYPE = 'std::function<void (spine::TrackEntry *)>',
    CONV = 'olua_$$_spine_CompleteListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::EventListener',
    LUACLS = 'sp.EventListener',
    DECLTYPE = 'std::function<void (spine::TrackEntry *, spine::Event *)>',
    CONV = 'olua_$$_spine_EventListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::UpdateWorldTransformsListener',
    LUACLS = 'sp.UpdateWorldTransformsListener',
    DECLTYPE = 'std::function<void (spine::SkeletonAnimation *)>',
    CONV = 'olua_$$_spine_UpdateWorldTransformsListener',
    NUM_VARS = nil,
}

typedef {
    CPPCLS = 'spine::SkeletonAnimation *',
    LUACLS = 'sp.SkeletonAnimation',
    DECLTYPE = nil,
    CONV = 'olua_$$_cppobj',
    NUM_VARS = nil,
}

