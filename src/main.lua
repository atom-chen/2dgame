
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
    SceneMgr.RunScene("LoginScene")
end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
