
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local GmWin         = class("GmWin", WinBase)


function GmWin:ctor()
    self.resourceNode_ = cc.CSLoader:createNode("1.layer/gm.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    self.resourceNode_:getChildByName("btn_close"):addClickEventListener(function()
        self:Close()
    end)

    -- GMWin功能
    self.resourceNode_:getChildByName("btn_1"):addClickEventListener(function()
        print("I can, I Can")
    end)
end


------------------------------ inhert from WinBase ------------------------------

function GmWin:OnCreate()
end


function GmWin:OnDestroy()
    print("GmWin:OnDestroy")
end


function GmWin:OnShow()
    print("GmWin:OnShow")
end


function GmWin:OnHiden()
    print("GmWin:OnHiden")
end


return GmWin
