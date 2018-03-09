
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"


local HeroProto     = require "config.HeroProto"
local CreatureProto = require "config.CreatureProto"


local BattleUnit    = class("BattleUnit")
local BattleWin     = class("BattleWin", WinBase)


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
    
    local name
    if self._type == 1 then -- hero
        name = HeroProto[self._id].module_name      -- 这个地方不对哈，_id是英雄ID，而表中的id是序列ID
    else    -- creature
        name = CreatureProto[self._id].module_name
    end
        
    self._anim = AnimLoader:loadArmature(name)
    
end




--------------------- BattleWin -------------------------------------------------

function BattleWin:ctor(r)
    print("BattleWin:ctor", r.win)
    self._result = r
    self._units = {}
    for _, u in pairs(r.units) do
        self._units[u.id] = BattleUnit:create(u)
    end
    --        local 


end


------------------------------ inhert from WinBase ------------------------------

function BattleWin:OnCreate()
    print("BattleWin:OnCreate")
    -- 创建背景
    local bg = display.newSprite("battle/background.png")
    self:addChild(bg)
    

        
    
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
