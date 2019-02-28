
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_ChapterInfo] = function(tab)
    print("msg: MSG_SC_ChapterInfo:", tab)
end

md[Opcode.MSG_SC_ChapterFighting] = function(tab)
    print("msg: MSG_SC_ChapterInfo:", tab)
end

md[Opcode.MSG_SC_ChapterRewards] = function(tab)
    print("msg: MSG_SC_ChapterRewards:", tab)
end

md[Opcode.MSG_SC_ChapterLoot] = function(tab)
    print("msg: MSG_SC_ChapterLoot:", tab)
end
