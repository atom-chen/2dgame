
require "message.opcode"

local Event     = require "core.event"
local EventMgr  = require "core.event_mgr"

local md        = MessageDispatcher
local Opcode    = Opcode

-- 登录
md[Opcode.MSG_SC_LOGIN] = function(tab)

    print("on MSG_SC_LOGIN", tab.error_code)

    if tab.error_code == 0 then
        EventMgr.EmitEvent(Event.LoginOK)
    else
        EventMgr.EmitEvent(Event.LoginFailed)
    end
end
