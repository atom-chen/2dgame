
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_MarketBuy] = function(tab)
    print("集市购买结果:", tab.ErrorCode)
end
