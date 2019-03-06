
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_HeroRefine] = function(tab)
    if tab.ErrorCode ~= 0 then
        print("精炼失败！", tab.ErrorCode)
    else
        print("精炼完成：是否成功:", tab.result)
    end
end
