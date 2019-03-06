
require "message.opcode"

local Event     = require "core.event"
local EventMgr  = require "core.event_mgr"

local md        = MessageDispatcher
local Opcode    = Opcode

-- 登录
md[Opcode.MSG_SC_LOGIN] = function(tab)
    print("on MSG_SC_LOGIN", tab.ErrorCode)

    if tab.ErrorCode == 0 then
        EventMgr.Emit(Event.LoginOK)
    else
        EventMgr.Emit(Event.LoginFailed)
    end
end
