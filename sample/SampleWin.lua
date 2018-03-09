
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"


local BattleWin = class("BattleWin", WinBase)

function BattleWin:ctor()
    print("BattleWin:ctor")
end


------------------------------ inhert from WinBase ------------------------------

function BattleWin:OnCreate()
   print("BattleWin:OnCreate")
   -- 创建背景
end


function BattleWin:OnDestroy()
    print("BattleWin:OnDestroy")
    self:getScheduler():unscheduleScriptEntry(self.timer_id)
end


function BattleWin:OnShow()
    print("BattleWin:OnShow")
end


function BattleWin:OnHiden()
    print("BattleWin:OnHiden")
end


return BattleWin
