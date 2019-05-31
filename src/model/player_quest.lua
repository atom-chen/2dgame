local const         = require "const"
local conf_quest    = require "config.quest"

local _quests       = {}
local PlayerQuest   = NewModel({_model_name="PlayerQuest"})

-------------------------------------------------------------------------------

local new_quest = function(id)
    local q =
    {
        id     = id,    -- 任务ID
        task   = 1,     -- // 当前的task项   0:表示已完成所有的task项
        data   = {}     -- 任务项数据
    }

    return q
end


-- 检测任务条件是否满足
local quest_cond_check = function(cond)

    if cond.type == const.CondiType_Lv then
        -- do with cond.args
    elseif cond.type == const.CondiType_Sex then

    elseif cond.type == const.CondiType_DailyDur then

    elseif cond.type == const.CondiType_WeeklyDur then

    end

    return true
end

-------------------------------------------------------------------------------

function PlayerQuest:Clear()
    _quests =
    {
        lastId      = 0,        -- 上一个完成的任务(主线)
        main        = nil,      -- 主线任务
	    forture     = nil,      -- 奇遇任务
    }
end

-- 任务同步
function PlayerQuest:UpdateQuest(q)

end

-- 任务是否可接
function PlayerQuest:Acceptable(qconf)
    local pass = false

    repeat
        if qconf.type == 1 then         -- 主线
            if _quests.main then
                break
            end
            if qconf.id <= _quests.lastId then
                break
            end
            pass = true
        elseif qconf.type == 2 then     -- 奇遇
            if _quests.forture then
                break
            end
            pass = true
        end
    until true

    if not pass then return false end

    -- 是否满足条件
    for _, v in pairs(qconf.conds) do
        if not quest_cond_check(v) then
            return false
        end
    end

    return true
end

-------------------------------------------------------------------------------
PlayerQuest:Clear()

return PlayerQuest
