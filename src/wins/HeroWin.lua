local Armature      = require "core.armature"
local config        = require "config.loader"
local PlayerHero    = require "model.player_hero"
local Property      = require "model.property"
local WinBase       = require "core.WinBase"
local HeroWin       = class("HeroWin", WinBase)


function HeroWin:ctor()
    WinBase.ctor(self)

    -- 背景
    local bg = ccui.Scale9Sprite:create("bg_scale9.png")
    -- bg:setCapInsets(cc.rect(10, 10, 46, 34))
    bg:setContentSize(cc.size(display.width, display.height))
    self:addChild(bg)
    -- 关闭按钮
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(525, 275))
    self:addChild(btn_close)
    btn_close:registerControlEventHandler(function()
        self:Close()
    end, 32)

    local node
    local label
    local button

    -- 上一个
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("上一个")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(-440, 240)
    button:addClickEventListener(function()
        if self.curr_index > 1 then
            self:ShowHeroDetail(self.curr_index-1)
        end
    end)
    self:addChild(button)

    -- 下一个
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("下一个")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(-240, 240)
    button:addClickEventListener(function()
        if self.curr_index < PlayerHero:GetHeroCount() then
            self:ShowHeroDetail(self.curr_index+1)
        end
    end)
    self:addChild(button)


    ------------ 左侧 ------------
    -- 动画节点
    node = cc.Node:create()
    node:setName("animal")
    node:setPosition(-360, 0)
    self:addChild(node)

    -- 名字&等级
    label = cc.Label:createWithSystemFont("level", "Arial", 16)
    label:setName("level")
    label:setPosition(-360, -100)
    self:addChild(label)
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("升级")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(-200, -100)
    button:addClickEventListener(function()
        if self.curr_index then
            local hero = PlayerHero:GetHeroByIndex(self.curr_index)
            Socket.SendPacket(Opcode.MSG_CS_HeroLevelupRequest, {
                Id = hero.id,
            })
        end
    end)
    self:addChild(button)
    -- 播放战斗

    -- 生命点
    label = cc.Label:createWithSystemFont("life", "Arial", 16)
    label:setName("life")
    label:setPosition(-360, -140)
    self:addChild(label)

    label = cc.Label:createWithSystemFont("power", "Arial", 16)
    label:setName("power")
    label:setPosition(-360, -180)
    self:addChild(label)
    ------------ 中间 ------------
    -- 属性
    label = cc.Label:createWithSystemFont("属性：", "Arial", 16)
    label:setPosition(-150, 200)
    self:addChild(label)
    -- 生命
    label = cc.Label:createWithSystemFont("hp", "Arial", 16)
    label:setName("hp")
    label:setPosition(-140, 170)
    self:addChild(label)
    -- 速度
    label = cc.Label:createWithSystemFont("速度", "Arial", 16)
    label:setName("apm")
    label:setPosition(-140, 140)
    self:addChild(label)
    -- 攻击
    label = cc.Label:createWithSystemFont("atk", "Arial", 16)
    label:setName("atk")
    label:setPosition(-140, 110)
    self:addChild(label)
    -- 防御
    label = cc.Label:createWithSystemFont("def", "Arial", 16)
    label:setName("def")
    label:setPosition(-140, 80)
    self:addChild(label)
    -- 暴击
    label = cc.Label:createWithSystemFont("crit", "Arial", 16)
    label:setName("crit")
    label:setPosition(-140, 50)
    self:addChild(label)
    -- 暴伤
    label = cc.Label:createWithSystemFont("crit_hurt", "Arial", 16)
    label:setName("crit_hurt")
    label:setPosition(-140, 20)
    self:addChild(label)

    ------------ 右侧 ------------
    -- 精炼
    label = cc.Label:createWithSystemFont("精炼：", "Arial", 16)
    label:setPosition(80, 200)
    self:addChild(label)
    -- 精炼类型
    label = cc.Label:createWithSystemFont("精炼类型", "Arial", 16)
    label:setName("refine_type")
    label:setPosition(100, 155)
    self:addChild(label)
    -- 精炼等级
    label = cc.Label:createWithSystemFont("精炼等级", "Arial", 16)
    label:setName("refine_lv")
    label:setPosition(100, 125)
    self:addChild(label)
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("普通精炼")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(260, 140)
    button:addClickEventListener(function()
        if self.curr_index then
            local hero = PlayerHero:GetHeroByIndex(self.curr_index)
            Socket.SendPacket(Opcode.MSG_CS_HeroRefineRequest, {
                Id = hero.id,
                Flag = 0,
            })
        end
    end)
    self:addChild(button)
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("超级精炼")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(440, 140)
    button:addClickEventListener(function()
        if self.curr_index then
            local hero = PlayerHero:GetHeroByIndex(self.curr_index)
            Socket.SendPacket(Opcode.MSG_CS_HeroRefineRequest, {
                Id = hero.id,
                Flag = 1,
            })
        end
    end)
    self:addChild(button)

    -- 资质
    label = cc.Label:createWithSystemFont("资质等级", "Arial", 16)
    label:setName("aptitude")
    label:setPosition(100, 80)
    self:addChild(label)
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("提升资质")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(260, 80)
    button:addClickEventListener(function()
        if self.curr_index then
            local hero = PlayerHero:GetHeroByIndex(self.curr_index)
            Socket.SendPacket(Opcode.MSG_CS_HeroAptitudeRequest, {
                Id = hero.id,
            })
        end
    end)
    self:addChild(button)

    -- 天赋
    label = cc.Label:createWithSystemFont("天赋等级", "Arial", 16)
    label:setName("talent")
    label:setPosition(100, 20)
    self:addChild(label)
    button = ccui.Button:create("ccs/gm/public_button_001.png")
    button:setTitleText("提升资质")
    button:getTitleLabel():setSystemFontSize(16)
    button:setPosition(260, 20)
    button:addClickEventListener(function()
        if self.curr_index then
            local hero = PlayerHero:GetHeroByIndex(self.curr_index)
            Socket.SendPacket(Opcode.MSG_CS_HeroTalentRequest, {
                Id = hero.id,
            })
        end
    end)
    self:addChild(button)

    -- 主动技能
    label = cc.Label:createWithSystemFont("技能：", "Arial", 16)
    label:setPosition(80, -50)
    self:addChild(label)

    node = cc.Node:create()
    node:setName("skill")
    node:setPosition(80, -70)
    self:addChild(node)

    -- 被动技能
    -- TODO

    self:ShowHeroDetail(1)
end


function HeroWin:OnCreate()
    self:RegisterNotice("PlayerHero", "on_player_hero")
end


function HeroWin:OnDestroy()
end


function HeroWin:OnShow()
end


function HeroWin:OnHiden()
end


---------------------------------------------------------
function HeroWin:ShowHeroDetail(index)
    if self.curr_index and self.curr_index == index then
        return
    end
    self.curr_index = index

    local hero = PlayerHero:GetHeroByIndex(index)
    if not hero then
        return
    end

    local node
    local label

    node = self:getChildByName("animal")
    node:removeAllChildren()
    node:addChild(Armature:create(hero.proto.model))


    label = self:getChildByName("level")
    label:setString(string.format("%s %d 级", hero.proto.name, hero.lv))

    label = self:getChildByName("life")
    label:setString(string.format("生命点: %d/%d", hero.lifePoint, hero.lifePointMax))

    label = self:getChildByName("power")
    label:setString(string.format("战斗力: %d", hero.power))

    label = self:getChildByName("atk")
    label:setString(string.format("攻击: %d", hero.props:Value(Property.PropType_Atk)))

    label = self:getChildByName("def")
    label:setString(string.format("防御: %d", hero.props:Value(Property.PropType_Def)))

    label = self:getChildByName("hp")
    label:setString(string.format("HP: %d", hero.props:Value(Property.PropType_HP)))

    label = self:getChildByName("apm")
    label:setString(string.format("速度: %d", hero.props:Value(Property.PropType_Apm)))

    label = self:getChildByName("crit")
    label:setString(string.format("暴击: %d", hero.props:Value(Property.PropType_Crit)))

    label = self:getChildByName("crit_hurt")
    label:setString(string.format("暴伤: %d", hero.props:Value(Property.PropType_Hurt)))

    label = self:getChildByName("refine_lv")
    label:setString(string.format("精炼等级: %d", hero.refineLv))

    label = self:getChildByName("refine_type")
    local str = "超级精炼:否"
    if hero.refineSuper then
        str = "超级精炼:是"
    end
    label:setString(string.format("%s", str))

    node = self:getChildByName("skill")
    node:removeAllChildren()
    for i = 1, 2 do
        local v = hero.active[i]
        if v.id ~= 0 and v.lv ~= 0 then
            local proto = config.GetSkillProto(v.id, v.lv)
            local image = ccui.ImageView:create(proto.icon)
            image:setPosition(i*150, 0)
            node:addChild(image)
        end
    end

    label = self:getChildByName("aptitude")
    label:setString(string.format("资质等级: %d", hero.aptitude))

    label = self:getChildByName("talent")
    label:setString(string.format("天赋等级: %d", hero.talent))
end


-- type    0: 英雄信息变化  1: 新增英雄
function HeroWin:on_player_hero(typ, id)
    if typ == 0 and self.curr_index then
        local hero = PlayerHero:GetHeroByIndex(self.curr_index)
        if hero.id == id then
            local index = self.curr_index
            self.curr_index = nil
            self:ShowHeroDetail(index)
        end
    end
end


return HeroWin
