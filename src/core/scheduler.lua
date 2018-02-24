
local scheduler = {}

local sharedScheduler = cc.Director:sharedDirector():getScheduler()


-- 一次性定时器
function scheduler.Once(func, delay)
    local sid
    sid = sharedScheduler:scheduleScriptFunc(function()
        func()
        sharedScheduler:unscheduleScriptEntry(sid)
    end, delay, false)
end


return scheduler