
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local ToolbarWin    = class("ToolbarWin", WinBase)


function ToolbarWin:ctor()
    -- WinBase.ctor(self)
end


------------------------------ inhert from WinBase ------------------------------

function ToolbarWin:OnCreate()
    local skeletonNode = AnimLoader:loadSpine("zhandoukaishi")
    skeletonNode:setAnimation(0, "idle2", true)
    -- local skeletonNode = AnimLoader:loadSpine("spineboy")
    skeletonNode:setPosition(cc.p(0, -200))
    self:addChild(skeletonNode)
    skeletonNode:setScaleX(-1)

    local arm = Armature:create("caocao", "attack")
    arm:setPosition(cc.p(240, 150))
    self:addChild(arm)

    local times = 0
    local function _on_timer()
        times = times + 1
        local r = math.random(0x1000)
        Socket.SendPacket(Opcode.MSG_CS_PING, {
            time = r
        }, function(tab)
            -- print("ping response:", times, r, tab.time)
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
