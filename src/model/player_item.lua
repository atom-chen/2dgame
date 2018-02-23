
-- 道具

local _items = {}


local PlayerItem = {}


function PlayerItem.Reset()
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


return PlayerItem
