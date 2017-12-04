
local ToolbarUI = class("ToolbarUI", BaseUI)


function ToolbarUI:ctor()
    print("ToolbarUI:ctor")
end


------------------------------ inhert from BaseUI ------------------------------
function ToolbarUI:on_init()
    local skeletonNode = AnimLoader:loadSpine("biaoche5")
    skeletonNode:setAnimation(0, "walk", true)
    -- local skeletonNode = AnimLoader:loadSpine("spineboy")
    skeletonNode:setPosition(cc.p(0, 0))
    self._panel:addChild(skeletonNode)

    local armature = AnimLoader:loadArmature("caocao")
    armature:getAnimation():play('skill2', -1, 1)
    armature:setPosition(cc.p(240, 150))
    self._panel:addChild(armature)

    local times = 0
    local function _on_timer()
        print("on timer", times)
        SocketMgr:send(times, {"fuckyou"})
        times = times + 1
    end

    -- test 
    local particle = cc.ParticleSystemQuad:create("particle/getitem.plist")
    particle:setPositionType(cc.POSITION_TYPE_RELATIVE)
    particle:setPosition(cc.p(360,0))
    self._panel:addChild(particle)

    local s = self._panel:getScheduler()
    self.timer_id = s:scheduleScriptFunc(_on_timer, 1, false)
end


function ToolbarUI:on_release()
    print("ToolbarUI:on_release")
    self._panel:getScheduler():unscheduleScriptEntry(self.timer_id)
end


function ToolbarUI:on_show()
    print("ToolbarUI:on_show")
end


function ToolbarUI:on_hide()
    print("ToolbarUI:on_hide")
end


return ToolbarUI
