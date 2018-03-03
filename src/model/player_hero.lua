
local _heros        = {}
local PlayerHero    = {}

local Hero          = class("Hero")


-------------------------------------------------------------------

function Hero:ctor()
end


function Hero:Init(tab)
    self._data = {}
    local data = self._data

    data.id         = tab.id
    data.level      = tab.level
    data.quality    = tab.quality
    data.power      = tab.power
    data.status     = tab.status
    data.statusData = tab.statusData
    data.dead       = tab.dead

    data.equips     = {}
    data.skills     = {}
    data.auras      = {}

    for i = 1, 4 do
        data.equips[i] =
        {
            quality = tab.equips[i].quality,
            level   = tab.equips[i].level,
        }
    end

    for i = 1, 2 do
        data.skills[i] =
        {
            id      = tab.skills[i].id,
            level   = tab.skills[i].level,
            effectId= tab.skills[i].effectId,
        }
    end

    for i = 1, 2 do
        data.auras[i] =
        {
            id      = tab.auras[i].id,
            level   = tab.auras[i].level,
        }
    end

end


function Hero:Dump()
    table.print_r(self._data)
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


return PlayerHero
