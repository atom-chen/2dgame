
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local config        = require "configs_grace"


local BattleUnit    = class("BattleUnit")
local BattleWin     = class("BattleWin", WinBase)


--
local _anim_info = {
    [1] = { -150,   100,   0.8, },
    [2] = { -150,   -100,  0.8, },
    [3] = { -300,   0,     1.0, },
    [4] = { -450,   100,   0.6, },
    [5] = { -450,   -100,  0.6, },
    [6] = { 150,    100,   0.8, },
    [7] = { 150,    -100,  0.8, },
    [8] = { 300,    0,     1.0, },
    [9] = { 450,    100,   0.6, },
    [10] ={ 450,    -100,  0.6, },
}

--------------------- BattleUnit -------------------------------------------------
function BattleUnit:ctor(u)
    self._type      = u.type
    self._id        = u.id
    self._lv        = u.lv
    self._pos       = u.pos
    self._atk       = u.atk
    self._def       = u.def
    self._hp_cur    = u.hp_cur
    self._hp_max    = u.hp_max
    self._crit      = u.crit
    self._crit_hurt = u.crit_hurt

    --[[
    BattleSkill comm            = 11;   // 普攻
    repeated BattleSkill skill  = 12;   // 技能
    BattleSkill aux_s_chief     = 13;   // 主帅技能
    BattleAura  aux_a_chief     = 14;   // 主帅光环
    BattleAura  aux_a_guarder   = 15;   // 辅将光环
    --]]

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



--------------------- BattleWin -------------------------------------------------

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


return BattleWin
