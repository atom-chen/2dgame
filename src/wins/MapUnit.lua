
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"


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
    WinManager:CreateWindow("NpcMenuWin", self.proto.id)
end


return MapUnit