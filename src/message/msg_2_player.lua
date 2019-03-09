require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local PlayerBase = require "model.player_base"
local PlayerItem = require "model.player_item"
local PlayerHero = require "model.player_hero"


md[Opcode.MSG_SC_PlayerDataResponse] = function(tab)
    print("msg:MSG_SC_PlayerDataResponse")
    
    local base      = PlayerBase.GetBase()
    base.acct       = tab.Acct
    base.name       = tab.Name
    base.pid        = tab.Pid
    base.sid        = tab.Sid
    base.id         = tab.Id
    base.level      = tab.Level
    base.vipLevel   = tab.VipLevel
    base.male       = tab.Male

    for _, v in ipairs(tab.Items) do
        if v.Flag == 0 then
            PlayerItem.SetItemCount(v.Id, v.Cnt)
        else
            PlayerItem.ChgItemCount(v.Id, v.Cnt)
        end
    end

    for _, v in ipairs(tab.Heros) do
        PlayerHero.UpdateHero(v.Id, v)
    end
    PlayerHero.Sort()

    -- PlayerBase.Dump()
    -- PlayerItem.Dump()
    -- PlayerHero.Dump()
end


md[Opcode.MSG_SC_GMCommandResponse] = function(tab)
    print("msg:MSG_SC_GMCommandResponse")
    -- TODO
end


md[Opcode.MSG_SC_UseItemResponse] = function(tab)
    print("msg:您使用了道具的结果", tab.Result)
end


md[Opcode.MSG_SC_MarketBuyResponse] = function(tab)
    print("msg:MSG_SC_MarketBuyResponse, 集市购买结果", tab.ErrorCode)
end


md[Opcode.MSG_SC_ItemUpdate] = function(tab)
    print("msg:MSG_SC_ItemUpdate")
    
    for _, v in ipairs(tab.Items) do
        if v.Flag == 0 then
            PlayerItem.SetItemCount(v.Id, v.Cnt)
        elseif v.Flag == 1 then
            PlayerItem.ChgItemCount(v.Id, v.Cnt)
        end
        print("道具数量发生变化：", v.Flag, v.Id, v.Cnt)
    end
end


md[Opcode.MSG_SC_PlayerExpUpdate] = function(tab)
    print("msg:MSG_SC_PlayerExpUpdate")
    -- TODO
end


md[Opcode.MSG_SC_NoticeUpdate] = function(tab)
    zcg.logInfo("msg:MSG_SC_NoticeResponse: %d - %s", tab.Flag, tab.Notice)
    -- TODO
end
