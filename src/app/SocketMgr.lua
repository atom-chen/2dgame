
cc.exports.SocketMgr =
{
    _socket = nil,
    _isopen = false,
}


function SocketMgr:connect(url)
    if self._socket or self._isopen then
        return
    end
    
    self._dispatcher = MsgDispatcher 

    local function _on_open()
        self._isopen = true
        print("websocket was opened.")
    end

    local function _on_message(data)
        local obj = json.decode(data)
        self._dispatcher:onMessage(obj.opCode, obj.args)
    end

    local function _on_close()
        local socket = self._socket
        socket:unregisterScriptHandler(cc.WEBSOCKET_OPEN)
        socket:unregisterScriptHandler(cc.WEBSOCKET_MESSAGE)
        socket:unregisterScriptHandler(cc.WEBSOCKET_CLOSE)
        socket:unregisterScriptHandler(cc.WEBSOCKET_ERROR)
        self._isopen = false
        self._socket = nil
        print("websocket closed")
    end

    local function _on_error()
        print("------------------- websocket Error")
    end

    local socket = cc.WebSocket:create(url)
    socket:registerScriptHandler(_on_open,    cc.WEBSOCKET_OPEN)
    socket:registerScriptHandler(_on_message, cc.WEBSOCKET_MESSAGE)
    socket:registerScriptHandler(_on_close,   cc.WEBSOCKET_CLOSE)
    socket:registerScriptHandler(_on_error,   cc.WEBSOCKET_ERROR)
    self._socket = socket
end


function SocketMgr:disconnect()
    if self._socket then
        self._socket:close()
    end
end


function SocketMgr:isOpen()
    return self._isopen
end


function SocketMgr:send(opCode, args)
    if not self._socket or not self._isopen or not opCode then
        return
    end
    local obj =
    {
        opCode = opCode,
        args = args or {},
    }
    self._socket:sendString(json.encode(obj))
end
