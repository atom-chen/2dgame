
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local PlayerBase = require "model.player_base"
local PlayerItem = require "model.player_item"
local PlayerHero = require "model.player_hero"

local md         = MessageDispatcher
local Opcode     = Opcode

-- ping response
md[Opcode.MSG_SC_MakeBattle] = function(tab)
    
end
