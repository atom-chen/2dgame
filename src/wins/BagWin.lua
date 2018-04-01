local WinBase       = require "core.WinBase"
local PlayerItem    = require "model.player_item"
local config        = require "configs_grace"

local ItemWin       = class("ItemWin", WinBase)



local function bag_item_on_touch(event)
    local item = event.target
    if event.name == "ended" then
        print("_________", item.id)
    end
end


local BagItem = class("BagItem",  function(bag, id, cnt)

    local widget =  ccui.ImageView:create("public_item_bg.png") --  ccui.Widget:create()
    widget:setSize(cc.size(100,100))
    widget:setColor(cc.BLUE)

--      local widget = cc.LayerColor:create( cc.BLUE,  100, 100 )
--      widget:setIgnoreAnchorPointForPosition(false)

      local p = widget:getAnchorPoint()
      table.print(p)


--    local bg_image = ccui.ImageView:create("public_item_bg.png")
--    bg_image:setTouchEnabled(false)
--    widget:addChild(bg_image)
--
--    -- widget:setBackGroundColor(cc.RED)
--
--    local image = ccui.ImageView:create(config.GetItemProto(id).icon)
--    image:setTouchEnabled(false)
--    widget:addChild(image)
--
    widget.text = cc.Label:create()
    widget.text:setPosition(0, 0)
    widget.text:setTextColor(cc.GREEN)
    widget:addChild(widget.text)

    widget:setTouchEnabled(true)
    widget:onTouch(bag_item_on_touch)

    return widget
end)


function BagItem:ctor(bag, id, cnt)
    self.id  = id
    self.cnt = cnt
    self.bag = bag
end


function BagItem:refresh_item_count()
    self.text:setString(tostring(self.cnt))
    -- l:setAnchorPoint(1, 0)
end



------------------------------------------------------------------------------------

function ItemWin:ctor()
    WinBase.ctor(self)

    -- 背景
    local bg = ccui.Scale9Sprite:create("bg_scale9.png")
    -- bg:setCapInsets(CCRectMake(10, 10, 46, 34))
    bg:setContentSize(cc.size(display.width, display.height))
    self:addChild(bg)

    -- 关闭按钮
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(525, 275))
    self:addChild(btn_close)
    btn_close:registerControlEventHandler(function()
        WinManager:DestroyWindow(self)
    end, 32)

   --[[
   removeAllItems
    ]]

    local scrollView = ccui.ScrollView:create()
    scrollView:setContentSize(cc.size(700, 250))
    scrollView:setPosition(cc.p(-230, 10))
    scrollView:setDirection(1)
    scrollView:setBackGroundImageScale9Enabled(true)
    scrollView:setBackGroundImage("arena_slat_004.png")

	scrollView:setScrollBarWidth(8)
	scrollView:setScrollBarColor(cc.c3b(225,213,99))

	--scrollView:setScrollBarPositionFromCornerForVertical(cc.p(22,20))

	local conSize = scrollView:getInnerContainerSize()
    scrollView:setInnerContainerSize(cc.size(conSize.width,conSize.height*4))

   
    self:addChild(scrollView)
    self.scrollView = scrollView

    self:Refresh()

    local l = cc.Label:create()
    l:setString("fuck")
    l:setPosition(20, 20)
    scrollView:addChild(l)

end


function ItemWin:OnCreate()
end


function ItemWin:OnDestroy()
end


function ItemWin:OnShow()
end


function ItemWin:OnHiden()
end


---------------------------------------------------------
function ItemWin:Refresh()
    	local scrollView = self.scrollView
        scrollView:removeAllChildren()


    for i = 1, 25 do
        local x, y

        x = i % 5
        if x == 0 then
            x = 5
        end

        if i % 5 == 0 then
            y = i / 5
        else
            y = math.floor(i / 5 )+ 1
        end

        local item = BagItem:create(self, 4001, i)
        item:setPosition(x*120, (y*120+10))
        item:refresh_item_count()

        scrollView:getInnerContainer():addChild(item)
       --  scrollView:addChild(item)

    end

end


return ItemWin
