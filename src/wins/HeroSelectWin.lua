local Armature      = require "core.armature"
local config        = require "configs_grace"
local PlayerHero    = require "model.player_hero"
local WinBase       = require "core.WinBase"


local HeroSelectWin = class("HeroSelectWin", WinBase)

function HeroSelectWin:ctor(onOK)
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/hero_select.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)        


    local btn = self.resourceNode_:getChildByName("btnOK")
    btn:addClickEventListener(function(onOK)
        local id = 0

        self.list.

        onOK(id)
        self:Close()
    end)

    local btn = self.resourceNode_:getChildByName("btnCancel")
    btn:addClickEventListener(function()
        self:Close()
    end)

    local list = self.resourceNode_:getChildByName("ListView_1")
    self.list = list

    local idx = 0
    for i, tab in pairs(PlayerHero.GetHeros()) do
        local arm = Armature:create(tab.proto.model)
        arm:setPosition(idx * 200 + 100, 100)
        idx = idx + 1
        print("ffff", i, arm)
        arm:addTo(list)
        -- list:pushBackCustomItem(arm)
    end

     local function test(sender,_type)
           print("--index--11111111111111")

        if _type == 1 then
           local index = sender:getCurSelectedIndex()
           print("--index--",index)
        end
    end
    list:addEventListener(test)


end


function HeroSelectWin:OnCreate()
    PlayerHero.Register(self)
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
