
--[[
    -- armature类动画(moling资源)
    异步加载暂时不处理
--]]


local function __movement_event_callback(arm, eventType, movementID)
    if eventType == 1 then -- ccs.MovementEventType.complete
        if arm._callback then
            arm._callback()
            arm._callback = nil
        end
        arm:Play("idle")
    end
end


local Armature = class("Armature", function(name, action)
    local url = string.format("anim_armature/%s/%s", name, name)
    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(url ..".png", url..".plist", url..".json")
    local arm = ccs.Armature:create(name)
    local animation = arm:getAnimation()
    animation:setMovementEventCallFunc(__movement_event_callback)
    if not action then
        action = "idle"
    end
    animation:play(action, -1, 0)
    arm._animation = animation
    return arm
end)


function Armature:ctor(name, action)
end


function Armature:Play(action, loop, callback)
    loop = (loop and 1) or 0
    if action == "idle" then
        self._idle = true
    else
        self._idle = false
    end
    self._animation:play(action, -1, loop)
    self._callback = callback
end


function Armature:PlayHit()
    if self._idle then
        self:Play("hit")
    end
end


return Armature