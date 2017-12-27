
require "message.opcode"

local md        = MessageDispatcher
local Opcode    = Opcode

-- 登录
md[Opcode.MSG_SC_LOGIN] = function(tab)

    print("on MSG_SC_LOGIN", tab.error_code)

end
