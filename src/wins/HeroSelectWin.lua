local Armature      = require "core.armature"
local config        = require "configs_grace"
local PlayerHero    = require "model.player_hero"
local WinBase       = require "core.WinBase"



local function item_on_touch(event)
    local item = event.target
    if event.name == "ended" then
        item.owner:OnSelected(item)
    end
end


local HeroSelectWin = class("HeroSelectWin", WinBase)

function HeroSelectWin:ctor(selected, onOK)
    WinBase.ctor(self)

    self.selected_hero_id = 0

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/hero_select.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)        


    local btn = self.resourceNode_:getChildByName("btnSet")
    btn:addClickEventListener(function()
        onOK(self.selected_hero_id)
        self:Close()
    end)

    local btn = self.resourceNode_:getChildByName("btnCancel")
    btn:addClickEventListener(function()
        onOK(0)
        self:Close()
    end)

    local btn = self.resourceNode_:getChildByName("btnClose")
    btn:addClickEventListener(function()
        self:Close()
    end)

    local list = self.resourceNode_:getChildByName("ListView_1")
    self.list = list

    for i, tab in pairs(PlayerHero.GetHeros()) do
        if not table.exist_val(i, selected) then
            local widget = ccui.Widget:create()
            widget:setContentSize(cc.size(400,400))
            widget:setAnchorPoint(display.LEFT_BOTTOM)

            local bg = ccui.ImageView:create("public_item_bg.png")
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
end


function HeroSelectWin:OnSelected(item)
    self.selected_hero_id = item.heroid
end


function HeroSelectWin:OnCreate()
end


function HeroSelectWin:OnDestroy()
    PlayerHero.UnRegister(self)
end


function HeroSelectWin:OnShow()
end


function HeroSelectWin:OnHiden()
end

---------------------------------------------------------


return HeroSelectWin
