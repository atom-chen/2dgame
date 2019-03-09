require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local PlayerHero = require "model.player_hero"


md[Opcode.MSG_SC_PingResponse] = function(tab)
    print("msg:MSG_SC_PingResponse", tab.Time)
end


md[Opcode.MSG_SC_LoginResponse] = function(tab)
    print("msg:MSG_SC_LoginResponse", tab.ErrorCode)
    
    if tab.ErrorCode == 0 then
        EventMgr.Emit(Event.LoginOK)
    else
        EventMgr.Emit(Event.LoginFailed)
    end
end


md[Opcode.MSG_SC_EnterGameResponse] = function(tab)
    print("msg:MSG_SC_EnterGameResponse")
    
    if tab.ErrorCode == 0 then
        EventMgr.Emit(Event.EnterGameOk)
    else
        EventMgr.Emit(Event.EnterGameFailed)
    end
end
