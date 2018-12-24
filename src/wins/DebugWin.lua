local DebugWin = class("DebugWin", function ()
	return cc.Layer:create()
end)

function DebugWin:ctor(msg)
    WinBase.ctor(self)

    -- cc.Director:getInstance():pause()
	self.msg = string.sub(msg, 1, 500)

    local size = cc.Director:getInstance():getWinSize()
    self:setPosition(cc.p(size.width / 2, size.height / 2))
    self:setLocalZOrder(100000)

    local bg = cc.Sprite:create("public/public_slat_060.png")
    self:addChild(bg)

    local msg = cc.Label:createWithSystemFont(self.msg, "Yahei", 20, cc.size(530, 450))
    bg:addChild(msg)
    -- display.align(msg, display.TOP_LEFT, 30, 480)

    local egbutton = ccui.Scale9Sprite:create("unKnown.png")
    local close = cc.ControlButton:create(egbutton)
    close:setPreferredSize(egbutton:getPreferredSize())
    close:setPosition(cc.p(295, 20))
    bg:addChild(close)

    local function closeFunc()
        self:removeFromParent()
        cc.Director:getInstance():resume()
    end

    close:registerControlEventHandler(closeFunc,32)
end

return DebugWin