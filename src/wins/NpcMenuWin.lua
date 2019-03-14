
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
    self._text:setPosition(80, 180)
    self:addChild(self._text)

    -- listview
    self.list = ccui.ListView:create()
    self.list:setContentSize(200, 360)
    self.list:setPosition(-320, -260)
    self.list:setDirection(ccui.ListViewDirection.vertical)
    self.list:setItemsMargin(0)
    self.list:setBounceEnabled(true)
    self.list:setInertiaScrollEnabled(true)

    self:addChild(self.list)

    -- 接收任务
    local button
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("接受任务")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(130, -230)
    button:addClickEventListener(handler(self, self.on_btn_ok))
    self:addChild(button)
    self.btn_ok = button

    -- 放弃任务
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("放弃任务")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(300, -230)
    button:addClickEventListener(handler(self, self.on_btn_cancel))
    self:addChild(button)
    self.btn_cancel = button

    local str = "sdfasdfasdlkfjqweofjasdofjapsoweofjasdofjapsodvgfapsodivfnapsodfjapwoeifapsodfnawpoefaW"
    local detail = cc.Label:create()
    detail:setPosition(cc.p(150, -100))
    detail:setContentSize(400, 300)
    detail:setDimensions(400, 300)
    detail:setString(str)
    detail:setColor(cc.YELLOW)
    self:addChild(detail)
    self.detail = detail
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

local function item_on_touch(event)
    local item = event.target
    if event.name == "ended" then
        item.owner:OnSelected(item)
    end
end


function NpcMenuWin:Show(npcid)
    local npcconf = config.GetObject(npcid)
    if not npcconf then
        return
    end

    -- 创建npc
    self._npc = MapUnit:create(npcconf, self)
    self._npc._root:setPosition(-300, 160)
    self:addChild(self._npc._root)

    local n = #npcconf.param3
    if n > 0 then
        n = math.random(n)
        self._text:setString(npcconf.param3[n])
    end

    -- 寻找可以接的任务
    local qs = {}

    local quests = conf_quest.GetNpcQuests(1001)    -- npcid
    for _, q in pairs(quests or {}) do
        if PlayerQuest:Acceptable(q) then
            table.insert(qs, {q.title, 1})
        end
    end

    print("quest count:", #qs)


    -- 寻找可由交的任务
    -- assert(conf, "NpcMenuWin:ShowMap:npcid" .. tostring(npcid))


    -- 添加到列表框供选择
    self.npcid = npcid
    self.quests = qs

    local n = #qs
    for i = 1, n do
        local widget = ccui.Widget:create()
        widget:setContentSize(cc.size(160,60))
        widget:setAnchorPoint(display.LEFT_BOTTOM)

        local bg = ccui.ImageView:create("bg_scale9.png")
        bg:setScale9Enabled(true)
        bg:ignoreContentAdaptWithSize(false)
        bg:setCapInsets(cc.rect(40, 30, 2, 2))
        bg:setContentSize(160, 60)
        bg:setAnchorPoint(display.LEFT_BOTTOM)
        widget:addChild(bg)

        local title = cc.Label:createWithSystemFont(qs[i][1], "Arial", 18)
        title:setPosition(80, 30)
        widget:addChild(title)

        widget.idx = i
        widget.owner = self
        widget:setTouchEnabled(true)
        widget:onTouch(item_on_touch)

        self.list:pushBackCustomItem(widget)
    end
end

function NpcMenuWin:OnSelected(item)
    if self.curr_item == item then
        return
    end

    print("selected:", item.idx)
end


function NpcMenuWin:on_btn_ok()

end

function NpcMenuWin:on_btn_cancel()

end

-------------------------------------------------------------------------------
return NpcMenuWin