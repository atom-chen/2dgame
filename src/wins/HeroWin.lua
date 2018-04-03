local WinBase       = require "core.WinBase"
local HeroWin       = class("HeroWin", WinBase)


function HeroWin:ctor()
    WinBase.ctor(self)

    -- 背景
    local bg = ccui.Scale9Sprite:create("bg_scale9.png")
    -- bg:setCapInsets(CCRectMake(10, 10, 46, 34))
    bg:setContentSize(cc.size(display.width, display.height))
    self:addChild(bg)
    -- 关闭按钮
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(525, 275))
    self:addChild(btn_close)
    btn_close:registerControlEventHandler(function()
        WinManager:DestroyWindow(self)
    end, 32)
    
    local label
    ------------ 左侧 ------------
    -- 名字&等级
    label = cc.Label:createWithSystemFont("level", "Arial", 16)
    label:setName("level")
    label:setPosition(-100, 200)
    self:addChild(label)
    -- 生命点
    label = cc.Label:createWithSystemFont("life", "Arial", 16)
    label:setName("life")
    label:setPosition(-100, 100)
    self:addChild(label)
    ------------ 中间 ------------
    -- 属性
    label = cc.Label:createWithSystemFont("属性", "Arial", 16)
    label:setPosition(0, 200)
    self:addChild(label)
    -- 攻击
    label = cc.Label:createWithSystemFont("atk", "Arial", 16)
    label:setName("atk")
    label:setPosition(0, 150)
    self:addChild(label)
    -- 防御
    label = cc.Label:createWithSystemFont("def", "Arial", 16)
    label:setName("def")
    label:setPosition(0, 100)
    self:addChild(label)
    -- 生命
    label = cc.Label:createWithSystemFont("hp", "Arial", 16)
    label:setName("hp")
    label:setPosition(0, 50)
    self:addChild(label)
    -- 暴击
    label = cc.Label:createWithSystemFont("crit", "Arial", 16)
    label:setName("crit")
    label:setPosition(0, 0)
    self:addChild(label)
    -- 暴伤
    label = cc.Label:createWithSystemFont("crit_hurt", "Arial", 16)
    label:setName("crit_hurt")
    label:setPosition(0, -50)
    self:addChild(label)

    ------------ 右侧 ------------
    -- 精炼等级
    label = cc.Label:createWithSystemFont("refine_lv", "Arial", 16)
    label:setName("refine_lv")
    label:setPosition(100, 200)
    self:addChild(label)
    -- 精炼类型
    label = cc.Label:createWithSystemFont("refine_type", "Arial", 16)
    label:setName("refine_type")
    label:setPosition(100, 150)
    self:addChild(label)

    -- 主动技能


    -- 被动技能


end


function HeroWin:OnCreate()
end


function HeroWin:OnDestroy()
end


function HeroWin:OnShow()
end


function HeroWin:OnHiden()
end


---------------------------------------------------------
function HeroWin:ShowHeroDetail(index)

    local label
    label = self:getChildByName("lv")
    label:setString("xx")


end


return HeroWin
