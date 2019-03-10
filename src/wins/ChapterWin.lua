
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"



-------------------------------------------------------------------------------
local ChapterWin = class("ChapterWin", WinBase)


function ChapterWin:ctor()
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/chapter.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    -- 关闭
    local btn = self.resourceNode_:getChildByName("btn_close")
    btn:addClickEventListener(function()
        self:Close()
    end)

    -- 挂机奖励
    local btn = self.resourceNode_:getChildByName("btn_loot")
    btn:addClickEventListener(function()
        self:Close()
    end)

    -- 章节奖励
    local btn = self.resourceNode_:getChildByName("btn_chapter")
    btn:addClickEventListener(function()
        self:Close()
    end)
    
end


------------------------------ inhert from WinBase ----------------------------

function ChapterWin:OnCreate()
    self:update_view()    
end


function ChapterWin:OnDestroy()
    print("ChapterWin:OnDestroy")
end


function ChapterWin:OnShow()
    print("ChapterWin:OnShow")
end


function ChapterWin:OnHiden()
    print("ChapterWin:OnHiden")
end

-------------------------------------------------------------------------------

function ChapterWin:update_view()
    -- todo
end

return ChapterWin
