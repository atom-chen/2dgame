
-- require "core.socket_events"

local scheduler     = require "core.scheduler"
local WinManager    = require "core.WinManager"
local Event         = require "core.event"
local EventMgr      = require "core.event_mgr"


local LoginScene = class("LoginScene", cc.Scene)


function LoginScene:ctor()
    -- add text label
    local layer = cc.Layer:create()
    local win_size = cc.Director:getInstance():getWinSize()
    layer:setContentSize(win_size)
    layer:setPosition(win_size.width/2, win_size.height/2)
    layer:addTo(self)

    -- title
    local label = cc.Label:createWithSystemFont("This is Login Scene !!!", "Arial", 40)
    label:setColor(cc.YELLOW)
    label:setPosition(0, 99)
    layer:addChild(label)

    -- notice
    local notice = cc.Label:createWithSystemFont("等待登录 !!!", "Arial", 20)
    notice:setColor(cc.RED)
    notice:setPosition(0, -299)
    layer:addChild(notice)
    
    self._notice = notice

    -- 定时器
    scheduler.Once(function() self:__connect() end, 0.5)

    WinManager:AttachScene(self)
end


function LoginScene:__connect()
    self:SetLoginStatus("开始连接...")
    
    local _on_event_connect = function(event, args)
        if event == Event.ConnectOK then
            self:SetLoginStatus("连接服务器成功")
            -- 发送登录包
            Socket.SendPacket(Opcode.MSG_CS_LOGIN, {
                acct = "test001",
                pass = "1",
            })
        else
            self:SetLoginStatus("连接服务器失败")
        end
    end

    EventMgr.RegisterEvent({Event.ConnectOK,Event.ConnectFailed}, _on_event_connect, true)

    Socket.Connect("127.0.0.1", 4040)
end


function LoginScene:SetLoginStatus(text)
    self._notice:setString(text)
end


return LoginScene
