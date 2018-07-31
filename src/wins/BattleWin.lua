
local scheduler     = require "core.scheduler"
local WinBase       = require "core.WinBase"
local Armature      = require "core.armature"
local config        = require "configs_grace"

local BattleUnit    = class("BattleUnit")
local BattleWin     = class("BattleWin", WinBase)


--
local actor_info = {
    [1] = { -150,    100,   0.8,    "攻-前左", },
    [2] = { -150,    0,     0.8,    "攻-前中", },
    [3] = { -150,   -100,   1.0,    "攻-前右", },
    [4] = { -450,    100,   0.6,    "攻-后左", },
    [5] = { -450,    0,     0.6,    "攻-后中", },
    [6] = { -450,   -100,   0.8,    "攻-后右", },
    [7] = {  150,   -100,   0.8,    "防-前左", },
    [8] = {  150,    0,     1.0,    "防-前中", },
    [9] = {  150,    100,   0.6,    "防-前右", },
    [10]= {  450,   -100,   0.6,    "防-后左", },
    [11]= {  450,    0,     0.6,    "防-后中", },
    [12]= {  450,    100,   0.6,    "防-后右", },
}


-- 属性类型
local PropType_HP               = 1 -- HP
local PropType_Apm              = 2 -- 速度
local PropType_Atk              = 3 -- 攻击
local PropType_Def              = 4 -- 防御
local PropType_Crit             = 5 -- 暴击
local PropType_Hurt             = 6 -- 暴伤


-- 属性名
local PropName =
{
    [PropType_HP]       = "HP",
    [PropType_Apm]      = "速度",
    [PropType_Atk]      = "攻击",
    [PropType_Def]      = "防御",
    [PropType_Crit]     = "暴击",
    [PropType_Hurt]     = "暴伤",
}


-- 光环事件
local AET_PropChanged   = 1       -- 属性变化： arg1:属性类型  arg2: 属性变化量


-- 战斗事件
local EVENT_AURA        = 1
local EVENT_HURT        = 2
local EVENT_SKILL       = 3
local EVENT_EFFECT      = 4


--------------------- BattleUnit -------------------------------------------------
function BattleUnit:ctor(u, b)
    self._u         = u
    self._b         = b

    self._type      = u.type
    self._id        = u.id
    self._lv        = u.lv
    self._hp        = u.hp
    self._pos       = u.pos
    self._apm       = u.apm
    self._atk       = u.atk
    self._def       = u.def
    self._crit      = u.crit
    self._hurt      = u.hurt
    self._attacker  = u.attacker

    self._skill_curr = nil
    self._skill_comm = nil
    self._skill_exclusive = {}

    -- local property
    self._proto = nil
    self._auras = {}
    self._skills= {}

    local v = u.comm
    if v.id ~= 0 then
        table.insert(self._skills, {
            proto = config.GetSkillProto(v.id, v.lv)
        })
    end

    for k, v in ipairs(u.skill) do
        if v.id ~= 0 then
            table.insert(self._skills, {
                proto = config.GetSkillProto(v.id, v.lv)
            })
        end
    end

    if self._type == 1 then
        self._proto = config.GetHeroProto(self._id, self._lv)
    else
        self._proto = config.GetCreatureProto(self._id, self._lv)
    end

    self._root = cc.Node:create()
    local anim = Armature:create(self._proto.model)
    local info = actor_info[self._pos]
    anim:setScale(info[3])
    if not self:IsAttacker() then
        anim:setScaleX(-1*anim:getScaleX())
    end
    self._root:addChild(anim)
    self._anim = anim

    local name = cc.Label:createWithSystemFont(self._proto.name, "Arial", 16)
    name:setPosition(-30, 0)
    self._root:addChild(name)

    local hp = cc.Label:createWithSystemFont("", "Arial", 12)
    hp:setPosition(30, 0)
    self._root:addChild(hp)
    self._node_hp = hp
    self:UpdateHp(0)
end


function BattleUnit:IsAttacker()
    return self._attacker == 1
end


-- 设置HP
function BattleUnit:UpdateHp(val)
    if val ~= 0 then
        self._hp = self._hp + val
        if self._hp < 0 then
            self._hp = 0
            -- u._root:setCascadeOpacityEnabled(true);u._root:setOpacity(255*0.1)  -- 设置透明度
            self._root:setVisible(false)
        end
    end
    local v = self._hp*100 / self._u.hp
    local s = string.format("%.2f%%", v)
    self._node_hp:setString(s)
    if v > 70 then
        self._node_hp:setTextColor(cc.GREEN)
    elseif v > 30 then
        self._node_hp:setTextColor(cc.YELLOW)
    else
        self._node_hp:setTextColor(cc.RED)
    end
end


function BattleUnit:Name()
    return string.format("%s[%s]", self._proto.name, actor_info[self._pos][4])
end


function BattleUnit:Dead()
    return self._hp <= 0
end


function BattleUnit:GetSkill(id, lv)
    for _, v in ipairs(self._skills) do
        if v.proto.id == id and v.proto.level == lv then
            return v
        end
    end
end


function BattleUnit:OnAura(event)
    if event.obtain then
        print(string.format("%s 得到光环: %d/%d   [%d]", self:Name(), event.aura.id, event.aura.lv, event.time))
    else
        print(string.format("%s 失去光环: %d/%d   [%d]", self:Name(), event.aura.id, event.aura.lv, event.time))
    end
end


function BattleUnit:OnHurt(event)
    self:UpdateHp(-event.hurt)
    local text
    if event.crit == 1 then
        text = string.format("%d 暴击", -event.hurt)
    else
        text = string.format("%d", -event.hurt)
    end
    self._b:AddCloudText(self, text, false)
    self._anim:PlayHit()
end


function BattleUnit:OnSkill(event)
    local id = event.skill.id
    local iv = event.skill.lv
    local skill = self:GetSkill(id, lv)
    if not skill then
        return
    end
    local model = skill.proto.model
    self._anim:Play(model)
    print(string.format("%s 释放技能: %d/%d   [%d]", self:Name(), id, lv, event.time))
end


function BattleUnit:OnEffect(event)
    if event.type == AET_PropChanged then
        local ptype = event.arg1
        local pval  = event.arg2
        local text  = string.format("%d %s", pval, PropName[ptype])
        self._b:AddCloudText(self, text, pval>0)
        if ptype == PropType_HP then
            self:UpdateHp(pval)
        end
    else
        print("BattleUnit:OnEffect, unknown event.type", event.type)
    end
end



--------------------- BattleWin -------------------------------------------------
local function __append(tab, key, val)
    if not tab[key] then
        tab[key] = {}
    end
    table.insert(tab[key], val)
end


function BattleWin:ctor(r)
    print("BattleWin:ctor")
    WinBase.ctor(self)
    
    -- 创建背景
    local bg = display.newSprite("battle/background.png")
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

     -- notice
    local notice = cc.Label:createWithSystemFont("", "Arial", 48)
    notice:setColor(cc.YELLOW)
    notice:setPosition(0, 100)
    self:addChild(notice)
    self._notice = notice
    
    ---------- for battle data --------------------------------
    -- 初始化所有战斗参与者
    self._result = r
    self._units = {}
    for _, v in ipairs(r.units) do
        local u = BattleUnit:create(v, self)
        local p = actor_info[u._pos]
        u._root:setPosition(p[1], p[2])
        self:addChild(u._root)
        self._units[u._pos] = u
    end
    
    
    -- 初始化播放事件
    local events = {}
    self._events = events
    for _, v in ipairs(r.aura) do
        v.__type = EVENT_AURA
        __append(events, v.time, v)
    end
    for _, v in ipairs(r.hurt) do
        v.__type = EVENT_HURT
        __append(events, v.time, v)
    end
    for _, v in ipairs(r.skill) do
        v.__type = EVENT_SKILL
        __append(events, v.time, v)
    end
    for _, v in ipairs(r.effect) do
        v.__type = EVENT_EFFECT
        __append(events, v.time, v)
    end

    self._max_time = 0
    for t, _ in pairs(events) do
        if t > self._max_time then
            self._max_time = t
        end
    end

end


-- 显示文本，时间为last
-- 注意：两次调用之间的间隔，应该大于last
function BattleWin:ShowNotice(text, last)
    self._notice:setPosition(0, 100)
    self._notice:setOpacity(255*1)
    self._notice:setString(text)
    -- 动画: 向上移动/变淡
    local time = last / 2
    local action1 = cc.DelayTime:create(time)
    local action2 = cc.Spawn:create(cc.FadeOut:create(time), cc.MoveBy:create(time, cc.p(0, 80)))
    self._notice:runAction(cc.Sequence:create(action1,action2))
end


-- 属性变化时头上飘字
function BattleWin:AddCloudText(unit, text, green)
    local tip = cc.Label:createWithSystemFont(text, "Arial", 24)
    local x,y = unit._root:getPosition()
    if green then
        tip:setColor(cc.GREEN)
        x = x + 20
        y = y + 20
    else
        tip:setColor(cc.RED)
        x = x - 20
    end
    tip:setPosition(x, y+200)
    self:addChild(tip)

    -- 向上移动/变淡
    local action1 = cc.DelayTime:create(0.3)
    local action2 = cc.Spawn:create(cc.FadeOut:create(2), cc.MoveBy:create(2, cc.p(0, 200)))
    local action3 = cc.CallFunc:create(function() tip:removeFromParent() end)
    tip:runAction(cc.Sequence:create(action1,action2,action3))
end

------------------------------ inhert from WinBase ------------------------------

function BattleWin:OnCreate()
    print("BattleWin:OnCreate")
    self:PlayBattle()
end


function BattleWin:PlayBattle()
    -- 设置倒计时:  战斗开始
    self._tid_1 = scheduler.ScheduleN(function(N)
        self:ShowNotice(string.format("战斗倒计时: %d", 3-N), 0.9)
        if N == 3 then
            self._tid_1 = nil
            self:play_battle()
        end
    end, 1, 3, true)
    self:init_battle()
end


function BattleWin:OnDestroy()
    print("BattleWin:OnDestroy")
    for i = 1, 3 do
        local var = "_tid_" .. i
        local tid = self[var]
        if tid then
            scheduler.Abort(tid)
        end
        self[var] = nil
    end
end


function BattleWin:OnShow()
    print("BattleWin:OnShow")
end


function BattleWin:OnHiden()
    print("BattleWin:OnHiden")
end

------------------------------ private ------------------------------


-- 初始化
function BattleWin:init_battle()
    self._stop = false
    -- 显示所有角色以及恢复HP
    for _, u in pairs(self._units) do
        u._hp = u._u.hp
        u._root:setVisible(true)
    end
end


function BattleWin:play_battle()
    local time = 0
    self._tid_2 = scheduler.Until(function()
        local events = self._events[time]
        if events then
            for _, event in ipairs(events) do
                self:play_event(event)
            end
        end

        time = time + 100
        if time >= self._max_time then
            self._stop = true
        end

        return self._stop
    end, 0.1)
end


function BattleWin:play_event(event)
    if event.__type == EVENT_AURA then
        local u = self._units[event.owner]
        u:OnAura(event)
    end

    if event.__type == EVENT_HURT then
        local u = self._units[event.target]
        u:OnHurt(event)
    end

    if event.__type == EVENT_SKILL then
        local u = self._units[event.caster]
        u:OnSkill(event)
    end

    if event.__type == EVENT_EFFECT then
        local u = self._units[event.owner]
        u:OnEffect(event)
    end
end


return BattleWin