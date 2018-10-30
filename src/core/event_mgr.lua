
local _data         = {}
local EventMgr      = {}


setmetatable(_data, {
    __mode = "k",
})


function EventMgr.Emit(evt, args)
    for _, tab in pairs(_data) do
        local func = tab[evt]
        if func then
            func(evt, args)
        end
    end
end


function EventMgr.Register(host, evts, func)
    assert(type(evts) == "table", "evts should be type table !")

    local h = _data[host]
    if not h then
       h = {}
       _data[host] = h
    end

    for _, evt in ipairs(evts) do
        h[evt] = func
    end
end


function EventMgr.Unregister(host, evts)
    local h = _data[host]
    if not h then return end

    if not evts then
        _data[host] = nil
        return
    end

    for k, _ in pairs(h) do
        h[k] = nil
    end
end


-- 在程序结束调试，以检测未注销的事件
function EventMgr.dump()
    for h, v in pairs(_data) do
        print("host:", h)
        for evt, _ in pairs(v) do
            print("\tevt:", evt)
        end
    end
end


return EventMgr
