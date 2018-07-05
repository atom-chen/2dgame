
local scheduler = {}

local sharedScheduler = cc.Director:getInstance():getScheduler()


-- N次定时器
function scheduler.ScheduleN(func, interval, N, immediate)
    local sid
    local times = 1
    sid = sharedScheduler:scheduleScriptFunc(function()
        if times >= N then
            sharedScheduler:unscheduleScriptEntry(sid)
        end
        func(times)
        times = times + 1
    end, interval, false)
    if immediate then
        func(0)
    end
    return sid
end


-- 一次定时器
function scheduler.Once(func, interval)
    return scheduler.ScheduleN(func, interval, 1)
end


-- 直到func返回true才终止
function scheduler.Until(func, interval)
    local sid
    sid = sharedScheduler:scheduleScriptFunc(function()
        if func() == true then
            sharedScheduler:unscheduleScriptEntry(sid)
        end
    end, interval, false)
    return sid
end


-- 立即执行，一次性定时器
function scheduler.Now(func)
    local sid
    sid = sharedScheduler:scheduleScriptFunc(function()
        func()
        sharedScheduler:unscheduleScriptEntry(sid)
    end, 0, false)
    return sid
end


-- 终止Schedule
function scheduler.Abort(sid)
    sharedScheduler:unscheduleScriptEntry(sid)
end


return scheduler
