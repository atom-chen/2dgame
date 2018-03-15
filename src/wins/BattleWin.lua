
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local config        = require "configs_grace"

local SkillContext  = class("SkillContext")
local SkillDamage   = class("SkillDamage")
local BattleSkill   = class("BattleSkill")
local BattleAura    = class("BattleAura")
local BattleUnit    = class("BattleUnit")
local BattleWin     = class("BattleWin", WinBase)


--
local actor_info = {
    [1] = { -150,    0,     0.8,    "攻-左先锋", },
    [2] = { -150,   -200,   0.8,    "攻-右先锋", },
    [3] = { -300,   -100,   1.0,    "攻-主帅",   },
    [4] = { -450,    0,     0.6,    "攻-左辅将", },
    [5] = { -450,   -200,   0.6,    "攻-右辅将", },
    [6] = {  150,   -200,   0.8,    "防-左先锋", },
    [7] = {  150,    0,     0.8,    "防-右先锋", },
    [8] = {  300,   -100,   1.0,    "防-主帅",   },
    [9] = {  450,   -200,   0.6,    "防-左辅将", },
    [10]= {  450,    0,     0.6,    "防-右辅将", },
}
--------------------- SkillDamage -------------------------------------------------
function SkillDamage:ctor()
    self._hurt = 0
	self._crit = false
end

--------------------- SkillContext -------------------------------------------------
function SkillContext:ctor(caster, target)
    self._caster        = caster   -- *BattleUnit
	self._target        = target   -- *BattleUnit
	self._caster_prop   = 0   -- *Property   -- 攻击者的基本属性(只读)
	self._target_prop   = 0   -- *Property   -- 防御者的基本属性(只读)
	self._prop_add      = 0   -- Property    -- 攻击者光环加成
	self._damage_send   = 0   -- SkillDamage -- 攻击者造成实际伤害
	self._damage_recv   = 0   -- SkillDamage -- 防御者计算防御之后的伤害
	self._damage_sub    = 0   -- SkillDamage -- 防御者计算防御之后光环减免部分
	self._damage        = 0   -- SkillDamage --最终造成的实际伤害
end

--------------------- BattleSkill -------------------------------------------------
function BattleSkill:ctor(id, lv)
    self._proto = config.GetSkillProto(id, lv)
    self._start_time = 0
    self._update_time = 0
    self._cd_time = 0
    self._finish = true
end

function BattleSkill:Cast(u, time)
    self._owner = u
    self._finish = false
	self._start_time = time
	self._update_time = time
	self:onStart()
	print(self._owner:Name(), "释放了技能:", self._proto.id, self._proto.level)

    -- 播放动画
    local module = self._proto.module
    u._anim:getAnimation():play(module, -1, 1)
end

function BattleSkill:update(time)
    if self._finish then
        return
    end
    if self._proto.itv_t ~= 0 then
        if time-self._update_time > self._proto.itv_t then
            self._update_time = time
            self:onUpdate()
        end
    end
    if time-self._start_time >= self._proto.last_t then
        self:onFinish()
        self._owner = nil
        self._finish = true
        self._cd_time = time
    end
end

function BattleSkill:IsFree(time)
	return time-self._cd_time >= self._proto.cd_t
end

function BattleSkill:IsFinish()
    return self._finish
end

function BattleSkill:onStart()
end

function BattleSkill:onUpdate()
    local target = self._rival
    local type = self._proto.type
    if type == 1 then
        if target == self._owner then
            print("[WARNING]", self._owner:Name(), "要对自己造成伤害", self._proto.id)
            return
        end
        self:do_attack(target)
    elseif type == 2 then
        for _, a in ipairs(self._proto.aura) do
            target:AddAura(self._owner, a.id, a.lv)
        end
    else
        print("unknown skill type:", self._proto.type)
    end
end

function BattleSkill:onFinish()
    if self._proto.itv_t == 0 then
		self:onUpdate()
	end
end

function BattleSkill:do_attack(target)
    local ctx = SkillContext:create(self._owner, target)
--[[
	ctx.caster_prop: = ctx._caster.Prop
	ctx.target_prop = ctx._target.Prop

	-- step 1: 计算光环
    for _, aura in ipairs(ctx._caster._auras_battle) do
		if aura then
			aura.OnEvent(BattleEvent_PreAtk, ctx)
		end
	end

	-- step 2: 计算输出伤害
	hurt := ctx.caster_prop.Atk + ctx.prop_add.Atk
	crit := ctx.caster_prop.Crit + ctx.prop_add.Crit
	ctx.damage_send.hurt = hurt
	ctx.damage_send.crit = false
	if math.RandomHitn(int(crit), 100) then
		ctx.damage_send.crit = true
		ctx.damage_send.hurt = hurt * (ctx.caster_prop.CritHurt + ctx.prop_add.CritHurt)
	end

	-- step 3: 计算防御
	hurt = ctx.damage_send.hurt - ctx.target_prop.Def
	if hurt < 0 then
		hurt = 1
	end
	ctx.damage_recv.hurt = hurt

	-- step 4: 计算光环
	for _, aura := range target.Auras_battle do
		if aura ~= nil then
			aura.OnEvent(BattleEvent_AftDef, ctx)
		end
	end

	-- step 5: 计算最终伤害
	ctx.damage.hurt = ctx.damage_recv.hurt - ctx.damage_sub.hurt
	if ctx.damage.hurt < target.Hp then
		target.Hp -= ctx.damage.hurt
		fmt.Println(ctx.caster.Name(), " <伤害了> ", ctx.target.Name(), ctx.damage.hurt)
	else
		target.Hp = 0
		fmt.Println(ctx.caster.Name(), " <击杀了> ", ctx.target.Name(), ctx.damage.hurt)
	end
--]]
end


--------------------- BattleAura -------------------------------------------------
function BattleAura:ctor(id, lv, once)
    self._proto = config.GetAuraProto(id, lv)
    self._once = once
end

function BattleAura:update(time)
end

function BattleAura:IsFinish()
end

function BattleAura:Init(caster, owner)
    self._owner = owner
	self._caster = caster
end


--------------------- BattleUnit -------------------------------------------------
function BattleUnit:ctor(u)
    self._type      = u.type
    self._id        = u.id
    self._lv        = u.lv
    self._hp        = u.hp
    self._pos       = u.pos
    self._atk       = u.atk
    self._def       = u.def
    self._crit      = u.crit
    self._crit_hurt = u.crit_hurt

    self._skill_curr = nil
    self._skill_comm = nil
    self._skill_exclusive = {}

    local v = u.comm
    if v.id ~= 0 then
        self._skill_comm = BattleSkill:create(v.id, v.lv)
    end

    for k, v in ipairs(u.skill) do
        if v.id ~= 0 then
            table.insert(self._skill_exclusive, BattleSkill:create(v.id, v.lv))
        end
    end

    v = u.career_general_skill           -- 主帅技能
    if v.id ~= 0 then
        table.insert(self._skill_exclusive, BattleSkill:create(v.id, v.lv))
    end

    -- 光环
	self._auras_battle  = {}    -- 战斗中产生的光环(战斗过程中产生，战斗结束之后保留)

    --[[
    BattleAura  career_general_aura     = 14;   -- 主帅光环
    BattleAura  career_guarder_aura     = 15;   -- 辅将光环
    --]]

    -- local property

    self._proto = nil
    if self._type == 1 then
        self._proto = config.GetHeroProto(self._id, self._lv)
    else
        self._proto = config.GetCreatureProto(self._id, self._lv)
    end

    self._root = cc.Node:create()
    local anim = AnimLoader:loadArmature(self._proto.module_name)
    local info = actor_info[self._pos]
    anim:setScale(info[3])
    if self._pos > 5 then
        anim:setScaleX(-1*anim:getScaleX())
    end
    self._root:addChild(anim)
    self._anim = anim

    local name = cc.Label:createWithSystemFont(self._proto.name, "Arial", 16)
    name:setPosition(-30, 0)
    self._root:addChild(name)

    -- hp

end

function BattleUnit:Name()
    return string.format("%s[%s]", self._proto.name, actor_info[self._pos][4])
end

function BattleUnit:Dead()
    return self._hp == 0
end

function BattleUnit:init_campaign(u, step)
    self._rival = u
end

function BattleUnit:update(time)
    if self:Dead() then
        return
    end

    -- cast skill
    if not self._skill_curr then
        for i, s in ipairs(self._skill_exclusive) do
            if s:IsFree(time) then
                self._skill_curr = s
                break
            end
        end
        if not self._skill_curr then
            if self._skill_comm:IsFree(time) then
                self._skill_curr = self._skill_comm
            end
        end
        if self._skill_curr then
            self._skill_curr:Cast(self, time)
        end
    else
        self._skill_curr:update(time)
        if self._skill_curr:IsFinish() then
            self._skill_curr = nil
        end
    end

    -- update auras
    for i, v in ipairs(self._auras_battle) do
        if v then
            v:update(time)
            if v:IsFinish() then
                self._auras_battle[i] = nil
            end
        end
    end

end

function BattleUnit:AddAura(caster, id, lv)
    local aura = BattleAura:create(id, lv, false)
    aura:Init(caster, self)
    table.insert(self._auras_battle, aura)
end


--------------------- BattleWin -------------------------------------------------

--[[

    ctor()      一次性初始化

    init()      多次初始化，支持多次播放


--]]

function BattleWin:ctor(r)
    print("BattleWin:ctor")
    self._result = r

    -- 创建背景
    local bg = display.newSprite("battle/background.png")
    self:addChild(bg)

    self._units = {}
    for _, v in ipairs(r.units) do
        local u = BattleUnit:create(v)
        local p = actor_info[u._pos]
        u._root:setPosition(p[1], p[2])
        self:addChild(u._root)
        self._units[v.pos] = u
    end

    -- 关闭按钮
    local btn_image = cc.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(525, 275))
    self:addChild(btn_close)
    btn_close:registerControlEventHandler(function()
        WinManager:DestroyWindow(self)
    end, 32)

    self._steps = {}
    for i, s in ipairs(r.steps) do
        self._steps[i] =
        {
            a_pos = s.a_pos,
            d_pos = s.d_pos,
            a_hp  = s.a_hp,
            d_hp  = s.d_hp,
        }
    end
end


------------------------------ inhert from WinBase ------------------------------

function BattleWin:OnCreate()
    print("BattleWin:OnCreate")
    -- 设置倒计时
    local times = 4
    local cb_count_down = function()
        times = times - 1
        print("times:", times)
        if times == 0 then
            self:getScheduler():unscheduleScriptEntry(self._tid_1)
            self._tid_1 = nil
            self:PlayBattle()
        end
    end
    self._tid_1 = self:getScheduler():scheduleScriptFunc(cb_count_down, 0.2, false)
end


function BattleWin:OnDestroy()
    print("BattleWin:OnDestroy")
    if self._tid_1 then
        self:getScheduler():unscheduleScriptEntry(self._tid_1)
    end
    if self._tid_2 then
        self:getScheduler():unscheduleScriptEntry(self._tid_2)
    end
end


function BattleWin:OnShow()
    print("BattleWin:OnShow")
end


function BattleWin:OnHiden()
    print("BattleWin:OnHiden")
end

-- 开始战斗
function BattleWin:PlayBattle()
    self._campaigns = 0
    self:do_campaign()
end


function BattleWin:ReplayBattle()
end


function BattleWin:BattleEnd()
end

function BattleWin:campaign_begin(step)
    -- 隐藏非战斗角色  设置透明度
    for _, u in ipairs(self._units) do
        if u._pos ~= step.a_pos and u._pos ~= step.d_pos then
            if not u:Dead() then
                u._root:setCascadeOpacityEnabled(true)
                u._root:setOpacity(255*0.1)
                -- u._root:setVisible(false)
            end
        end
    end
end


-- 开启下一场战斗
function BattleWin:campaign_end()
    -- 显示所有非死亡角色
    for _, u in ipairs(self._units) do
        if not u:Dead() then
            u._root:setOpacity(0)
        else
            u._root:setVisible(false)
        end
    end

    -- 检测是否已决出胜负
    if self._campaigns >= #self._steps then
        self.BattleEnd()
        return
    end

    -- 休息3秒
    local cb_wait = function()
        -- 播放一下挑衅的动画
        self:do_campaign()
    end
    self:getScheduler():scheduleScriptFunc(cb_wait, 0.8, false)
end

function BattleWin:do_campaign()
    if self._campaigns >= #self._steps then
        return
    end

    self._campaigns = self._campaigns + 1
    local step = self._steps[self._campaigns]

    self:campaign_begin(step)

    local ua = self._units[step.a_pos]
    local ud = self._units[step.d_pos]

    ua:init_campaign(ud, step)
    ud:init_campaign(ua, step)

    local tid
    local time = 0
    local cb_update = function()
        ua:update(time)
        ud:update(time)
        time = time + 100
        if ua:Dead() or ud:Dead() then
            self:getScheduler():unscheduleScriptEntry(self._tid_2)
            self._tid_2 = nil
            -- adjust hp
            print("campaign end, LEFT hp:", ua._hp, ud._hp)
            ua._hp = step.a_hp
            ud._hp = step.d_hp
            print("campaign end, ADJUST hp:", ua._hp, ud._hp)
            self:campaign_end()
        end
    end
    self._tid_2 = self:getScheduler():scheduleScriptFunc(cb_update, 0.1, false)
end


return BattleWin
