local WinBase       = require "core.WinBase"
local HeroWin       = class("HeroWin", WinBase)


function HeroWin:ctor()
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


end


function HeroWin:OnCreate()
end


function HeroWin:OnDestroy()
end


function HeroWin:OnShow()
end


function HeroWin:OnHiden()
end


---------------------------------------------------------
function HeroWin:ShowHeroDetail(index)
end


return HeroWin
