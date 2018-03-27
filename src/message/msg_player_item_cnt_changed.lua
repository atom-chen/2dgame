
require "message.opcode"



local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"
local PlayerItem = require "model.player_item"


local md         = MessageDispatcher
local Opcode     = Opcode


md[Opcode.MSG_SC_ItemCntChanged] = function(tab)
    for _, v in ipairs(tab.info) do
        if v.add == 0 then
            PlayerItem.SetItemCount(v.id, v.cnt)
        elseif v.add == 1 then
            PlayerItem.ChgItemCount(v.id, v.cnt)
        elseif v.add == 2 then
            PlayerItem.ChgItemCount(v.id, -v.cnt)
        end
        print("道具数量发生变化：", v.add, v.id, v.cnt)
    end
end
