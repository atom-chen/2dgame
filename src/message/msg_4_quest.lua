require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local function MSG_SC_QuestListResponse(tab)
    print("msg:MSG_SC_QuestListResponse")
    -- TODO
end
md[Opcode.MSG_SC_QuestListResponse] = MSG_SC_QuestListResponse


local function MSG_SC_QuestOpResponse(tab)
    print("msg:MSG_SC_QuestOpResponse")
    -- TODO
end
md[Opcode.MSG_SC_QuestOpResponse] = MSG_SC_QuestOpResponse


local function MSG_SC_QuestUpdate(tab)
    print("msg:MSG_SC_QuestUpdate")
    -- TODO
end
md[Opcode.MSG_SC_QuestUpdate] = MSG_SC_QuestUpdate
