
local _heros        = {}
local _heros_index  = {}
local PlayerHero    = {}
local Hero          = class("Hero")

local config        = require "configs_grace"

-------------------------------------------------------------------

function Hero:ctor()
end


function Hero:Init(tab)
    self.proto          = config.GetHeroProto(tab.id, tab.level)
    self.id             = tab.id
    self.level          = tab.level
    self.refineLv       = tab.refineLv
    self.refineTimes    = tab.refineTimes
    self.refineSuper    = tab.refineSuper
    self.power          = tab.power
    self.status         = tab.status
    self.lifePoint      = tab.lifePoint
    self.lifePointMax   = tab.lifePointMax

    self.active         = {}
    self.passive        = {}

    for i = 1, 2 do
        self.active[i] =
        {
            id      = tab.active[i].id,
            level   = tab.active[i].level,
        }
    end

    for i = 1, 4 do
        self.passive[i] =
        {
            id      = tab.passive[i].id,
            level   = tab.passive[i].level,
        }
    end

end


function Hero:Dump()
    print("============ Hero Start:", self.proto.name, self.id)
    table.print(self)
    print("============ Hero End! ==========")
end


-------------------------------------------------------------------

function PlayerHero.Clear()
    _heros = {}
end


function PlayerHero.GetHero(id)
    local hero = _heros[id]
    if not hero then
        hero = Hero:new(id)
        _heros[id] = hero
    end
    return hero
end


function PlayerHero.Dump()
    for _, hero in pairs(_heros) do
        hero:Dump()
    end
end


function PlayerHero.Sort()
    _heros_index = {}
    for _, hero in pairs(_heros) do
        table.insert(_heros_index, hero)
    end
    table.sort(_heros_index, function(l, r)
        return l.power > r.power
    end)
    for i, v in ipairs(_heros_index) do
        v.sort_index = i
    end
end


function PlayerHero.GetHeroCount()
    return #_heros_index
end


function PlayerHero.GetHeroByIndex(index)
    return _heros_index[index]
end


return PlayerHero
