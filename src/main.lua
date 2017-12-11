
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
require "base.init"
require "core.init"


-- zcg.logTable(debug.getregistry(), "e:/reg.txt")

-- import project file


-- print("+++", type(cc.Node), cc.Node[".isclass"])
local function main()
    -- require("app.MyApp"):create():run()
    local s = require("scenes.MainScene"):new()
    display.runScene(s)
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
