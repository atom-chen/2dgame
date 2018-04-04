
require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local PlayerBase = require "model.player_base"
local PlayerItem = require "model.player_item"
local PlayerHero = require "model.player_hero"

local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_PlayerData] = function(tab)
    local base      = PlayerBase.GetBase()
    base.acct       = tab.acct
    base.name       = tab.name
    base.pid        = tab.pid
    base.sid        = tab.sid
    base.id         = tab.id
    base.level      = tab.level
    base.vipLevel   = tab.vipLevel
    base.male       = tab.male

    for _, v in ipairs(tab.items) do
        if v.flag == 0 then
            PlayerItem.SetItemCount(v.id, v.cnt)
        else
            PlayerItem.ChgItemCount(v.id, v.cnt)
        end
    end

    for _, v in ipairs(tab.heros) do
        PlayerHero.UpdateHero(v.id, v)
    end
    PlayerHero.Sort()

    -- PlayerBase.Dump()
    -- PlayerItem.Dump()
    -- PlayerHero.Dump()

end
