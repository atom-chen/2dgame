
require "message.opcode"

local Event     = require "core.event"
local EventMgr  = require "core.event_mgr"

local md        = MessageDispatcher
local Opcode    = Opcode

-- ping response
md[Opcode.MSG_SC_ENTER_GAME] = function(tab)
    if tab.error_code == 0 then
        EventMgr.EmitEvent(Event.EnterGameOk)
    else
        EventMgr.EmitEvent(Event.EnterGameFailed)
    end
end
