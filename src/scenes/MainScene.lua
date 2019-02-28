
local config        = require "configs_grace"
local MapUnit       = require "wins.MapUnit"
-- local NpcMenuWin    = require "wins.NpcMenuWin"

local WinManager = require "core.WinManager"


-- local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local MainScene = class("MainScene", cc.Scene)

function MainScene:ctor()
    -- 可滑动的大背景图
    local bg = cc.Sprite:create("bg.jpg")
    local bg_size = bg:getContentSize()
    local layer = cc.Layer:create()
    layer:addChild(bg)
    layer:setContentSize(bg_size)
    layer:setPosition(bg_size.width/2, bg_size.height/2)
    layer:addTo(self)

    self._layer = layer

    -- 加触摸事件
    local beginLocation = nil
    local beginX,beginY = nil, nil
    local win_size = cc.Director:getInstance():getWinSize()

    local function onTouchBegan(touch, event)
        beginLocation = touch:getLocation()
        beginX,beginY = layer:getPosition()
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onTouchMoved(touch, event)
        local cx, cy = layer:getPosition()
        local top = cy + bg_size.height / 2
        local bot = cy - bg_size.height / 2
        local lef = cx - bg_size.width  / 2
        local rig = cx + bg_size.width  / 2

        local currLocation = touch:getLocation()
        local mx = currLocation.x - beginLocation.x
        local my = currLocation.y - beginLocation.y

        local c
        if top + my < win_size.height then
            my = win_size.height - top
            c = true
        end
        if bot + my > 0 then
            my = 0 - bot
            c = true
        end
        if lef + mx > 0 then
            mx = 0 - lef
            c = true
        end
        if rig + mx < win_size.width then
            mx = win_size.width - rig
            c = true
        end

        beginX = beginX + mx
        beginY = beginY + my
        layer:setPosition(beginX, beginY)
        beginLocation = currLocation
    end

    local function onTouchEnded(touch, event)
        beginLocation = nil
        beginX = nil
        beginY = nil

        local p = layer:convertToNodeSpace(touch:getLocation())
        print("currLocation:", p.x, p.y)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    --------------------------- GM功能按钮 ---------------------------
    -- HeroModel
    local btn = ccui.Button:create("public_button_001.png")
    layer:addChild(btn)
    btn:setContentSize(162, 40)
    btn:setTitleText("HeroModel")
    btn:getTitleLabel():setSystemFontSize(24)
    btn:setPosition(-1600, -100)
    btn:addClickEventListener(function()
        WinManager:CreateWindow("ModelWin")
    end)
    -- BagWin
    local btn = ccui.Button:create("public_button_001.png")
    layer:addChild(btn)
    btn:setContentSize(162, 40)
    btn:setTitleText("BagWin")
    btn:getTitleLabel():setSystemFontSize(24)
    btn:setPosition(-1400, -100)
    btn:addClickEventListener(function()
        WinManager:CreateWindow("BagWin")
    end)
    -- HeroWin
    local btn = ccui.Button:create("public_button_001.png")
    layer:addChild(btn)
    btn:setContentSize(162, 40)
    btn:setTitleText("HeroWin")
    btn:getTitleLabel():setSystemFontSize(24)
    btn:setPosition(-1200, -100)
    btn:addClickEventListener(function()
        WinManager:CreateWindow("HeroWin")
    end)
    -- 播放战斗
    local btn = ccui.Button:create("public_button_001.png")
    layer:addChild(btn)
    btn:setContentSize(162, 40)
    btn:setTitleText("播放战斗")
    btn:getTitleLabel():setSystemFontSize(24)
    btn:setPosition(-1000, -100)
    btn:addClickEventListener(function()
        Socket.SendPacket(Opcode.MSG_CS_MakeBattle, { id = 1, })
    end)

    --------------------------- GM功能按钮 END ---------------------------

    -- add text label
    local label = cc.Label:createWithSystemFont("Hello, Preboy.ZHANG!", "Arial", 40)
    label:setColor(cc.YELLOW)
    label:setPosition(-1000, 0)
    layer:addChild(label)

    local btn_text =
    {
        "创建",
        "销毁",
        "显示",
        "隐藏",
        "None",
    }
    -- 功能按钮
    for i = 1, 5 do
        -- local str = {}
        -- for j = 1, 3 do
        --     str[j] = string.format("gem%d0%d.png", j, i)
        -- end
        -- local btn = ccui.Button:create(unpack(str))
        local btn = ccui.Button:create("btn-b-0.png", "btn-b-1.png", "btn-b-2.png")
        local function btn_callback(ref, type)
            if type == ccui.TouchEventType.ended then
                if i == 1 then
                    WinManager:CreateWindow("ToolbarWin")
                elseif i == 2 then
                    WinManager:DestroyWindow("ToolbarWin")
                elseif i == 3 then
                    WinManager:ShowWindow("ToolbarWin", true)
                elseif i == 4 then
                    local win = WinManager:FindWindow("ToolbarWin")
                    if win then WinManager:ShowWindow(win, false) end
                else
                    -- none
                    -- local DebugWin = require "wins.DebugWin"
                    -- local dbg = DebugWin:create("preboy.ZHANG")
                    -- self:addChild(dbg)
                    -- WinManager:CreateWindow("MapWin", 2001)
                    WinManager:CreateWindow("BattleTeamWin")
                end
            end
        end
        btn:addTouchEventListener(btn_callback)
        btn:setPosition(-1800 + i * 200, -300)
        btn:setTitleText(btn_text[i])
        btn:setTitleFontSize(18)
        layer:addChild(btn)
    end

    --[[
        local image = cc.Image:new()
        image:initWithImageFile("button_collect.jpg")
        local texture = cc.Texture2D:new()
        texture:initWithImage(image)
        local sf1 = cc.Sprite:createWithTexture(texture, {x=0, y=0, width=400, height=400})
    --]]
    local sf1 = cc.Sprite:create("button_collect.jpg", {x=0, y=0, width=400, height=400})
    layer:addChild(sf1)

    WinManager:AttachScene(self)

end


function MainScene:OnEnter()
    print("MainScene:OnEnter")
    -- 拉取玩家数据
    Socket.SendPacket(Opcode.MSG_CS_PlayerData, {
        id = 2
    })

    self:render_world()
end


function MainScene:OnLeave()
    print("MainScene:OnLeave")
end

-------------------------------------------------------------------------------
function MainScene:render_world()
    self.objs = {}
    for _, v in pairs(config.GetSceneObjects(2000)) do
        local obj = MapUnit:create(v, self)
        self.objs[v.id] = obj
        self._layer:addChild(obj._root)
    end

end


-------------------------------------------------------------------------------
return MainScene
