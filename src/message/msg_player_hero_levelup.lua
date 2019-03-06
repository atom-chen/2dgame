
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"
local PlayerHero = require "model.player_hero"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_HeroLevelup] = function(tab)
    if tab.ErrorCode == 0 then
        print("英雄升级成功:", tab.ErrorCode)
    else
        print("英雄升级失败:", tab.ErrorCode)
    end
end
