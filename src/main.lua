
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"
require "preboy.init"

-- zcg.logTable(debug.getregistry(), "c:/reg.txt")

-- ¼ÓÔØ×Ô¶¨ÒåÈ«¾Ö¿â
require "app.OpCode"
require "app.BaseUI"
require "app.UIManager"
require "app.MsgDispatcher"
require "app.SocketMgr"
require "app.AnimLoader"


local function main()
    require("app.MyApp"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
