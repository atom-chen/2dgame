
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_HeroInfoUpdate] = function(tab)
    local v = tab.hero
    PlayerHero.UpdateHero(v.id, v)
end
