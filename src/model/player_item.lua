
local config        = require "configs_grace"

local _items        = {}
local _listeners    = {}
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
    if not val or val == 0 then
        _items[id] = cnt
        PlayerItem.Notice(1, id, cnt)
    else
        val = val + cnt
        if val == 0 then
            PlayerItem.Notice(2, id, cnt)
        else
            PlayerItem.Notice(0, id, cnt)
        end
    end
end


-- 设置道具数量
function PlayerItem.SetItemCount(id, cnt)
    local val = _items[id]
    _items[id] = cnt
    if not val or val == 0 then
        PlayerItem.Notice(1, id, cnt)
    else
        if cnt == 0 then
            PlayerItem.Notice(2, id, cnt)
        else
            PlayerItem.Notice(0, id, cnt)
        end
    end
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


function PlayerItem.Register(win)
    _listeners[win.id] = win
end


function PlayerItem.UnRegister(win)
    _listeners[win.id] = nil
end


--[[
通知监听者
type    0: 数量变化  1: 新增道具  2: 删除道具
id,cnt  道具信息
]]
function PlayerItem.Notice(type, id, cnt)
    for _, listener in pairs(_listeners) do
        listener:Notice(type, id, cnt)
    end
end


return PlayerItem
