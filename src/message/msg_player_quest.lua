
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.QuestListResponse] = function(tab)
    print("msg: QuestListResponse")
end


md[Opcode.MSG_SC_QuestOp] = function(tab)
    print("msg: MSG_SC_QuestOp")
end



md[Opcode.MSG_SC_QuestUpdate] = function(tab)
    print("msg: MSG_SC_QuestUpdate")
end
