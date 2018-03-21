
require "message.opcode"

local md        = MessageDispatcher
local Opcode    = Opcode

-- ping response
md[Opcode.MSG_SC_PING] = function(tab)
    -- print("on MSG_CS_PING", tab.time)
end
