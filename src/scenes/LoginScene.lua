
-- require "core.socket_events"

local scheduler     = require "core.scheduler"
local WinManager    = require "core.WinManager"
local Event         = require "core.event"
local EventMgr      = require "core.event_mgr"
local SceneMgr      = require "scenes.SceneMgr"


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


function LoginScene:OnEnter()
    print("LoginScene:OnEnter")
end


function LoginScene:OnLeave()
    print("LoginScene:OnLeave")
end


function LoginScene:__enter_game()
    self:SetLoginStatus("进入游戏...")

    local _on_event_enter_game = function(event, args)
        if event == Event.EnterGameOk then
            self:SetLoginStatus("进入游戏成功，加载场景。。。")
            scheduler.Once(function()
                -- 进入主场景
                SceneMgr.RunScene("MainScene")
            end, 0.5)
        else
            self:SetLoginStatus("进入游戏失败，你登录过了吗？")
        end
    end

    EventMgr.RegisterEvent({Event.EnterGameOk,Event.EnterGameFailed}, _on_event_enter_game, true)

    Socket.SendPacket(Opcode.MSG_CS_ENTER_GAME, {
    })
end


function LoginScene:__login()
    local _on_event_login = function(event, args)
        if event == Event.LoginOK then
            self:SetLoginStatus("登录成功，准备进入游戏。。。")
            scheduler.Once(function() self:__enter_game() end, 0.5)
        else
            self:SetLoginStatus("登录失败，请检查用户名密码。")
        end
    end

    EventMgr.RegisterEvent({Event.LoginOK,Event.LoginFailed}, _on_event_login, true)

    -- 发送登录包
    Socket.SendPacket(Opcode.MSG_CS_LOGIN, {
        acct = "test001",
        pass = "1",
    })
end


function LoginScene:__connect()
    self:SetLoginStatus("开始连接...")

    local _on_event_connect = function(event, args)
        if event == Event.ConnectOK then
            self:SetLoginStatus("连接服务器成功，准备登录。。。")
            scheduler.Once(function() self:__login() end, 0.5)
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
