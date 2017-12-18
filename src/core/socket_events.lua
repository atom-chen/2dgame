
require "core.protobuf"
require "struct"

require "message.opcode"


protobuf.register(cc.FileUtils:getInstance():getDataFromFile("protocol.pb"))

cc.exports.Socket = {}
cc.exports.MessageDispatcher = {}


local Socket    = Socket
local md        = MessageDispatcher
local Opcode    = Opcode
local MsgName   = MsgName


------------- Socket Event ----------------------------------

cc.exports.g_connect_pass = function()
    print("g_connect_pass +++++++++++++")
    -- 发送登录包
    Socket.SendPacket(Opcode.MSG_CS_LOGIN, {
        acct = "test001",
        pass = "1",
    })
end


cc.exports.g_connect_fail = function()
    print("g_connect_fail +++++++++++++")
end


cc.exports.g_on_message = function(code, data, size)
    local name = MsgName[code]; assert(name, string.format("g_on_message: Not FOUND name for opcode=%d", code))
    if size == 0 then
        data = ""
    end

    local tab, err = protobuf.decode(name, data, size)
    assert(tab, string.format("protobuf.decode failed for opcode=%d, err=%s", code, err))
    local func = md[code]
    if func then
        protobuf.extract(tab)
        func(tab)
    else
        print("unknown opcode:", code)
    end
end


cc.exports.g_on_closed = function()
    print("g_on_closed +++++++++++++")
end


------------- API ----------------------------------

Socket.Connect = function(addr, port)
    GameSocket.connect(addr, port)
end


Socket.SendPacket = function(code, tab)
    local name = MsgName[code]; assert(name, string.format("SendPacket: Not FOUND name for opcode=%d", code))
    local body = protobuf.encode(name, tab)
    local size = #body
    local data = struct.pack(string.format("<hhc%d", size), size, code, body)
    GameSocket.send(data)
    -- assert((size+4) == struct.size(string.format("<hhc%d",size)), "struct.pack error !!!")
end


Socket.Close = function()
    GameSocket.close()
end


------------- DO ----------------------------------

Socket.Connect("192.168.0.4", 4040)
