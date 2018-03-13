
local WinBase = class("WinBase", cc.Layer)


function WinBase:ctor()
    print("WinBase:ctor")
end

function WinBase:OnShow()
    print("WinBase:OnShow")
end


function WinBase:OnHiden()
    print("WinBase:OnHiden")
end


function WinBase:OnCreate()
    print("WinBase:OnCreate")
end


function WinBase:OnDestroy()
    print("WinBase:OnDestroy")
end


return WinBase
