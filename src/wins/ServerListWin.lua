
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local ServerListWin = class("ServerListWin", WinBase)


function ServerListWin:ctor()
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/serverlist.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)
end

-------------------------------------------------------------------------------

function ServerListWin:OnCreate(pseudo)
    self:get_server_list()
    self:get_player_list(pseudo)
end


function ServerListWin:OnDestroy()
    print("ServerListWin:OnDestroy")
end


function ServerListWin:OnShow()
    print("ServerListWin:OnShow")
end


function ServerListWin:OnHiden()
    print("ServerListWin:OnHiden")
end

-------------------------------------------------------------------------------

function ServerListWin:get_player_list(pseudo)

    local url = string.format("http://118.24.48.149:8400/plr_list?pseudo=%s", pseudo)
    local xhr = cc.XMLHttpRequest:new()

    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", url)

    local function callback()
        xhr:unregisterScriptHandler()

        local res = json.decode(xhr.response)
        if res then
            self.plr_list = res
            self:show_server_list()
        end
    end

    xhr:registerScriptHandler(callback)
    xhr:send()
end


function ServerListWin:get_server_list()

    local scene = display.getRunningScene()
    scene:SetLoginStatus("拉取服务器列表...")

    local url = "http://118.24.48.149:8400/svr_list"
    local xhr = cc.XMLHttpRequest:new()

    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", url)

    local function callback()
        xhr:unregisterScriptHandler()

        local res = json.decode(xhr.response)
        if res then
            self.svr_list = res
            self:show_server_list()
        end
    end

    xhr:registerScriptHandler(callback)
    xhr:send()
end

-------------------------------------------------------------------------------

local function get_position(i)
    local row = math.ceil(i / 4)
    local col = i % 4
    if col == 0 then col = 4 end

    local x = col * 200
    local y = row * 72

    return -600+x, 120-y
end

-------------------------------------------------------------------------------

function ServerListWin:show_server_list()
    if not self.svr_list or not self.plr_list then
        return
    end

    for _, v in ipairs(self.plr_list) do
        self.svr_list[v.svr].plr_name = v.name
    end

    local btn_callback = function(ref, type)
        if type == ccui.TouchEventType.ended then
            local scene = display.getRunningScene()
            scene:OnSelected(self.svr_list[ref.svr])
            self:Close()
        end
    end

    local seq = 0
    for k, v in pairs(self.svr_list) do
        seq = seq + 1

        local btn = ccui.Button:create(
            "ccs/gm/public_button_001.png",
            "ccs/gm/public_button_002.png",
            "ccs/gm/public_button_003.png")

        btn:setPosition(get_position(seq))

        btn.svr = k

        local str = v.name
        if v.plr_name then
            str = str .. ":" .. v.plr_name
        end

        btn:setTitleText(str)
        btn:addTouchEventListener(btn_callback)
        self:addChild(btn)
    end
end


-------------------------------------------------------------------------------

return ServerListWin
