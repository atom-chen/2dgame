
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"

local NpcMenuWin    = require "wins.NpcMenuWin"

-------------------------------------------------------------------------------
local MapUnit = class("MapUnit")


function MapUnit:ctor(conf, parent)
    self.proto  = conf
    self.parent = parent
    self._root  = cc.Node:create()

    local arm = Armature:create(conf.model, "idle")
    arm:setPosition(conf.x, conf.y)
    arm:EnableTouchEvent(handler(self, self.onTouch))
    self._root:addChild(arm)
    self._arm = arm

    local name = cc.Label:createWithSystemFont(conf.name,  "Arial", 12)
    name:setPosition(30, 0)
    name:setColor(cc.RED)
    self._root:addChild(name)

    local title = cc.Label:createWithSystemFont(conf.title, "Arial", 12)
    title:setPosition(30, -20)
    title:setColor(cc.GREEN)
    self._root:addChild(title)

    self._root:setPosition(conf.x + 100, conf.y + 100)
end

function MapUnit:onTouch()
    print("ontouch:", self.proto.name, self.proto.id)
    WinManager:CreateWindow(7, self.proto.id)
end



-------------------------------------------------------------------------------
local MapWin        = class("MapWin", WinBase)


function MapWin:ctor()
    WinBase.ctor(self)

    -- 关闭按钮
    local winSize   = cc.Director:getInstance():getWinSize()
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(winSize.width/2, winSize.height/2))
    btn_close:registerControlEventHandler(function()
        WinManager:DestroyWindow(self)
    end, 32)
    self:addChild(btn_close, 1)
end


------------------------------ inhert from WinBase ----------------------------

function MapWin:OnCreate(mapid)
    self:ShowMap(mapid)
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

function MapWin:ShowMap(mapid)
    local conf = config.GetScene(mapid)
    assert(conf, "MapWin:ShowMap:mapid" .. tostring(mapid))

    self.mapid = mapid

    self:render_background(conf)
    self:render_objects(conf)

    return true
end


function MapWin:render_background(conf)
    self.bg = cc.Sprite:create(conf.img_bg)
    self:addChild(self.bg)
end


function MapWin:render_objects(conf)
    self.objs = {}
    for _, v in pairs(config.GetSceneObjects(conf.id)) do
        local obj = MapUnit:create(v, self)
        self.objs[v.id] = obj
        self.bg:addChild(obj._root)
    end
end


return MapWin
