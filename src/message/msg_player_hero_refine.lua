
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_HeroRefine] = function(tab)
    if tab.error_code ~= 0 then
        print("精炼错误！", tab.error_code)
    else
        print("精炼是否成功:", tab.result)
        if tab.result == 1 then
            local v = tab.Hero
            local hero = PlayerHero.GetHero(v.id)
            hero:Init(v)
        end
    end
end
