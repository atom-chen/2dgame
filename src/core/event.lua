
local _seq = 1
local function seq()
    _seq = _seq + 1
    return _seq
end


local Event =
{
    ConnectOK           = seq(),        -- 网络连接成功
    ConnectFailed       = seq(),        -- 网络连接失败
    ConnectClosed       = seq(),        -- 网络连接断开

    LoginOK             = seq(),        -- 登录成功
    LoginFailed         = seq(),        -- 登录失败

    -- 进入游戏
    EnterGameOk         = seq(),
    EnterGameFailed     = seq(),
}

return Event