
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

-- local Map = require("app.Map")

require("app.MyApp")


function MainScene:onCreate()
    -- 可滑动的大背景图
    local bg = cc.Sprite:create("bg.jpg")
    local bg_size = bg:getContentSize()
    local layer = cc.Layer:create()
    layer:addChild(bg)
    layer:setContentSize(bg_size)
    layer:setPosition(bg_size.width/2, bg_size.height/2)
    -- layer:move(display.cx, display.cy)
    layer:addTo(self)

    -- add label
    local label = cc.Label:createWithSystemFont("Hello, Preboy.ZHANG!", "Arial", 40)
    label:setColor(cc.YELLOW)
    label:setPosition(-1000, 0)
    layer:addChild(label)

    -- 加触摸事件
    local touchBeginPoint = nil
    local win_size = cc.Director:getInstance():getWinSize()

    local function onTouchBegan(touch, event)
        local location = touch:getLocation()
        -- local locationv = touch:getLocationInView()      -- 屏幕坐标
        local cx, cy = layer:getPosition()
        local v = layer:getContentSize()
        touchBeginPoint = {x = location.x, y = location.y}
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onTouchMoved(touch, event)
        local location = touch:getLocation()
        local cx, cy = layer:getPosition()

        local top = cy + bg_size.height / 2
        local bot = cy - bg_size.height / 2
        local lef = cx - bg_size.width / 2
        local rig = cx + bg_size.width / 2

        local mx = location.x - touchBeginPoint.x
        local my = location.y - touchBeginPoint.y

        if top < win_size.height then
            my = my + (win_size.height - top)
        end
        if bot > 0 then
            my = my - bot
        end
        if lef > 0 then
            mx = mx - lef
        end
        if rig < win_size.width then
            mx = mx + (win_size.width - rig)
        end
        layer:setPosition(cx + mx, cy + my)
        touchBeginPoint = {x = location.x, y = location.y}
    end

    local function onTouchEnded(touch, event)
        touchBeginPoint = nil
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

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
                    UIManager:createUI(UI_INDEX.UI_TOOLBAR)
                elseif i == 2 then
                    UIManager:destroyUI(UI_INDEX.UI_TOOLBAR)
                elseif i == 3 then
                    local ui = UIManager:getUI(UI_INDEX.UI_TOOLBAR)
                    if ui then ui:show(true) end
                elseif i == 4 then
                    local ui = UIManager:getUI(UI_INDEX.UI_TOOLBAR)
                    if ui then ui:show(false) end
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
    UIManager:init(self)

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
end

return MainScene
