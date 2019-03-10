
local config        = require "configs_grace"
local MapUnit       = require "wins.MapUnit"
-- local NpcMenuWin    = require "wins.NpcMenuWin"

local WinManager = require "core.WinManager"


-- local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local MainScene = class("MainScene", cc.Scene)

function MainScene:ctor()
    -- 可滑动的大背景图
    local bg = cc.Sprite:create("bg.jpg")
    local bg_size = bg:getContentSize()
    local layer = cc.Layer:create()
    layer:addChild(bg)
    layer:setContentSize(bg_size)
    layer:setPosition(bg_size.width/2, bg_size.height/2)
    layer:addTo(self)

    self._layer = layer

    -- 加触摸事件
    local beginLocation = nil
    local beginX,beginY = nil, nil
    local win_size = cc.Director:getInstance():getWinSize()

    local function onTouchBegan(touch, event)
        beginLocation = touch:getLocation()
        beginX,beginY = layer:getPosition()
        -- CCTOUCHBEGAN event must return true
        return true
    end

    local function onTouchMoved(touch, event)
        local cx, cy = layer:getPosition()
        local top = cy + bg_size.height / 2
        local bot = cy - bg_size.height / 2
        local lef = cx - bg_size.width  / 2
        local rig = cx + bg_size.width  / 2

        local currLocation = touch:getLocation()
        local mx = currLocation.x - beginLocation.x
        local my = currLocation.y - beginLocation.y

        local c
        if top + my < win_size.height then
            my = win_size.height - top
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
        if rig + mx < win_size.width then
            mx = win_size.width - rig
            c = true
        end

        beginX = beginX + mx
        beginY = beginY + my
        layer:setPosition(beginX, beginY)
        beginLocation = currLocation
    end

    local function onTouchEnded(touch, event)
        beginLocation = nil
        beginX = nil
        beginY = nil

        local p = layer:convertToNodeSpace(touch:getLocation())
        print("currLocation:", p.x, p.y)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    WinManager:CreateWindow("ToolbarWin")
    WinManager:AttachScene(self)
end


function MainScene:OnEnter()
    print("MainScene:OnEnter")
    -- 拉取玩家数据
    Socket.SendPacket(Opcode.MSG_CS_PlayerDataRequest, {
        Id = 2,
    })

    self:render_world()
end


function MainScene:OnLeave()
    print("MainScene:OnLeave")
end

-------------------------------------------------------------------------------
function MainScene:render_world()
    self.objs = {}
    for _, v in pairs(config.GetSceneObjects(2000)) do
        local obj = MapUnit:create(v, self)
        self.objs[v.id] = obj
        self._layer:addChild(obj._root)
    end

end


-------------------------------------------------------------------------------
return MainScene
