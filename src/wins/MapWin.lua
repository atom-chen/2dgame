
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"

local MapUnit       = require "wins.MapUnit"




-------------------------------------------------------------------------------
local MapWin = class("MapWin", WinBase)


function MapWin:ctor()
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/map.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)
    
    local btn = self.resourceNode_:getChildByName("btn_close")
    btn:addClickEventListener(function()
        self:Close()
    end)
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
    local bg = self.resourceNode_:getChildByName("bg")
    bg:removeAllChildren()
    self.sprite = cc.Sprite:create(conf.img_bg)
    bg:addChild(self.sprite)

    self.resourceNode_:getChildByName("map_name"):setText(conf.name)    
end


function MapWin:render_objects(conf)
    self.objs = {}
    for _, v in pairs(config.GetSceneObjects(conf.id) or {}) do
        local obj = MapUnit:create(v, self)
        self.objs[v.id] = obj
        self.sprite:addChild(obj._root)
    end
end


return MapWin
