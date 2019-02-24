
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

    local width  = 200
    local height = 100

    local bg = ccui.Scale9Sprite:create("bg_scale9.png")
    bg:setCapInsets(cc.rect(6, 6, 52, 52))

    -- bg:setContentSize(cc.size(display.width, display.height))
    bg:setContentSize(cc.size(width, height))
    self:addChild(bg)

    self:setContentSize(cc.size(width, height))

    self._text = cc.Label:createWithSystemFont("x", "Arial", 20)
    self._text:setColor(cc.RED)
    self._text:setPosition(0, 0)
    self:addChild(self._text)
end


------------------------------ inhert from WinBase ----------------------------

function NpcMenuWin:OnCreate()
    print("NpcMenuWin:OnCreate")
end


function NpcMenuWin:OnDestroy()
    print("NpcMenuWin:OnDestroy")
end


function NpcMenuWin:OnShow(npcid)
    print("NpcMenuWin:OnShow")
    self:Show(npcid)
end


function NpcMenuWin:OnHiden()
    print("NpcMenuWin:OnHiden")
end

function NpcMenuWin:OnTouch(innor)
    print("NpcMenuWin:OnTouch", innor)
    if not innor then
        self:Close()
    end
end

-------------------------------------------------------------------------------

function NpcMenuWin:Show(npcid)
    local npcconf = config.GetObject(npcid)
    if not npcconf then
        return
    end

    local n = #npcconf.param3
    if n > 0 then
        n = math.random(n)
        self._text:setString(npcconf.param3[n])
    end

    -- 寻找可以接的任务
    local qs = {}

    local quests = conf_quest.GetNpcQuests(npcid)
    for _, q in pairs(quests or {}) do
        if PlayerQuest.Acceptable(q) then
            table.insert(qs, {q.title, 1})
        end
    end

    print("quest count", #qs)


    -- 寻找可由交的任务
    -- assert(conf, "NpcMenuWin:ShowMap:npcid" .. tostring(npcid))

    self.npcid = npcid

    -- 添加到列表框供选择

end



return NpcMenuWin