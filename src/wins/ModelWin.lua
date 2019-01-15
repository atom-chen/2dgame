local WinBase       = require "core.WinBase"
local Armature      = require "core.armature"


local ModelWin      = class("ModelWin", WinBase)


function ModelWin:ctor()
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
        WinManager:DestroyWindow(self)
    end, 32)

    -- 输入框
    local editbox = ccui.EditBox:create(cc.size(600, 80), "btn_scale9.png")
    editbox:setPosition(0, 250)
    editbox:setInputMode(cc.EDITBOX_INPUT_MODE_SINGLELINE)
    editbox:onEditHandler(function(event)
        if event.name == "return" then
            local str = editbox:getText()
            if #str > 0 then
                if self._arm then
                    self._arm:removeFromParent()
                    self._arm = nil
                end           
                self._arm = Armature:create(str, "attack")
                self:addChild(self._arm)
            end
        end
    end)
    self:addChild(editbox)

    local btn_text =
    {
        "idle",
        "run",
        "hit",
        "dead",
        "shengli",
        "attack",
        "skill1",
        "skill2",
    }
    for i = 1, #btn_text do
        local btn = ccui.Button:create("public_button_001.png", "public_button_002.png", "public_button_003.png")
        local function btn_callback(ref, type)
            if type == ccui.TouchEventType.ended then
                if self._arm then
                local text = ref:getTitleText()
                    self._arm:Play(text)
                end
            end
        end
        btn:addTouchEventListener(btn_callback)
        btn:setPosition(470, 250-(i*50))
        btn:setTitleText(btn_text[i])
        btn:setTitleFontSize(18)
        self:addChild(btn)
    end

end


function ModelWin:OnCreate()
    print("ModelWin:OnCreate")
end


function ModelWin:OnDestroy()
    print("ModelWin:OnDestroy")
end


function ModelWin:OnShow()
    print("ModelWin:OnShow")
end


function ModelWin:OnHiden()
    print("ModelWin:OnHiden")
end


return ModelWin
