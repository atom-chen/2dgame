local _heros        = {}
local _heros_index  = {}
local PlayerHero    = NewModel({_model_name="PlayerHero"})
local Hero          = class("Hero")

local Property      = require "model.property"

local config        = require "configs_grace"

-------------------------------------------------------------------

function Hero:ctor()
end

function Hero:Init(tab)
    self.proto          = config.GetHeroProto(tab.Id, tab.Level)
    self.id             = tab.Id
    self.level          = tab.Level
    self.refineLv       = tab.RefineLv
    self.refineTimes    = tab.RefineTimes
    self.refineSuper    = tab.RefineSuper
    self.power          = tab.Power
    self.status         = tab.Status
    self.lifePoint      = tab.LifePoint
    self.lifePointMax   = tab.LifePointMax

    self.active         = {}
    self.passive        = {}

    for i = 1, 2 do
        self.active[i] =
        {
            id      = tab.Active[i].Id,
            level   = tab.Active[i].Level,
        }
    end

    for i = 1, 4 do
        self.passive[i] =
        {
            id      = tab.Passive[i].Id,
            level   = tab.Passive[i].Level,
        }
    end

    -- 基础属性
    self.props = Property.PropertyGroup:create()

    self:Calc()
end

function Hero:Calc()
    local proto     = self.proto

    self.props:AddProps(proto.props)

    -- refine
    local conf
    if self.refineSuper then
        conf = config.GetRefineSuper(self.refineLv)
    else
        conf = config.GetRefineNormal(self.refineLv)
    end

    if conf then
        self.props:AddProps(conf.props)
    end

    -- passive skill
    for i = 1, 4 do
        local v = self.passive[i]
        local proto = config.GetSkillProto(v.id, v.level)
        if proto and proto.passive == 1 then
            self.props:AddProps(proto.prop_passive)
        end
    end
end

function Hero:Dump()
    print("============ Hero Start:", self.proto.name, self.id)
    table.print(self)
    print("============ Hero End! ==========")
end

-------------------------------------------------------------------------------

function PlayerHero:Clear()
    _heros = {}
end

function PlayerHero:UpdateHero(id, tab)
    local hero = _heros[id]
    if not hero then
        hero = Hero:new(id)
        _heros[id] = hero
        self:Notify(1, id)
    else
        self:Notify(0, id)
    end
    hero:Init(tab)
end

function PlayerHero:GetHero(id)
    return _heros[id]
end

function PlayerHero:GetHeros()
    return _heros
end

function PlayerHero:Dump()
    for _, hero in pairs(_heros) do
        hero:Dump()
    end
end

function PlayerHero:Sort()
    _heros_index = {}

    for _, hero in pairs(_heros) do
        table.insert(_heros_index, hero)
    end

    table.sort(_heros_index, function(l, r)
        return l.props:Value(Property.PropType_HP) > r.props:Value(Property.PropType_HP)
    end)
    
    for i, v in ipairs(_heros_index) do
        v.sort_index = i
    end
end

function PlayerHero:GetHeroCount()
    return #_heros_index
end

function PlayerHero:GetHeroByIndex(index)
    return _heros_index[index]
end

-------------------------------------------------------------------------------
return PlayerHero
