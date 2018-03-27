
local scheduler     = require "core.scheduler"
local WinBase       = require "core.WinBase"
local Armature      = require "core.armature"
local config        = require "configs_grace"

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


local AuraEffectType =
{
    "HP",
    "攻击",
    "防御",
    "暴击",
    "暴伤",
}


--------------------- BattleUnit -------------------------------------------------
function BattleUnit:ctor(u, b)
    self._u         = u
    self._b         = b

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

    v = u.career_general_skill           -- 主帅技能
    if v.id ~= 0 then
        table.insert(self._skills, {
            proto = config.GetSkillProto(v.id, v.lv)
        })
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
    if self._pos > 5 then
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
    self:UpdateHp()

    self._is_attacker = true
    if self._pos > 5 then
        self._is_attacker = false
    end

end

-- 设置HP
function BattleUnit:UpdateHp()
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

function BattleUnit:init_campaign(u, camp)
    self._rival = u
    self._camp  = camp

    if self._is_attacker then
        if self._hp ~= camp.a_hp_s then
            self._hp = camp.a_hp_s
            print("_______ hp 不相等啊")
        end
    else
        if self._hp ~= camp.d_hp_s then
            self._hp = camp.d_hp_s
            print("_______ hp 不相等啊")
        end
    end

    self._camp_evts = {}
    for i, v in ipairs(camp.details) do
        if v.host == self._pos then
            local t = self._camp_evts[v.time]
            if not t then
                t = {}
                self._camp_evts[v.time] = t
            end
            table.insert(t, v)
        end
    end
end


function BattleUnit:clear_campaign()
    self._rival = nil
    self._camp  = nil
end


function BattleUnit:update(time)
    if self:Dead() then
        return
    end

    local t = self._camp_evts[time]
    if not t then
        return
    end

    for i, v in ipairs(t) do
        if v.flag == 1 then             -- CampaignEvent_Cast
            local id = v.arg1
            local lv = v.arg2
            self:OnCast(time, id, lv)
        elseif v.flag == 2 then         -- CampaignEvent_Hurt
            local hurt = v.arg1
            local crit = v.arg2
            self:OnHurt(time, hurt, crit)
        elseif v.flag == 3 then         -- CampaignEvent_AuraGet
            local id = v.arg1
            local lv = v.arg2
            self:AddAura(time, id, lv)
        elseif v.flag == 4 then         -- CampaignEvent_AuraLose
            local id = v.arg1
            local lv = v.arg2
            self:DelAura(time, id, lv)
        elseif v.flag == 5 then         -- CampaignEvent_AuraEffect
            self:AuraEffect(time, v.arg1, v.arg2, v.arg3, v.arg4)
        else
            print("unknown CampaignEvent", v.flag)
        end
    end

end


function BattleUnit:GetSkill(id, lv)
    for _, v in ipairs(self._skills) do
        if v.proto.id == id and v.proto.level == lv then
            return v
        end
    end
end

function BattleUnit:OnCast(time, id, lv)
    -- 单次播放不循环
    local skill = self:GetSkill(id, lv)
    if not skill then
        return
    end
    local model = skill.proto.model
    self._anim:Play(model)
    self._rival._anim:PlayHit()
    print(string.format("%s 释放技能: %d/%d   [%d]", self:Name(), id, lv, time))
end

function BattleUnit:OnHurt(time, hurt, crit)
    self._hp = self._hp - hurt
    if self._hp < 0 then
        self._hp = 0
    end
    self:UpdateHp()
    local str = string.format("%d", -hurt)
    if crit == 1 then
        str = string.format("%d 暴击", -hurt)
    end
    self._b:AddCloudText(self, str, false)
    -- print(string.format("%s be hurt: %d/%d   [%d]", self:Name(), hurt, crit, time))
end

function BattleUnit:AddAura(time, id, lv)
    print(string.format("%s 得到光环: %d/%d   [%d]", self:Name(), id, lv, time))
end

function BattleUnit:DelAura(time, id, lv)
    print(string.format("%s 失去光环: %d/%d   [%d]", self:Name(), id, lv, time))
end

function BattleUnit:AuraEffect(time, arg1, arg2, arg3, arg4)
    -- print(string.format("%s 光环效果: %d/%d   [%d]", self:Name(), arg1, arg2, arg3, arg4, time))
    -- AttrType_HP       // 1 HP
	-- AttrType_Atk      // 2 攻击
	-- AttrType_Def      // 3 防御
	-- AttrType_Crit     // 4 暴击
	-- AttrType_CritHurt // 5 暴击伤害

    local str
    if arg2 < 0 then
        str = string.format("-%s %s", tostring(arg2), AuraEffectType[arg1])
    else
        str = string.format("+%s %s", tostring(arg2), AuraEffectType[arg1])
    end

    self._b:AddCloudText(self, str, arg2>0)
end


--------------------- BattleWin -------------------------------------------------

--[[

    ctor()      一次性初始化

    init()      多次初始化，支持多次播放

--]]

function BattleWin:ctor(r)
    WinBase.ctor(self)
    print("BattleWin:ctor")
    self._result = r

    -- 创建背景
    local bg = display.newSprite("battle/background.png")
    self:addChild(bg)

    self._units = {}
    for _, v in ipairs(r.units) do
        local u = BattleUnit:create(v, self)
        local p = actor_info[u._pos]
        u._root:setPosition(p[1], p[2])
        self:addChild(u._root)
        self._units[v.pos] = u
    end

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
end


-- 显示文本，时间为last
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
        x = x - 20
        tip:setColor(cc.RED)
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
    -- 设置倒计时:  战斗开始
    local cb_count_down = function(times)
        if times == 1 then
            self:ShowNotice("战斗开始", 1)
        end
        if times == 3 then
            self:BattleStart()
            self._tid_1 = nil
        end
    end
    self._tid_1 = scheduler.ScheduleN(cb_count_down, 1, 3)
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

-- 开始战斗
function BattleWin:BattleStart()
    print("整场战斗开始=============")
    self._campaigns = 0
    self:do_campaign()
end


function BattleWin:BattleEnd()
    print("整场战斗结束 END =============", self._units[3]._hp, self._units[8]._hp)
    local u = self._units[3]
    if u:Dead() then
        print("防守方 获得了最终胜利")
    else
        print("攻击方 获得了最终胜利")
    end
end


function BattleWin:campaign_begin(camp)
    self._camp_curr = camp
    print("小场战斗开始 ----------------------------------")
    -- 隐藏非战斗角色  设置透明度
    for _, u in ipairs(self._units) do
        if u._pos ~= camp.a_pos and u._pos ~= camp.d_pos then
            if not u:Dead() then
                u._root:setCascadeOpacityEnabled(true)
                u._root:setOpacity(255*0.1)
            end
        end
    end
end


-- 开启下一场战斗
function BattleWin:campaign_end()
    self._camp_curr = nil
    print("小场战斗结束 END ----------------------------------")
    -- 显示所有非死亡角色
    for _, u in ipairs(self._units) do
        if not u:Dead() then
            u._root:setOpacity(255*1)
        else
            u._root:setVisible(false)
        end
    end

    -- 检测是否已决出胜负
    if self._campaigns >= #self._result.camps then
        self:BattleEnd()
        return
    end

    self:do_campaign()
end


function BattleWin:do_campaign()
    if self._campaigns >= #self._result.camps then
        return
    end

    self._campaigns = self._campaigns + 1
    local camp = self._result.camps[self._campaigns]

    self:campaign_begin(camp)

    local ua = self._units[camp.a_pos]
    local ud = self._units[camp.d_pos]

    ua:init_campaign(ud, camp)
    ud:init_campaign(ua, camp)

    local __do_campaign = function()
        local time = 0
        local __campaign_update = function()
            ua:update(time)
            ud:update(time)
            time = time + 100
            if ua:Dead() or ud:Dead() then
                if ua._hp ~= camp.a_hp_e then
                    ua._hp = camp.a_hp_e
                end
                if ud._hp ~= camp.d_hp_e then
                    ud._hp = camp.d_hp_e
                end

                local __campaign_end = function()
                    ua:clear_campaign()
                    ud:clear_campaign()
                    self:campaign_end()
                end

                if ua:Dead() then
                    print(ud:Name(), "胜")
                    ud._anim:Play("shengli", false)
                    ua._anim:Play("dead", false, __campaign_end)
                else
                    print(ua:Name(), "胜")
                    ua._anim:Play("shengli", false)
                    ud._anim:Play("dead", false, __campaign_end)
                end

                self._tid_2 = nil
                return true
            end
        end
        self._tid_2 = scheduler.Until(__campaign_update, 0.1)
    end

      -- 准备阶段
    local cb_campaign_prepare = function(times)
        if times == 1 then
            local str = string.format("第 %d 场", self._campaigns)
            self:ShowNotice(str, 1)
        end
        if times == 2 then
            local str = string.format("%s VS %s", ua:Name(), ud:Name())
            self:ShowNotice(str, 1)
            -- TODO: hero start move to battle pos
        end
        if times > 2 then
            local str = string.format("倒计时：%d", 5-times)
            if times == 5 then
                str = string.format("Fighting")
            end
            self:ShowNotice(str, 1)
        end
        if times == 5 then
            self._tid_3 = nil
            __do_campaign()
        end
    end
    self._tid_3 = scheduler.ScheduleN(cb_campaign_prepare, 2, 5)
end


return BattleWin
