
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
        local lef = cx - bg_size.width / 2
        local rig = cx + bg_size.width / 2

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
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
    
    -- add text label
    local label = cc.Label:createWithSystemFont("Hello, Preboy.ZHANG!", "Arial", 40)
    label:setColor(cc.YELLOW)
    label:setPosition(-1000, 0)
    layer:addChild(label)

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
                    WinManager:CreateWindow(1)
                elseif i == 2 then
                    WinManager:DestroyWindow(1)
                elseif i == 3 then
                    WinManager:ShowWindow(1, true)
                elseif i == 4 then
                    local win = WinManager:FindWindow(1)
                    if win then WinManager:ShowWindow(win, false) end
                end
            end
        end
        btn:addTouchEventListener(btn_callback)
        btn:setPosition(-1800 + i * 600, -300)
        btn:setTitleText("fuck" .. i)
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

    -- UI

    -- 加侦听键盘事件
    if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS then
    	local function onKeyboardPressed(keyCode, event)
            keyCode = tonumber(keyCode)
	        if keyCode == cc.KeyCode.KEY_Z then
                preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_GREEN)
                print("---------- zcg everywhere:", os.time())
                preboy:set_console_color()
                dofile("src/gm.lua")
                preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_GREEN)
                print("---------- zcg end.")
                preboy:set_console_color()
	        elseif keyCode == cc.KeyCode.KEY_C then
                SocketMgr:connect("ws://172.31.248.17:8080")
            end
	    end
        local listener = cc.EventListenerKeyboard:create()
        listener:registerScriptHandler(onKeyboardPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
        local eventDispatcher = layer:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
    end

    WinManager:AttachScene(self)
end

return MainScene
