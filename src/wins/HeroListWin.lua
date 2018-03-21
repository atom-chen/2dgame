local WinBase       = require "core.WinBase"
local Armature      = require "core.armature"


local HeroListWin   = class("HeroListWin", WinBase)


function HeroListWin:ctor()
    print("HeroListWin:ctor")

    -- 关闭按钮
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(525, 275))
    self:addChild(btn_close)
    btn_close:registerControlEventHandler(function()
        WinManager:DestroyWindow(self)
    end, 32)

    -- 输入框
    local editbox = ccui.EditBox:create(cc.size(600, 80), "btn_scale9.png")
    editbox:setPosition(0, 250)
    editbox:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    editbox:onEditHandler(function(event)
        if event.name == "return" then
            local str = editbox:getText()
            print("ddd, str", str)
                if self._arm then
                    self._arm:removeFromParent()
                end
                self._arm = Armature:create(str, "attack")
                self:addChild(self._arm)
        end
    end)
    self:addChild(editbox)
end


function HeroListWin:OnCreate()
    print("HeroListWin:OnCreate")
end


function HeroListWin:OnDestroy()
    print("HeroListWin:OnDestroy")
end


function HeroListWin:OnShow()
    print("HeroListWin:OnShow")
end


function HeroListWin:OnHiden()
    print("HeroListWin:OnHiden")
end


-------------------------------------------------------------------------------------------------------






return HeroListWin
