
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"

local ToolbarWin    = class("ToolbarWin", WinBase)


function ToolbarWin:ctor()
    print("ToolbarWin:ctor")
end


------------------------------ inhert from WinBase ------------------------------

function ToolbarWin:OnCreate()
    local skeletonNode = AnimLoader:loadSpine("biaoche5")
    skeletonNode:setAnimation(0, "walk", true)
    -- local skeletonNode = AnimLoader:loadSpine("spineboy")
    skeletonNode:setPosition(cc.p(0, -300))
    self:addChild(skeletonNode)
    skeletonNode:setScaleX(-1)

    local armature = AnimLoader:loadArmature("caocao")
    armature:getAnimation():play('skill2', -1, 1)
    armature:setPosition(cc.p(240, 150))

    self:addChild(armature)

    local times = 0
    local function _on_timer()
        print("on timer", times)
        times = times + 1
        local r = math.random(0x1000)
        Socket.SendPacket(Opcode.MSG_CS_PING, {
            time = r
        }, function(tab)
            print("ping response:", r, tab.time)
            table.print(tab)
        end)
    end

    -- test
    local particle = cc.ParticleSystemQuad:create("particle/getitem.plist")
    particle:setPositionType(cc.POSITION_TYPE_RELATIVE)
    particle:setPosition(cc.p(360,0))
    self:addChild(particle)

    local s = self:getScheduler()
    self.timer_id = s:scheduleScriptFunc(_on_timer, 1, false)
end


function ToolbarWin:OnDestroy()
    print("ToolbarWin:OnDestroy")
    self:getScheduler():unscheduleScriptEntry(self.timer_id)
end


function ToolbarWin:OnShow()
    print("ToolbarWin:OnShow")
end


function ToolbarWin:OnHiden()
    print("ToolbarWin:OnHiden")
end


return ToolbarWin
