
require "core.protobuf"
require "struct"

require "message.opcode"

local Event     = require "core.event"
local EventMgr  = require "core.event_mgr"


protobuf.register(cc.FileUtils:getInstance():getDataFromFile("src/message/protocol.pb"))

cc.exports.Socket = {}
cc.exports.MessageDispatcher = {}


local Socket    = Socket
local md        = MessageDispatcher
local Opcode    = Opcode
local MsgName   = MsgName


local __established = false
local __callback = {}


------------- Socket Event ----------------------------------

cc.exports.g_connect_pass = function()
    __established = true
    EventMgr.Emit(Event.ConnectOK)
end


cc.exports.g_connect_fail = function()
    EventMgr.Emit(Event.ConnectFailed)
end


cc.exports.g_on_message = function(code, data, size)
    local name = MsgName[code]; assert(name, string.format("g_on_message: Not FOUND name for opcode=%d", code))
    if size == 0 then
        data = ""
    end

    local tab, err = protobuf.decode(name, data, size); assert(tab, string.format("protobuf.decode failed for opcode=%d, err=%s", code, err))
    protobuf.extract(tab)

    -- error dispose
    local ErrorCode = rawget(tab, "ErrorCode")
    if ErrorCode ~= nil and ErrorCode ~= 0 then
        zcg.logError("OpCode = %d, ErrorCode = %d", code, ErrorCode)
    end

    -- message dispose
    local undisposed = false
    local func = md[code]
    if func then
        func(tab)
    else
        undisposed = true
    end
    -- response callback
    local func = __callback[code]
    if func then
        func(tab)
        __callback[code] = nil
        undisposed = false
    end

    if undisposed then
        zcg.logWarning("undisposed opcode: %d", code)
    end
end


cc.exports.g_on_closed = function()
    __established = false
    print("g_on_closed +++++++++++++")
    EventMgr.Emit(Event.ConnectClosed)
end


------------- API ----------------------------------

Socket.Connect = function(addr, port)
    if __established then
        print("connection already established")
        return
    end
    GameSocket.connect(addr, port)
end


Socket.SendPacket = function(code, tab, func)
    if not __established then
        print("connection was closed")
        return
    end
    local name = MsgName[code]; assert(name, string.format("Opcode=0x%.4X, MsgName=nil", code))
    local body = protobuf.encode(name, tab)
    local size = #body
    local data = struct.pack(string.format("<hhc%d", size), size, code, body)
    local send = GameSocket.send(data)
    if send == 0 then
        print("connection in closing")
        return
    end

    -- assert((size+4) == struct.size(string.format("<hhc%d",size)), "struct.pack error !!!")
    if func then
        if __callback[code+1] then
            print("exist callback will be covered")
        end
        __callback[code+1] = func
    end
end


Socket.Close = function()
    GameSocket.close()
end
