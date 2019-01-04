
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"


local PlayerQuest   = require "model.player_quest"


local conf_quest    = require "configs_json.quest"


-------------------------------------------------------------------------------

local NpcMenuWin    = class("NpcMenuWin", WinBase)


function NpcMenuWin:ctor()
    WinBase.ctor(self)
end


------------------------------ inhert from WinBase ----------------------------

function NpcMenuWin:OnCreate(npcid)
    self:Show(npcid)
end


function NpcMenuWin:OnDestroy()
    print("NpcMenuWin:OnDestroy")
end


function NpcMenuWin:OnShow()
    print("NpcMenuWin:OnShow")
end


function NpcMenuWin:OnHiden()
    print("NpcMenuWin:OnHiden")
end

-------------------------------------------------------------------------------

function NpcMenuWin:Show(npcid)
    local qs = {}
    local quests = conf_quest.GetNpcQuests(npcid)

    for _, q in pairs(quests or {}) do
        if PlayerQuest.Acceptable(q) then
            table.insert(qs, q)
        end
    end

    -- 寻找可以接的任务

    -- 寻找可由交的任务

    assert(conf, "NpcMenuWin:ShowMap:npcid" .. tostring(npcid))

    self.npcid = npcid

    -- 添加到列表框供选择

    return true
end



return NpcMenuWin
