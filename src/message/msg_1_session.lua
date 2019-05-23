require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local PlayerHero = require "model.player_hero"


local function MSG_SC_PingResponse(tab)
    print("msg:MSG_SC_PingResponse", tab.Time)
end
md[Opcode.MSG_SC_PingResponse] = MSG_SC_PingResponse


local function MSG_SC_LoginResponse(tab)
    print("msg:MSG_SC_LoginResponse", tab.ErrorCode)

    if tab.ErrorCode == 0 then
        EventMgr.Emit(Event.LoginOK)
    else
        EventMgr.Emit(Event.LoginFailed)
    end
end
md[Opcode.MSG_SC_LoginResponse] = MSG_SC_LoginResponse
