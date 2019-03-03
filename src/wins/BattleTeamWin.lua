local WinBase       = require "core.WinBase"
local PlayerItem    = require "model.player_item"
local config        = require "configs_grace"


------------------------------------------------------------------------------------

local BattleTeamWin = class("BattleTeamWin", WinBase)

function BattleTeamWin:ctor()
    print("BattleTeamWin:ctor")

    WinBase.ctor(self)

    self.shieldLayer_ = cc.LayerColor:create(cc.c4b(0,0,0,200)):addTo(self, -1)
    self.shieldLayer_:setIgnoreAnchorPointForPosition(false)    
    self.shieldLayer_:setAnchorPoint(0.5, 0.5)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/battle.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    -- 两个关闭按钮
    local btn = self.resourceNode_:getChildByName("btn_close1")
    btn:addClickEventListener(function()
        self:Close()
    end)

    local img = self.resourceNode_:getChildByName("btn_close")
    img:setTouchEnabled(true)
    img:onTouch(function(event)
        if event.name == "ended" then
            self:Close()
        end 
    end)

    local m1 = ccui.ImageView:create("0.public/hero-hole.png")
    self.resourceNode_:getChildByName("row11"):addChild(m1)
    m1:setTouchEnabled(true)
    m1:onTouch(function(event)
        if event.name == "ended" then
            WinManager:CreateWindow("HeroSelectWin", function()
                -- self.resourceNode_:getChildByName("row11"):addChild(m1)
            end)                    
        end
    end)


    local m2 = ccui.ImageView:create("0.public/hero-hole.png")
    self.resourceNode_:getChildByName("row12"):addChild(m2)

    local m3 = ccui.ImageView:create("0.public/hero-hole.png")
    self.resourceNode_:getChildByName("row13"):addChild(m3)

    local m4 = ccui.ImageView:create("0.public/hero-hole.png")
    self.resourceNode_:getChildByName("row21"):addChild(m4)

    local m5 = ccui.ImageView:create("0.public/hero-hole.png")
    self.resourceNode_:getChildByName("row22"):addChild(m5)

    local m6 = ccui.ImageView:create("0.public/hero-hole.png")
    self.resourceNode_:getChildByName("row23"):addChild(m6)
end


function BattleTeamWin:OnCreate()
    print("BattleTeamWin:OnCreate")
end


function BattleTeamWin:OnDestroy()
    print("BattleTeamWin:OnDestroy")
end


function BattleTeamWin:OnShow()
    print("BattleTeamWin:OnShow")
end


function BattleTeamWin:OnHiden()
    print("BattleTeamWin:OnHiden")
end


---------------------------------------------------------

return BattleTeamWin
