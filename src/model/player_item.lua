
local config        = require "configs_grace"

local _items        = {}
local PlayerItem    = {}


function PlayerItem.Clear()
    _items = {}
end


function PlayerItem.GetItemCount(id)
    return _items[id] or 0
end


-- 道具数量变更
function PlayerItem.ChgItemCount(id, cnt)
    local val = _items[id]
    if not val then val = 0 end
    _items[id] = val + cnt
end


-- 设置道具数量
function PlayerItem.SetItemCount(id, cnt)
    _items[id] = cnt
end


function PlayerItem.Dump()
    table.print_r(_items, "player item")
end


-- 所有道具
function PlayerItem.GetAllItems()
    local tab = {}
    for id, cnt in pairs(_items) do
        table.insert(tab, {id,cnt})
    end
    table.sort(tab, function(l,r)
        local proto_l = config.GetItemProto(l[1])
        local proto_r = config.GetItemProto(r[1])
        return proto_l.id > proto_r.id -- 暂时先将就比ID
    end)
    return tab
end


return PlayerItem
