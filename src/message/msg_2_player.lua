require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local PlayerBase = require "model.player_base"
local PlayerItem = require "model.player_item"
local PlayerHero = require "model.player_hero"


local function MSG_SC_PlayerDataResponse(tab)
    local base      = PlayerBase:GetBase()
    base.acct       = tab.Acct
    base.name       = tab.Name
    base.pid        = tab.Pid
    base.sid        = tab.Sid
    base.lv         = tab.Lv
    base.vip        = tab.Vip
    base.male       = tab.Male

    for _, v in ipairs(tab.Items) do
        if v.Flag == 0 then
            PlayerItem:SetItemCount(v.Id, v.Cnt)
        else
            PlayerItem:ChgItemCount(v.Id, v.Cnt)
        end
    end

    for _, v in ipairs(tab.Heros) do
        PlayerHero:UpdateHero(v.Id, v)
    end
    PlayerHero:Sort()

    -- PlayerBase:Dump()
    -- PlayerItem:Dump()
    -- PlayerHero:Dump()

    RuntimeData.pid = base.pid
end
md[Opcode.MSG_SC_PlayerDataResponse] = MSG_SC_PlayerDataResponse


local function MSG_SC_GMCommandResponse(tab)
    print("msg:MSG_SC_GMCommandResponse")
    -- TODO
end
md[Opcode.MSG_SC_GMCommandResponse] = MSG_SC_GMCommandResponse


local function MSG_SC_UseItemResponse(tab)
    print("msg:您使用了道具的结果", tab.Result)
end
md[Opcode.MSG_SC_UseItemResponse] = MSG_SC_UseItemResponse


local function MSG_SC_MarketBuyResponse(tab)
    print("msg:MSG_SC_MarketBuyResponse, 集市购买结果", tab.ErrorCode)
end
md[Opcode.MSG_SC_MarketBuyResponse] = MSG_SC_MarketBuyResponse


local function MSG_SC_ItemUpdate(tab)
    print("msg:MSG_SC_ItemUpdate")

    for _, v in ipairs(tab.Items) do
        if v.Flag == 0 then
            PlayerItem:SetItemCount(v.Id, v.Cnt)
        elseif v.Flag == 1 then
            PlayerItem:ChgItemCount(v.Id, v.Cnt)
        end
        print("道具数量发生变化：", v.Flag, v.Id, v.Cnt)
    end
end
md[Opcode.MSG_SC_ItemUpdate] = MSG_SC_ItemUpdate


local function MSG_SC_PlayerExpUpdate(tab)
    print("msg:MSG_SC_PlayerExpUpdate")
    -- TODO
end
md[Opcode.MSG_SC_PlayerExpUpdate] = MSG_SC_PlayerExpUpdate


local function MSG_SC_NoticeUpdate(tab)
    ShowPromptText(string.format("NOTICE: %s", tab.Notice))
    zcg.logInfo(tab.Notice)
end
md[Opcode.MSG_SC_NoticeUpdate] = MSG_SC_NoticeUpdate

local function MSG_SC_ChangeNameResponse(tab)
    print("msg:MSG_SC_ChangeNameResponse")
    -- TODO
end
md[Opcode.MSG_SC_ChangeNameResponse] = MSG_SC_ChangeNameResponse
