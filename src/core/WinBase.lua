
local WinBase = class("WinBase", cc.Layer)


function WinBase:ctor()
    print("WinBase:ctor")
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(self.OnTouchBegan,       cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(self.OnTouchMoved,       cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(self.OnTouchEnded,       cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(self.OnTouchCancelled,   cc.Handler.EVENT_TOUCH_CANCELLED)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end




function WinBase:OnShow()
    print("WinBase:OnShow")
end


function WinBase:OnHiden()
    print("WinBase:OnHiden")
end


function WinBase:OnCreate()
    print("WinBase:OnCreate")
end


function WinBase:OnDestroy()
    print("WinBase:OnDestroy")
end


--------------------------------------------------

function WinBase:OnTouchBegan()
    return true
end

function WinBase:OnTouchMoved()
end

function WinBase:OnTouchEnded()
end

function WinBase:OnTouchCancelled()
end


return WinBase
