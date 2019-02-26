
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_PlayerLvExpUpdate] = function(tab)
    print("msg: MSG_SC_PlayerLvExpUpdate")
end
