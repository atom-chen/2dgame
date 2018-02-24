
local _event_monitors = {}
local _table_monitors = {}


local EventMgr = {}


function EventMgr.EmitEvent(event, args)
    local m = _event_monitors[event]
    if m then
        for func, once in pairs(m) do
            func(event, args)
            if once then
                m[func] = nil
            end
        end
    end

    for events, func in pairs(_table_monitors) do
        if table.exist(event, events) then
            func(event, args)
            _table_monitors[events] = nil
        end
    end
end


function EventMgr._register_event(event, func, once)
    local m = _event_monitors[event]
    if not m then
        m = {}
        _event_monitors[event] = m
    end
    m[func] = once
end


function EventMgr.RegisterEvent(events, func, once)
    if type(events) ~= "table" then
        local event = events
        EventMgr._register_event(event, func, once)
    else
        if once then
            _table_monitors[events] = func
        else
            for _, event in ipairs(events) do
                EventMgr._register_event(event, func, once)
            end
        end
    end
end


function EventMgr.UnregisterEvent(event, func)
    local m = _event_monitors[event]
    if not m then
        return
    end
    m[func] = nil
end


return EventMgr