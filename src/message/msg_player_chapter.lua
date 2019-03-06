
require "message.opcode"

local Event             = require "core.event"
local EventMgr          = require "core.event_mgr"
local PlayerChapter     = require "model.player_chapter"


local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_ChapterInfo] = function(tab)
    if tab.ErrorCode == 0 then
        PlayerChapter.Update(tab.Info)
    end
end

md[Opcode.MSG_SC_ChapterFighting] = function(tab)
    print("msg: MSG_SC_ChapterFighting:", tab.ErrorCode)
end

md[Opcode.MSG_SC_ChapterRewards] = function(tab)
    print("msg: MSG_SC_ChapterRewards:", tab)
end

md[Opcode.MSG_SC_ChapterLoot] = function(tab)
    print("msg: MSG_SC_ChapterLoot:", tab)
end
