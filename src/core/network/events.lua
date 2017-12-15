
require "core.network.protobuf"
require "struct"

protobuf.register(cc.FileUtils:getInstance():getDataFromFile("protocol.pb"))

------------- Socket Event ----------------------------------

cc.exports.g_connect_pass = function()
    print("g_connect_pass +++++++++++++")
end


cc.exports.g_connect_fail = function()
    print("g_connect_fail +++++++++++++")
end


cc.exports.g_on_message = function(code, msg, size)
    print("g_on_message +++++++++++++")
    print("code:", code)
    print("msg:", msg)
    print("size:", size)
  -- GameSocket.send("\x0e\x00\x02\x11", 4)
  -- GameSocket.send(msg, 0xe)
    print("__________")
    local data = struct.pack(string.format("hhc%d", size), code, size, msg)
    GameSocket.send(data)
    print("size is equal:", size + 4 , struct.size(string.format("hhc%d", size)))
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

Socket.Connect("192.168.0.5", 2040)
