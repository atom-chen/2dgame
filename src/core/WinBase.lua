local WinBase = class("WinBase", cc.load("mvc").ViewBase)

function WinBase:ctor()
    print("WinBase:ctor")
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(handler(self, self.OnTouchBegan),       cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(handler(self, self.OnTouchMoved),       cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(handler(self, self.OnTouchEnded),       cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(handler(self, self.OnTouchCancelled),   cc.Handler.EVENT_TOUCH_CANCELLED)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)

    -- model notice system
    self._model_handlers = {}
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
    EventMgr.Unregister(self)

    -- model notice system
    for name, model in pairs(self._model_handlers) do
        local m = FindModel(name)
        for _, h in ipairs(model) do
            m:Unregister(h)
        end
    end
end

-------------------------------------------------------------------------------

function WinBase:Close()
    WinManager:DestroyWindow(self)
end

-------------------------------------------------------------------------------

function WinBase:OnTouchBegan(touch, event)
    return true
end

function WinBase:OnTouchMoved(touch, event)
end

function WinBase:OnTouchEnded(touch, event)
    local s = self:getContentSize()
    local p = self:convertToNodeSpace(touch:getLocation())
    local r = cc.rect(-s.width/2, -s.height/2, s.width, s.height)
    local b =  cc.rectContainsPoint(r, p)
    self:OnTouch(b)
end

function WinBase:OnTouchCancelled(touch, event)
end

-- innor: touch end point is in dialog rect
function WinBase:OnTouch(innor)
end

-------------------------------------------------------------------------------

function WinBase:RegisterNotice(model_name, func_name)
    local h = handler(self, self[func_name])
    local m = FindModel(model_name)
    
    assert(m, "NOT exist model: " .. model_name)

    m:Register(h)

    local model = self._model_handlers[model_name]
    if not model then
        model = {}
        self._model_handlers[model_name] = model
    end
    table.insert(model, h)
end

-------------------------------------------------------------------------------

return WinBase
