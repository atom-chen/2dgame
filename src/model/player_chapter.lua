
local config        = require "configs_grace"


local _chapter      = {}
local PlayerChapter = {}


---------------------------------------------------------------------------------

function PlayerChapter.Clear()
    _chapter =
    {
        LootTs   = 0,   -- 上次领取挂机奖励的时间
	    BreakId  = 0,   -- 当前已完成的关卡ID
	    Chapters = {},  -- 已领过奖励的章节ID
    }
end

-- update from server
function PlayerChapter.MsgUpdate(tab)
    print("dddddd", tab)
    for k, v in pairs(tab.Info) do
        print("item", k, v)
    end
end

-------------------------------------------------------------------------------
PlayerChapter.Clear()

return PlayerChapter
