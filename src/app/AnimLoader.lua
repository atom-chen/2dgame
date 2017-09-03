
cc.exports.AnimLoader = {}


--[[
    ����֡����(moling��Դ)
    moling��Դ������cocos2dx��ͬ
--]]
function AnimLoader:loadFrame(name, number, interval)
    assert(false, "Don't use this function !")
    -- unusable
    --[[
    local url = string.format("anim_frame/%s/%s", name, name)
    local cache = cc.SpriteFrameCache:getInstance()
    cache:addSpriteFrames(url..".plist", url..".png")
    local frames = {}
    for i = 1, number do
        local frame_name = string.format('%s_%02d.png', name, i)
        frames[i] = cache:getSpriteFrame(frame_name)
    end
    local ani = cc.Animation:createWithSpriteFrames(frames, interval or 0.1)
    local spr = cc.Sprite:create()
    spr:setSpriteFrame(frames[1])
    spr:runAction(cc.RepeatForever:create(cc.Animate:create(ani)))
    return spr
    --]]
end


--[[
    -- armature�ද��(moling��Դ) 
--]]
function AnimLoader:loadArmature(name)
    local url = string.format("anim_armature/%s/%s", name, name)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(url ..".png", url..".plist", url..".json")
    local armature = ccs.Armature:create(name)
    armature:getAnimation():play("idle", -1, 1)
    return armature
end


--[[
    spine�ද��
    ���ع�������(moling��Դ����Ҫ��*.plist�����skinnedmesh --> linkedmesh) 
    cocos2dx��Դ����Ҫ�ر���
--]]
function AnimLoader:loadSpine(name)
    local url = string.format("anim_spine/%s/%s", name, name)
    local skeletonNode = sp.SkeletonAnimation:create(url..".json", url..".atlas")
    if skeletonNode:findAnimation("idle") then
        skeletonNode:setAnimation(0, "idle", true)
    end
    return skeletonNode
end
