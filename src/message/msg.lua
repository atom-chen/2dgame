
require "message.opcode"

local MsgRequest = {}
cc.exports.MSG = MsgRequest


MsgRequest.SendGMCommand = function(str)
    Socket.SendPacket(Opcode.MSG_CS_GMCommand, {
        command = str
    }, function(tab)
        print(str)
        print(tab.result)
    end)
end


MsgRequest.SendNotice = function(str, flag)
    if not str then
        return
    end
    if not flag then
        flag = 0
    end

    Socket.SendPacket(Opcode.MSG_CS_Notice, {
        notice = str,
        flag = flag,
    })
end


-- 使用道具
MsgRequest.SendNotice = function(id, cnt)
    Socket.SendPacket(Opcode.MSG_CS_UseItem, {
        id = id,
        cnt = cnt,
    })
end
