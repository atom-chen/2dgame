
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local config        = require "configs_grace"

local BattleSkill   = class("BattleSkill")
local BattleAura    = class("BattleAura")
local BattleUnit    = class("BattleUnit")
local BattleWin     = class("BattleWin", WinBase)


--
local _anim_info = {
    [1] = { -150,    0,     0.8, },
    [2] = { -150,   -200,   0.8, },
    [3] = { -300,   -100,   1.0, },
    [4] = { -450,    0,     0.6, },
    [5] = { -450,   -200,   0.6, },
    [6] = {  150,    0,     0.8, },
    [7] = {  150,   -200,   0.8, },
    [8] = {  300,   -100,   1.0, },
    [9] = {  450,    0,     0.6, },
    [10]= {  450,   -200,   0.6, },
}

--------------------- BattleSkill -------------------------------------------------
function BattleSkill:ctor(id, lv)
    self._proto = config.GetSkillProto(id, lv)
end

function BattleSkill:update(time)
end

function BattleSkill:IsFinish()
end

function BattleSkill:Cast(target, time)
end

function BattleSkill:IsFree(time)
end


--------------------- BattleAura -------------------------------------------------
function BattleAura:ctor()
end

function BattleAura:update(time)
end

function BattleAura:IsFinish()
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
    BattleAura  career_general_aura     = 14;   // 主帅光环
    BattleAura  career_guarder_aura     = 15;   // 辅将光环
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
    local info = _anim_info[self._pos]
    anim:setScale(info[3])
    if self._pos > 5 then
        anim:setScaleX(-1*anim:getScaleX())
    end
    self._root:addChild(anim)

    local name = cc.Label:createWithSystemFont(self._proto.name, "Arial", 16)
    name:setPosition(-30, 0)
    self._root:addChild(name)

    -- hp

end

function BattleUnit:dead()
    return self._hp == 0
end

function BattleUnit:init_campaign(step)

end

function BattleUnit:update(time)
    if self:dead() then
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
        self._skill_curr.update(time)
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
        local p = _anim_info[u._pos]
        u._root:setPosition(p[1], p[2])
        self:addChild(u._root)
        self._units[v.pos] = u
    end

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
    local tid
    local times = 4
    local cb_count_down = function()
        times = times - 1
        print("times:", times)
        if times == 0 then
            self:getScheduler():unscheduleScriptEntry(tid)
            self:PlayBattle()
        end
    end
    tid = self:getScheduler():scheduleScriptFunc(cb_count_down, 0.8, false)
end


function BattleWin:OnDestroy()
    print("BattleWin:OnDestroy")
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
            if not u:dead() then
                -- layer:setCascadeOpacityEnabled(true)
                -- layer:setOpacity(255 * 0.4)
                u._root:setOpacity(255*0.9)
            end
        end
    end
end


-- 开启下一场战斗
function BattleWin:campaign_end()
    -- 显示所有非死亡角色
    for _, u in ipairs(self._units) do
        if not u:dead() then
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
    self:getScheduler():scheduleScriptFunc(cb_wait, 3, false)
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

    ua:init_campaign(step)
    ud:init_campaign(step)

    local tid
    local time = 0
    local cb_update = function()
        ua:update(time)
        ud:update(time)
        time = time + 100
        if ua:dead() or ud:dead() then
            self:getScheduler():unscheduleScriptEntry(tid)
            -- adjust hp
            print("campaign end, LEFT hp:", ua._hp, ud._hp)
            ua._hp = step.a_hp
            ud._hp = step.d_hp
            print("campaign end, ADJUST hp:", ua._hp, ud._hp)
            self:campaign_end()
        end
    end
    tid = self:getScheduler():scheduleScriptFunc(cb_update, 0.1, false)
end


return BattleWin
