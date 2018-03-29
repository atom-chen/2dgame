local WinBase       = require "core.WinBase"
local PlayerItem    = require "model.player_item"
local ItemWin       = class("ItemWin", WinBase)


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
    
    self.list_view = ccui.ListView:create();  
    self.list_view:setPosition(cc.p(-230, 10));
    self.list_view:setContentSize(cc.size(616, 250));  
    self.list_view:setDirection(1);  --cc.SCROLLVIEW_DIRECTION_BOTH
    self.list_view:setBounceEnabled(true);  
    self.list_view:setItemsMargin(20)  
    
    self.list_view:setBackGroundImageScale9Enabled(true)
    self.list_view:setBackGroundImage("arena_slat_004.png")

    for i = 1, 4 do  
        local layout = ccui.Layout:create();  
        layout:setContentSize(cc.size(48, 48));  
        layout:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid);  
        layout:setBackGroundColor(cc.c3b(125, 66, 126));  
        self.list_view:pushBackCustomItem(layout);  
    end  

    self:addChild(self.list_view);

    self:Refresh()
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

end


return ItemWin
