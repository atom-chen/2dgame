require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local PlayerChapter = require "model.player_chapter"


local function MSG_SC_ChapterInfoResponse(tab)
    print("msg:MSG_SC_ChapterInfoResponse")
    if tab.ErrorCode == 0 then
        PlayerChapter.Update(tab.Info)
    end
end
md[Opcode.MSG_SC_ChapterInfoResponse] = MSG_SC_ChapterInfoResponse


local function MSG_SC_ChapterFightingResponse(tab)
    print("msg:MSG_SC_ChapterFightingResponse")
    PlayBattle(tab.Br)
end
md[Opcode.MSG_SC_ChapterFightingResponse] = MSG_SC_ChapterFightingResponse


local function MSG_SC_ChapterRewardsResponse(tab)
    print("msg:MSG_SC_ChapterRewardsResponse")
    -- TODO
end
md[Opcode.MSG_SC_ChapterRewardsResponse] = MSG_SC_ChapterRewardsResponse


local function MSG_SC_ChapterLootResponse(tab)
    print("msg:MSG_SC_ChapterLootResponse")
    -- TODO
end
md[Opcode.MSG_SC_ChapterLootResponse] = MSG_SC_ChapterLootResponse
