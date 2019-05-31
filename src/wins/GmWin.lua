
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local PlayerHero    = require "model.player_hero"

local GmWin         = class("GmWin", WinBase)


function GmWin:ctor()
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/gm.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    self.resourceNode_:getChildByName("btn_close"):addClickEventListener(function()
        self:Close()
    end)

    -- gm.lua
    local btn = self.resourceNode_:getChildByName("btn_1")
    btn:setTitleText("gm.lua")
    :addClickEventListener(function()
        preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_GREEN)
        print("---------- zcg everywhere:", os.time())
        preboy:set_console_color()
        dofile("src/gm.lua")
        preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_GREEN)
        print("---------- zcg end.")
        preboy:set_console_color()
    end)

    -- 保存数据
    local btn = self.resourceNode_:getChildByName("btn_2")
    btn:setTitleText("保存数据")
    :addClickEventListener(function()
        MSG.SendGMCommand("save")
    end)

    -- 增加道具
    local btn = self.resourceNode_:getChildByName("btn_3")
    btn:setTitleText("增加道具")
    :addClickEventListener(function()
        MSG.SendGMCommand("item 4111|1 4112|1 4113|10")
    end)

    -- 添加英雄
    local btn = self.resourceNode_:getChildByName("btn_4")
    btn:setTitleText("添加英雄")
    :addClickEventListener(function()
        MSG.SendGMCommand("hero 5001 5002")
    end)

    -- 英雄属性(服务器)
    local btn = self.resourceNode_:getChildByName("btn_5")
    btn:setTitleText("英雄属性(S)")
    :addClickEventListener(function()
        MSG.SendGMCommand("prop")
    end)

    -- 英雄属性(客户端)
    local btn = self.resourceNode_:getChildByName("btn_6")
    btn:setTitleText("英雄属性(C)")
    :addClickEventListener(function()
        PlayerHero.Dump()
    end)

    -- 集市购买
    local btn = self.resourceNode_:getChildByName("btn_7")
    btn:setTitleText("集市购买")
    :addClickEventListener(function()
        MSG.SendMarketBuy(1, 3)
    end)

    -- 使用道具（有脚本的那种）
    local btn = self.resourceNode_:getChildByName("btn_8")
    btn:setTitleText("使用道具")
    :addClickEventListener(function()
        MSG.SendItemUse(4105, 2)
    end)

    -- 获取关卡信息
    local btn = self.resourceNode_:getChildByName("btn_9")
    btn:setTitleText("使用道具")
    :addClickEventListener(function()
        Socket.SendPacket(Opcode.MSG_CS_ChapterInfoRequest, {})
    end)

    -- 改角色名
    local btn = self.resourceNode_:getChildByName("btn_10")
    btn:setTitleText("改角色名")
    :addClickEventListener(function()
        Socket.SendPacket(Opcode.MSG_CS_ChangeNameRequest, {
            Name = "天赋二姐",
        })
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
