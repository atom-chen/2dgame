
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
require "base.init"
require "core.init"
require "message.init"

-- zcg.logTable(debug.getregistry(), "e:/reg.txt")
-- import project file


-- print("+++", type(cc.Node), cc.Node[".isclass"])
local function main()
    -- require("app.MyApp"):create():run()
    local director = cc.Director:getInstance()
    director:setDisplayStats(true)
    director:setAnimationInterval(1.0 / 30)
    local s = require("scenes.LoginScene"):new()
    display.runScene(s)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
