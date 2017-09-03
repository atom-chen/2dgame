
cc.exports.MsgDispatcher =
{
    handler = {},
    -- Ҫ��Ҫ��Ϣ hook �����أ���ʱ���ٿ���
}


function MsgDispatcher:onMessage(opCode, args)
    local callback = self.handler[opCode]
    if callback then
        callback(args)
    else
        zcg.logWarning("onMessage, unknown opCode = %u", opCode)
    end
end


function MsgDispatcher:registerHandler(opCode, callback)
    if not self.handler[opCode] then
        self.handler[opCode] = callback
        return
    end
    zcg.logWarning("registerHandler: repeated, opCode = %u", opCode)
end
