
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local conf_quest    = require "configs_json.quest"
local config        = require "configs_grace"

local PlayerQuest   = require "model.player_quest"

local MapUnit       = require "wins.MapUnit"


-------------------------------------------------------------------------------

local NpcMenuWin    = class("NpcMenuWin", WinBase)


function NpcMenuWin:ctor(...)
    WinBase.ctor(self)

    local width  = 800
    local height = 540

    local bg = ccui.Scale9Sprite:create("bg_scale9.png")
    bg:setCapInsets(cc.rect(6, 6, 52, 52))

    bg:setContentSize(cc.size(width, height))
    self:addChild(bg)

    self:setContentSize(cc.size(width, height))

    self._text = cc.Label:createWithSystemFont("", "Arial", 20)
    self._text:setColor(cc.RED)
    self._text:setPosition(80, 160)
    self:addChild(self._text)

    -- listview
    self.list = ccui.ListView:create()
    self.list:setContentSize(180, 400)
    self.list:setPosition(-300, -70)
    self.list:setDirection(ccui.ListViewDirection.vertical)
    self.list:setItemsMargin(0)
    self.list:setBounceEnabled(true)
    self.list:setInertiaScrollEnabled(true)
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

    -- 创建npc
    self._npc = MapUnit:create(npcconf, self)
    self._npc._root:setPosition(-300, 120)
    self:addChild(self._npc._root)

    local n = #npcconf.param3
    if n > 0 then
        n = math.random(n)
        self._text:setString(npcconf.param3[n])
    end

    -- 寻找可以接的任务
    local qs = {}

    local quests = conf_quest.GetNpcQuests(npcid)
    for _, q in pairs(quests or {}) do
        if PlayerQuest:Acceptable(q) then
            table.insert(qs, {q.title, 1})
        end
    end

    print("quest count", #qs)


    -- 寻找可由交的任务
    -- assert(conf, "NpcMenuWin:ShowMap:npcid" .. tostring(npcid))

    self.npcid = npcid

    -- 添加到列表框供选择

    self.list:pushBackCustomItem("这里添加需要加入的子节点")

    for i = 1, 3 do
        local widget = ccui.Widget:create()
            widget:setContentSize(cc.size(400,400))
            widget:setAnchorPoint(display.LEFT_BOTTOM)

            local bg = cc.Sprite:create("bg.jpg")

            bg:setScale9Enabled(true)
            bg:ignoreContentAdaptWithSize(false)
            bg:setCapInsets(cc.rect(40, 30, 2, 2))
            bg:setContentSize(400, 400)
            bg:setAnchorPoint(display.LEFT_BOTTOM)

            widget:addChild(bg)

            list:pushBackCustomItem(widget)

            local arm = Armature:create(tab.proto.model)
            arm:setPosition(200, 100)
            widget:addChild(arm)

            widget:setTouchEnabled(true)
            widget.owner = self
            widget.heroid = i
            widget:onTouch(item_on_touch)
    end
end



return NpcMenuWin