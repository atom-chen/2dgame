
local _heros        = {}
local _heros_index  = {}
local PlayerHero    = {}
local Hero          = class("Hero")


-------------------------------------------------------------------

function Hero:ctor()
end


function Hero:Init(tab)
    self._data = {}
    local data = self._data

    data.id             = tab.id
    data.level          = tab.level
    data.exp            = tab.exp
    data.refine         = tab.refine
    data.refineTimes    = tab.refineTimes
    data.refineSuper    = tab.refineSuper
    data.power          = tab.power
    data.status         = tab.status
    data.lifePoint      = tab.lifePoint
    data.lifePointMax   = tab.lifePointMax

    data.active         = {}
    data.passive        = {}

    for i = 1, 2 do
        data.active[i] =
        {
            id      = tab.active[i].id,
            level   = tab.active[i].level,
        }
    end

    for i = 1, 4 do
        data.passive[i] =
        {
            id      = tab.passive[i].id,
            level   = tab.passive[i].level,
        }
    end

end


function Hero:Dump()
    table.print_r(self._data, "hero:" .. self._data.id)
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
        table.insrt(_heros_index, hero)
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
