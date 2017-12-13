
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
    Socket.send("\x0e\x00\x02\x11", 4)
    Socket.send(msg, 0xe)
end


cc.exports.g_on_closed = function()
    print("g_on_closed +++++++++++++")
end


Socket.connect("192.168.0.5", 2040)