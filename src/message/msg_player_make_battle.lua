
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode

-- ping response
md[Opcode.MSG_SC_MakeBattle] = function(tab)
    PlayBattle(tab.result)
end
