
require "message.opcode"

local Event     = require "core.event"
local EventMgr  = require "core.event_mgr"

local md        = MessageDispatcher
local Opcode    = Opcode


md[Opcode.MSG_SC_ENTER_GAME] = function(tab)
    if tab.ErrorCode == 0 then
        EventMgr.Emit(Event.EnterGameOk)
    else
        EventMgr.Emit(Event.EnterGameFailed)
    end
end
