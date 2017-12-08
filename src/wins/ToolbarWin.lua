
local WinBase = require("core/WinBase")
local ToolbarWin = class("ToolbarWin", WinBase)


function ToolbarWin:ctor()
    print("ToolbarWin:ctor")
end


------------------------------ inhert from WinBase ------------------------------

function ToolbarWin:OnCreate()
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


function ToolbarWin:OnDestroy()
    print("ToolbarWin:OnDestroy")
    self._panel:getScheduler():unscheduleScriptEntry(self.timer_id)
end


function ToolbarWin:OnShow()
    print("ToolbarWin:OnShow")
end


function ToolbarWin:OnHiden()
    print("ToolbarWin:OnHiden")
end


return ToolbarWin
