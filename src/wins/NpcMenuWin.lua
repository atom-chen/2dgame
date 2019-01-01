
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"


-------------------------------------------------------------------------------

local NpcMenuWin    = class("NpcMenuWin", WinBase)


function NpcMenuWin:ctor()
    WinBase.ctor(self)
end


------------------------------ inhert from WinBase ----------------------------

function NpcMenuWin:OnCreate(npcid)
    self:Show(npcid)
end


function NpcMenuWin:OnDestroy()
    print("NpcMenuWin:OnDestroy")
end


function NpcMenuWin:OnShow()
    print("NpcMenuWin:OnShow")
end


function NpcMenuWin:OnHiden()
    print("NpcMenuWin:OnHiden")
end

-------------------------------------------------------------------------------

function NpcMenuWin:Show(npcid)

    local conf = config.GetQuest(npcid)
    
    -- 寻找可以接的任务
    
    -- 寻找可由交的任务 

    assert(conf, "NpcMenuWin:ShowMap:npcid" .. tostring(npcid))

    self.npcid = npcid
   
    return true
end



return NpcMenuWin
