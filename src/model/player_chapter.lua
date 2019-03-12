local config        = require "configs_grace"

local _chapter      = {}
local PlayerChapter = NewModel({_model_name="PlayerChapter"})

---------------------------------------------------------------------------------

function PlayerChapter:Clear()
    _chapter =
    {
        LootTs   = 0,   -- 上次领取挂机奖励的时间
	    BreakId  = 0,   -- 当前已完成的关卡ID
	    Chapters = {},  -- 已领过奖励的章节ID
    }
end

-- update from server
function PlayerChapter:Update(info)
    _chapter.LootTs  = info.LootTs
    _chapter.BreakId = info.BreakId
    for _, v in pairs(info.Chapters) do
        table.insert(_chapter.Chapters, v)
        print("info.Chapters:", v)
    end

    print("_chapter:", _chapter.LootTs, _chapter.BreakId)
end

function PlayerChapter:Data()
    return _chapter
end

-------------------------------------------------------------------------------
PlayerChapter:Clear()

return PlayerChapter
