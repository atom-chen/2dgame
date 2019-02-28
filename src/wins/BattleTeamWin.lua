local WinBase       = require "core.WinBase"
local PlayerItem    = require "model.player_item"
local config        = require "configs_grace"


------------------------------------------------------------------------------------

local BattleTeamWin = class("BattleTeamWin", WinBase)

function BattleTeamWin:ctor()
    print("BattleTeamWin:ctor")

    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("/layer/battle.csb")
    self.resourceNode_:setPosition(0, 0)
    self.resourceNode_:ignoreAnchorPointForPosition(true)    
    self:addChild(self.resourceNode_)

    print("r11=",  self.resourceNode_:getChildByName("row11") )

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
