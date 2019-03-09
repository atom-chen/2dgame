
require "message.opcode"

local MsgRequest = {}
cc.exports.MSG = MsgRequest


MsgRequest.SendGMCommand = function(str)
    Socket.SendPacket(Opcode.MSG_CS_GMCommandRequest, {
        Command = str,
    }, function(tab)
        print(str)
        print(tab.Result)
    end)
end


-- 使用道具
MsgRequest.SendItemUse = function(id, cnt)
    Socket.SendPacket(Opcode.MSG_CS_UseItemRequest, {
        Id = id,
        Cnt = cnt,
    })
end


-- 集市购买
MsgRequest.SendMarketBuy = function(idx, cnt)
    Socket.SendPacket(Opcode.MSG_CS_MarketBuyRequest, {
        Index = idx,
        Count = cnt,
    })
end
