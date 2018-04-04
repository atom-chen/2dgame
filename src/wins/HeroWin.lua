local PlayerHero    = require "model.player_hero"
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

    label = cc.Label:createWithSystemFont("power", "Arial", 16)
    label:setName("power")
    label:setPosition(-100, 0)
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


    self:ShowHeroDetail(1)

end


function HeroWin:OnCreate()
    PlayerHero.Register(self)
end


function HeroWin:OnDestroy()
    PlayerHero.UnRegister(self)
end


function HeroWin:OnShow()
end


function HeroWin:OnHiden()
end


---------------------------------------------------------
function HeroWin:ShowHeroDetail(index)
    local hero = PlayerHero.GetHeroByIndex(index)

    local label
    label = self:getChildByName("level")
    label:setString(string.format("%s(%d)", hero.proto.name, hero.level))

    label = self:getChildByName("life")
    label:setString(string.format("生命: %d/%d", hero.lifePoint, hero.lifePointMax))

    label = self:getChildByName("power")
    label:setString(string.format("战斗力: %d", hero.power))

    label = self:getChildByName("atk")
    label:setString(string.format("攻击: %d", hero.atk))

    label = self:getChildByName("def")
    label:setString(string.format("防御: %d", hero.def))

    label = self:getChildByName("hp")
    label:setString(string.format("HP: %d", hero.hp))

    label = self:getChildByName("crit")
    label:setString(string.format("暴击: %d", hero.crit))

    label = self:getChildByName("crit_hurt")
    label:setString(string.format("暴伤: %d", hero.crit_hurt))

    label = self:getChildByName("refine_lv")
    label:setString(string.format("精炼等级: %d", hero.refineLv))

    label = self:getChildByName("refine_type")
    local str = "超级精炼:否"
    if hero.refineSuper then
        str = "超级精炼:是"
    end
    label:setString(string.format("精炼等级: %s", str))

end


-- type    0: 英雄信息变化  1: 新增英雄
function HeroWin:Notice(type, id)

end


return HeroWin
