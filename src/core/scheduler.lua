
local scheduler = {}

local sharedScheduler = cc.Director:sharedDirector():getScheduler()


-- N次定时器
function scheduler.ScheduleN(func, delay, times)
    local sid
    local idx = 1
    sid = sharedScheduler:scheduleScriptFunc(function()
        func(idx)
        idx = idx + 1
        if idx > times then
            sharedScheduler:unscheduleScriptEntry(sid)
        end
    end, delay, false)
    return sid
end


-- 一次定时器
function scheduler.Once(func, delay)
    return scheduler.ScheduleN(func, delay, 1)
end


-- 直到func返回true才终止
function scheduler.Until(func, delay)
    local sid
    sid = sharedScheduler:scheduleScriptFunc(function()
        if func() == true then
            sharedScheduler:unscheduleScriptEntry(sid)
        end
    end, delay, false)
    return sid
end


-- 立即执行，一次性定时器
function scheduler.Now(func)
    return sharedScheduler:scheduleScriptFunc(func, 0, false)
end


-- 终止Schedule
function scheduler.Abort(sid)
    sharedScheduler:unscheduleScriptEntry(sid)
end


return scheduler
