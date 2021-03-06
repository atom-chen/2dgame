local WinBase       = require "core.WinBase"
local SampleWin     = class("SampleWin", WinBase)


function SampleWin:ctor()
    WinBase.ctor(self)
    print("SampleWin:ctor")
end


function SampleWin:OnCreate()
    print("SampleWin:OnCreate")
end


function SampleWin:OnDestroy()
    print("SampleWin:OnDestroy")
end


function SampleWin:OnShow()
    print("SampleWin:OnShow")
end


function SampleWin:OnHiden()
    print("SampleWin:OnHiden")
end


return SampleWin
