
require "core.protobuf"
require "struct"

protobuf.register(cc.FileUtils:getInstance():getDataFromFile("protocol.pb"))

cc.exports.MessageDispatcher = {}
local md = MessageDispatcher

------------- Socket Event ----------------------------------

cc.exports.g_connect_pass = function()
    print("g_connect_pass +++++++++++++")
    -- 发送登录包
end


cc.exports.g_connect_fail = function()
    print("g_connect_fail +++++++++++++")
end


cc.exports.g_on_message = function(code, data, size)
    local name = code
   
    local tab = protobuf.decode(data)
    protobuf.extract(tab)

    local func = md[code]
    if func then
        func(code, tab)
    else
        print("unknown opcode:", code)
    end

    -- for debug
    print("recv message: ", code)
    table.dump(tab)
end


cc.exports.g_on_closed = function()
    print("g_on_closed +++++++++++++")
end


------------- API ----------------------------------

cc.exports.Socket = {}
local Socket = cc.exports.Socket


Socket.Connect = function(addr, port)
    GameSocket.connect(addr, port)
end


Socket.SendPacket = function(code, name, table)
    local body, size = protobuf.encode(name, table)
    local data = struct.pack(string.format("hhc%d", size), code, size, body)
    GameSocket.send(data)
    -- assert((size+4) == struct.size(string.format("hhc%d",size)), "struct.pack error !!!")
end


Socket.Close = function()
    GameSocket.close()
end


------------- DO ----------------------------------

Socket.Connect("192.168.0.5", 4040)
