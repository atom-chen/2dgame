
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"


-------------------------------------------------------------------------------

local MapWin    = class("MapWin", WinBase)


function MapWin:ctor()
    print("MapWin:ctor")
    local layer = cc.Layer:create()
    layer:addTo(self)

    -- ´¥ÃþÊÂ¼þ
    self.layer          = layer
    self.beginX         = nil
    self.beginY         = nil
    self.beginLocation  = nil
    self.winSize        = cc.Director:getInstance():getWinSize()

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(handler(self, self.onTouchMoved), cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(handler(self, self.onTouchEnded), cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
end


------------------------------ inhert from WinBase ----------------------------

function MapWin:OnCreate()
end


function MapWin:OnDestroy()
    print("MapWin:OnDestroy")
end


function MapWin:OnShow()
    print("MapWin:OnShow")
end


function MapWin:OnHiden()
    print("MapWin:OnHiden")
end

-------------------------------------------------------------------------------

function MapWin:onTouchBegan(touch, event)
    self.beginLocation       = touch:getLocation()
    self.beginX, self.beginY = self.layer:getPosition()
    -- CCTOUCHBEGAN event must return true
    return true
end

function MapWin:onTouchMoved(touch, event)
    local cx, cy = self.layer:getPosition()
    local top = cy + self.bgSize.height / 2
    local bot = cy - self.bgSize.height / 2
    local lef = cx - self.bgSize.width  / 2
    local rig = cx + self.bgSize.width  / 2

    local currLocation = touch:getLocation()
    local mx = currLocation.x - self.beginLocation.x
    local my = currLocation.y - self.beginLocation.y

    local c
    if top + my < self.winSize.height then
        my = self.winSize.height - top
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
    if rig + mx < self.winSize.width then
        mx = self.winSize.width - rig
        c = true
    end

    self.beginX         = self.beginX + mx
    self.beginY         = self.beginY + my
    self.beginLocation  = currLocation

    self.layer:setPosition(self.beginX, self.beginY)
end

function MapWin:onTouchEnded(touch, event)
    self.beginX         = nil
    self.beginY         = nil
    self.beginLocation  = nil
end

-------------------------------------------------------------------------------

function MapWin:ShowMap(mapid)
    local conf = config.GetScene(mapid)
    if not conf then
        return false
    end

    self.SetBackground(conf)
    self.SetObjects(conf)

    return true
end


function MapWin:SetBackground()
    local bg = cc.Sprite:create(conf.img_bg)
    self.bgSize = bg:getContentSize()
    self.layer:addChild(bg)
    self.setContentSize(self.bgSize)
    self.setPosition(self.bgSize.width/2, self.bgSize.height/2)
end


return MapWin
