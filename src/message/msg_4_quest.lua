require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_QuestListResponse] = function(tab)
    print("msg:MSG_SC_QuestListResponse")
    -- TODO
end


md[Opcode.MSG_SC_QuestOpResponse] = function(tab)
    print("msg:MSG_SC_QuestOpResponse")
    -- TODO
end


md[Opcode.MSG_SC_QuestUpdate] = function(tab)
    print("msg:MSG_SC_QuestUpdate")
    -- TODO
end
