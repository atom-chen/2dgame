
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

    self:get_server_list()
end

-------------------------------------------------------------------------------

function ServerListWin:OnCreate()
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
            self:show_server_list(res)
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

function ServerListWin:show_server_list(svrs)

    local btn_callback = function(ref, type)
        if type == ccui.TouchEventType.ended then
            local scene = display.getRunningScene()
            scene:OnSelected(svrs[ref.svr])
            self:Close()
        end
    end

    local seq = 0
    for k, v in pairs(svrs) do
        seq = seq + 1

        local btn = ccui.Button:create(
            "ccs/gm/public_button_001.png",
            "ccs/gm/public_button_002.png",
            "ccs/gm/public_button_003.png")

        btn:setPosition(get_position(seq))

        btn.svr = k
        btn:setTitleText(v.name)
        btn:addTouchEventListener(btn_callback)
        self:addChild(btn)
    end
end


-------------------------------------------------------------------------------

return ServerListWin
