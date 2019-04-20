
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
    scheduler.Once(function() self:__login() end, 0.5)

    WinManager:AttachScene(self)
end


function LoginScene:OnEnter()
    print("LoginScene:OnEnter")
end


function LoginScene:OnLeave()
    print("LoginScene:OnLeave")
    EventMgr.Unregister(self)
end


function LoginScene:SetLoginStatus(text)
    self._notice:setString(text)
end


function LoginScene:__login()
    self:SetLoginStatus("登录SDK中...")

    local url = "http://118.24.48.149:8100/acct/login"

    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("POST", url)

    local data = string.format("acct=%s&passwd=%s", "a1", "3333")
    local function on_auth()
        xhr:unregisterScriptHandler()
        local res = json.decode(xhr.response)

        if not res.ret then
            print("登录失败:", res.msg)
            return
        else
            self.data = {
                pseudo  = res.pseudo,
                token   = res.token,
                sdk     = "dx_and",
                svr     = "game1",
            }

            self:__connect(res)
        end
    end

    xhr:registerScriptHandler(on_auth)
    xhr:send(data)
end


function LoginScene:__connect()
    self:SetLoginStatus("开始连接...")

    local _on_event_connect = function(event, args)
        if event == Event.ConnectOK then
            self:SetLoginStatus("连接服务器成功，准备登录。。。")
            scheduler.Once(function() self:__auth() end, 0.5)
        else
            self:SetLoginStatus("连接服务器失败")
        end
    end

    EventMgr.Register(self, {Event.ConnectOK,Event.ConnectFailed}, _on_event_connect)

    Socket.Connect("127.0.0.1", 9001)
    -- Socket.Connect("118.24.48.149", 9002)
end


function LoginScene:__auth(res)
    local _on_event_login = function(event, args)
        if event == Event.LoginOK then
            self:SetLoginStatus("验证成功，进入游戏成功，加载场景。。。")
            scheduler.Once(function()
                -- 进入主场景
                SceneMgr.RunScene("MainScene")
            end, 0.5)
        else
            self:SetLoginStatus("验证失败")
        end
    end

    EventMgr.Register(self, {Event.LoginOK,Event.LoginFailed}, _on_event_login)

    -- 发送登录包
    Socket.SendPacket(Opcode.MSG_CS_LoginRequest, {
        Pseudo  = self.data.pseudo,
        Token   = self.data.token,
        Sdk     = self.data.sdk,
        Svr     = self.data.svr,
    })
end

return LoginScene
