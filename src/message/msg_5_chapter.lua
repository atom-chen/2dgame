require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local PlayerChapter = require "model.player_chapter"


md[Opcode.MSG_SC_ChapterInfoResponse] = function(tab)
    print("msg:MSG_SC_ChapterInfoResponse")
    if tab.ErrorCode == 0 then
        PlayerChapter.Update(tab.Info)
    end
end


md[Opcode.MSG_SC_ChapterFightingResponse] = function(tab)
    print("msg:MSG_SC_ChapterFightingResponse")
    PlayBattle(tab.Br)
end


md[Opcode.MSG_SC_ChapterRewardsResponse] = function(tab)
    print("msg:MSG_SC_ChapterRewardsResponse")
    -- TODO
end


md[Opcode.MSG_SC_ChapterLootResponse] = function(tab)
    print("msg:MSG_SC_ChapterLootResponse")
end
