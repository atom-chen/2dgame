
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"


require "base.init"
require "core.init"
require "message.init"
require "game"


local SceneMgr = require "scenes.SceneMgr"


local function main()
    -- require("app.MyApp"):create():run()

    local director = cc.Director:getInstance()
    director:setDisplayStats(true)
    director:setAnimationInterval(1.0 / 30)

    -- 加侦听键盘事件
    if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS then
        local node = cc.Node:create()
        director:setNotificationNode(node)

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
            elseif keyCode == cc.KeyCode.KEY_T then
                -- WinManager:CreateWindow("ModelWin")
            elseif keyCode == cc.KeyCode.KEY_C then
                os.execute("cls")
            end
        end
        local listener = cc.EventListenerKeyboard:create()
        listener:registerScriptHandler(onKeyboardPressed, cc.Handler.EVENT_KEYBOARD_PRESSED)
        local eventDispatcher = node:getEventDispatcher()
        eventDispatcher:addEventListenerWithSceneGraphPriority(listener, node)
    end

    SceneMgr.RunScene("LoginScene")
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
