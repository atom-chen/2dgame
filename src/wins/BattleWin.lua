
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local config        = require "configs_grace"


local BattleUnit    = class("BattleUnit")
local BattleWin     = class("BattleWin", WinBase)


--
local _anim_pos = {
    [1] = { -100,   100},
    [2] = { -100,   -100},
    [3] = { -200,   0},
    [4] = { -300,   100},
    [5] = { -300,   -100},
    [6] = { 100,    100},
    [7] = { 100,    -100},
    [8] = { 200,    0},
    [9] = { 300,    100},
    [10] = {300,    -100},
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

    self._name = ""
    if self._type == 1 then
        local conf = config.GetHeroProto(self._id, self._lv)
        self._name = conf.module_name
    else
        local conf = config.GetCreatureProto(self._id, self._lv)
        self._name = conf.module_name
    end

    self._anim = AnimLoader:loadArmature(self._name)
    if self._pos > 5 then
        self._anim:setScaleX(-1)
    end
end



--------------------- BattleWin -------------------------------------------------

function BattleWin:ctor(r)
    print("BattleWin:ctor")
    self._result = r
    self._units = {}
    for _, u in pairs(r.units) do
        self._units[u.pos] = BattleUnit:create(u)
    end
end


------------------------------ inhert from WinBase ------------------------------

function BattleWin:OnCreate()
    print("BattleWin:OnCreate")
    -- 创建背景
    local bg = display.newSprite("battle/background.png")
    self:addChild(bg)

    -- 设置动画位置
    for _, u in pairs(self._units) do
        local pos = _anim_pos[u._pos]
        u._anim:setPosition(pos[1], pos[2])
        self:addChild(u._anim)
    end

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
