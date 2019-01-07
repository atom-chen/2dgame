
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local conf_quest    = require "configs_json.quest"
local config        = require "configs_grace"

local PlayerQuest   = require "model.player_quest"

-------------------------------------------------------------------------------

local NpcMenuWin    = class("NpcMenuWin", WinBase)


function NpcMenuWin:ctor(...)
    WinBase.ctor(self)

    self:setContentSize(cc.size(200,120))

    self._text = cc.Label:createWithSystemFont("1111111111111", "Arial", 20)
    self._text:setColor(cc.RED)
    self._text:setPosition(0, 0)
    self:addChild(self._text)
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

function NpcMenuWin:OnTouch(innor)
    if not innor then
        WinManager:ShowWindow(1, true)
    end
end

-------------------------------------------------------------------------------

function NpcMenuWin:Show(npcid)
    local npcconf = config.GetObject(npcid)
    if not npcconf then
        return
    end

    local n = #npcconf.def_text
    if n > 0 then
        n = math.random(n)
        self._text:setString(npcconf.def_text[n])
    end

    -- 寻找可以接的任务
    local qs = {}

    local quests = conf_quest.GetNpcQuests(npcid)
    for _, q in pairs(quests or {}) do
        if PlayerQuest.Acceptable(q) then
            table.insert(qs, {q.title, 1})
        end
    end

    -- 寻找可由交的任务

    assert(conf, "NpcMenuWin:ShowMap:npcid" .. tostring(npcid))

    self.npcid = npcid

    -- 添加到列表框供选择

end



return NpcMenuWin
