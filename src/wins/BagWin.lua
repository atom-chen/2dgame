local WinBase       = require "core.WinBase"
local PlayerItem    = require "model.player_item"
local config        = require "config.loader"


------------------------------------------------------------------------------------

local function bag_item_on_touch(event)
    local item = event.target
    if event.name == "ended" then
        item.bag:OnSelected(item)
    end
end


local BagItem = class("BagItem",  function(bag, id, cnt)
    local widget = ccui.Widget:create()
    widget:setContentSize(cc.size(100,100))
    widget:setAnchorPoint(display.LEFT_BOTTOM)

    local bg = ccui.ImageView:create("public_item_bg.png")
    bg:setAnchorPoint(display.LEFT_BOTTOM)
    widget:addChild(bg)

    local icon = ccui.ImageView:create(config.GetItemProto(id).icon)
    icon:setAnchorPoint(display.LEFT_BOTTOM)
    widget:addChild(icon)

    widget.text = cc.Label:create()
    widget.text:setPosition(75, 16)
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
end



------------------------------------------------------------------------------------

local ItemWin = class("ItemWin", WinBase)

function ItemWin:ctor()
    WinBase.ctor(self)

    -- 背景
    local bg = ccui.Scale9Sprite:create("bg_scale9.png")
    -- bg:setCapInsets(cc.rect(10, 10, 46, 34))
    bg:setContentSize(cc.size(display.width, display.height))
    self:addChild(bg)

    -- 关闭按钮
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(525, 275))
    self:addChild(btn_close)
    btn_close:registerControlEventHandler(function()
        self:Close()
    end, 32)

    -- scrollview
    local scrollView = ccui.ScrollView:create()
    scrollView:setContentSize(cc.size(700, 250))
    scrollView:setPosition(cc.p(-230, 10))
    scrollView:setDirection(1)
    scrollView:setBackGroundImageScale9Enabled(true)
    scrollView:setBackGroundImage("arena_slat_004.png")

	scrollView:setScrollBarWidth(8)
	scrollView:setScrollBarColor(cc.c3b(225,213,99))
	-- scrollView:setScrollBarPositionFromCornerForVertical(cc.p(22,20))

	local conSize = scrollView:getInnerContainerSize()
    scrollView:setInnerContainerSize(cc.size(conSize.width,conSize.height*4))

    self.scrollView = scrollView
    self:addChild(scrollView)

    self.sel_icon = ccui.ImageView:create("public_item_sel.png")
    self.sel_icon:retain()
    self.sel_icon:setAnchorPoint(display.LEFT_BOTTOM)
    scrollView:getInnerContainer():addChild(self.sel_icon)

    self:Refresh()
end


function ItemWin:OnCreate()
    self:RegisterNotice("PlayerItem", "on_player_item")
end


function ItemWin:OnDestroy()
end


function ItemWin:OnShow()
end


function ItemWin:OnHiden()
end


---------------------------------------------------------

-- type    0: 数量变化  1: 新增道具  2: 删除道具
function ItemWin:on_player_item(typ, id, cnt)
    --费了这么大的事，是不是比较直接？
    self.sel_item = nil
    self:Refresh()
end


function ItemWin:Refresh()
    local scrollView = self.scrollView
    scrollView:removeAllChildren()

    local items = PlayerItem:GetAllItems()
    local count = #items

    local rows
    if count % 5 == 0 then
        rows = count / 5
    else
        rows = math.floor(count/5) + 1
    end
    if rows < 2 then rows = 2 end
    local height = rows * 120 + 20

    local size = scrollView:getInnerContainerSize()
    scrollView:setInnerContainerSize(cc.size(size.width,height))

    local inner = scrollView:getInnerContainer()
    for i = 1, count do
        local x, y
        if i % 5 == 0 then
            x = 5
            y = i / 5
        else
            x = i % 5
            y = math.floor(i/5) + 1
        end
        local info = items[i]
        local item = BagItem:create(self, info[1], info[2])
        item:setPosition((x-1)*120+20, height-20-y*120)
        item:refresh_item_count()
        inner:addChild(item)
    end

    self.sel_icon:setVisible(false)
    inner:addChild(self.sel_icon)
end

function ItemWin:OnSelected(item)
    if self.sel_item == item then return end

    local x, y = item:getPosition()
    self.sel_icon:setPosition(x-7, y-7)
    self.sel_icon:setVisible(true)
    self.sel_item = item
end


return ItemWin
