
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local LoginWin      = class("LoginWin", WinBase)


function LoginWin:ctor()
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/login.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    -- 登录
    self.resourceNode_:getChildByName("btn_login"):addClickEventListener(function()
        local acct = self.resourceNode_:getChildByName("tf_acct"):getString()
        local pass = self.resourceNode_:getChildByName("tf_pass"):getString()
        self:login(acct, pass)
    end)
end

-------------------------------------------------------------------------------

function LoginWin:OnCreate()
end


function LoginWin:OnDestroy()
    print("LoginWin:OnDestroy")
end


function LoginWin:OnShow()
    print("LoginWin:OnShow")
end


function LoginWin:OnHiden()
    print("LoginWin:OnHiden")
end

-------------------------------------------------------------------------------

function LoginWin:login(acct, pass)

    local scene = display.getRunningScene()
    scene:SetLoginStatus("登录SDK中...")

    local url = "http://118.24.48.149:8100/acct/login"
    local xhr = cc.XMLHttpRequest:new()

    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("POST", url)

    local function callback()
        xhr:unregisterScriptHandler()

        local res = json.decode(xhr.response)

        if res.ret then
            scene:OnAuth(res.pseudo, res.token)
            self:Close()
        else
            scene:SetLoginStatus("登录失败:" .. res.msg)
        end
    end

    xhr:registerScriptHandler(callback)

    local args = string.format("acct=%s&passwd=%s", acct, pass)
    xhr:send(args)
end

-------------------------------------------------------------------------------

return LoginWin
