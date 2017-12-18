
require "message.opcode"

local md        = MessageDispatcher
local Opcode    = Opcode

-- 登录
md[Opcode.MSG_SC_LOGIN] = function(id, tab)

    print("on MSG_SC_LOGIN", id, tab.error_code)

end
