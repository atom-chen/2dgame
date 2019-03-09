local Armature      = require "core.armature"
local WinBase       = require "core.WinBase"
local PlayerItem    = require "model.player_item"
local PlayerHero    = require "model.player_hero"
local config        = require "configs_grace"


------------------------------------------------------------------------------------

local BattleTeamWin = class("BattleTeamWin", WinBase)

function BattleTeamWin:ctor()
    print("BattleTeamWin:ctor")

    WinBase.ctor(self)

    self.selected = {}

    self.shieldLayer_ = cc.LayerColor:create(cc.c4b(0,0,0,200)):addTo(self, -1)
    self.shieldLayer_:setIgnoreAnchorPointForPosition(false)    
    self.shieldLayer_:setAnchorPoint(0.5, 0.5)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/battle.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    -- 两个关闭按钮
    local btn = self.resourceNode_:getChildByName("btn_close1")
    btn:addClickEventListener(function()
        self:Close()
    end)

    local img = self.resourceNode_:getChildByName("btn_close")
    img:setTouchEnabled(true)
    img:onTouch(function(event)
        if event.name == "ended" then
            self:Close()
        end 
    end)

    -- 战斗
    local btn_fight = self.resourceNode_:getChildByName("btn_fight")
    btn_fight:addClickEventListener(function()
        -- 发送攻打关卡消息
        local msg = { Team = {} }
        for i = 1, 2 do
            for j = 1, 3 do
                local name = "row" .. i .. j
                local id = self.selected[name]
                if not id then id = 0 end 
                table.insert(msg.Team, id)
            end
        end
        Socket.SendPacket(Opcode.MSG_CS_ChapterFightingRequest, msg)
        self:Close()
    end)

    for i = 1, 2 do
        for j = 1, 3 do
            local name = "row" .. i .. j
            local root = self.resourceNode_:getChildByName(name)
            local k = (i-1) * 3 + j
            local m = ccui.ImageView:create("0.public/hero-hole.png")
            root:addChild(m)

            m:setTouchEnabled(true)
            m:onTouch(function(event)
                if event.name == "ended" then
                    WinManager:CreateWindow("HeroSelectWin", self.selected, function(id)
                        self.selected[name] = id
                        m:removeChildByTag(k)
                        
                        if id == 0 then return end

                        local tab = PlayerHero.GetHero(id)
                        local arm = Armature:create(tab.proto.model)
                        m:removeChildByTag(k)
                        m:addChild(arm, 1, k)
                    end)                    
                end
            end)

        end
    end

end


function BattleTeamWin:OnCreate()
    print("BattleTeamWin:OnCreate")
end


function BattleTeamWin:OnDestroy()
    print("BattleTeamWin:OnDestroy")
end


function BattleTeamWin:OnShow()
    print("BattleTeamWin:OnShow")
end


function BattleTeamWin:OnHiden()
    print("BattleTeamWin:OnHiden")
end


---------------------------------------------------------

return BattleTeamWin
