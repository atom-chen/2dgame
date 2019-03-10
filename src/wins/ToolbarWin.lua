
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local ToolbarWin    = class("ToolbarWin", WinBase)


function ToolbarWin:ctor()
    self.resourceNode_ = cc.CSLoader:createNode("1.layer/toolbar.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    local root = self.resourceNode_:getChildByName("root")

    -- 横排，从右往左
    root:getChildByName("btn_1"):addClickEventListener(function()
        WinManager:CreateWindow("ModelWin")
    end)

    root:getChildByName("btn_2"):addClickEventListener(function()
        WinManager:CreateWindow("BagWin")
    end)

    root:getChildByName("btn_3"):addClickEventListener(function()
        WinManager:CreateWindow("HeroWin")
    end)

    root:getChildByName("btn_4"):addClickEventListener(function()
        WinManager:CreateWindow("GmWin")
    end)

    -- 竖排，从下往上
    root:getChildByName("btn_5"):addClickEventListener(function()
        WinManager:CreateWindow("ChapterWin")
    end)

    root:getChildByName("btn_6"):addClickEventListener(function()
    end)

end


------------------------------ inhert from WinBase ------------------------------

function ToolbarWin:OnCreate()
end


function ToolbarWin:OnDestroy()
    print("ToolbarWin:OnDestroy")
end


function ToolbarWin:OnShow()
    print("ToolbarWin:OnShow")
end


function ToolbarWin:OnHiden()
    print("ToolbarWin:OnHiden")
end


return ToolbarWin
