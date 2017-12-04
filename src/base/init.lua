
require "base.ext"


cc.exports.CONSOLE_COLOR =
{
    FOREGROUND_BLUE     = 0x0001, -- text color contains blue.
    FOREGROUND_GREEN    = 0x0002, -- text color contains green.
    FOREGROUND_RED      = 0x0004, -- text color contains red.
    FOREGROUND_INTENSITY= 0x0008, -- text color is intensified.
    BACKGROUND_BLUE     = 0x0010, -- background color contains blue.
    BACKGROUND_GREEN    = 0x0020, -- background color contains green.
    BACKGROUND_RED      = 0x0040, -- background color contains red.
    BACKGROUND_INTENSITY= 0x0080, -- background color is intensified.
}

CONSOLE_COLOR.FOREGROUND_YELLOW     = CONSOLE_COLOR.FOREGROUND_RED      + CONSOLE_COLOR.FOREGROUND_GREEN
CONSOLE_COLOR.FOREGROUND_PINK       = CONSOLE_COLOR.FOREGROUND_RED      + CONSOLE_COLOR.FOREGROUND_BLUE
CONSOLE_COLOR.FOREGROUND_DARKBLUE   = CONSOLE_COLOR.FOREGROUND_GREEN    + CONSOLE_COLOR.FOREGROUND_BLUE


cc.exports.zcg = zcg or {}

function zcg.logError(fmt, ...)
    preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_RED)
    printLog("ERR", fmt, ...)
    print(debug.traceback("", 2))
    preboy:set_console_color()
end

function zcg.logInfo(fmt, ...)
    if type(DEBUG) ~= "number" or DEBUG < 2 then return end
    preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_DARKBLUE)
    printLog("INFO", fmt, ...)
    preboy:set_console_color()
end

function zcg.logWarning(fmt, ...)
    preboy:set_console_color(CONSOLE_COLOR.FOREGROUND_YELLOW)
    printLog("WARNING", fmt, ...)
    preboy:set_console_color()
end

function zcg.log2File(filename, str)
    local p = io.open(filename, "a+")
    p:write(str)
    io.close(p)
end


--------------------- dump table ----------------------
local max_depth = 16

local function _print_prefix(str, n)
    for i = 1, n do
        io.write("    ")
    end
    io.write(str)
end


local function _print_table(tab, depth, e)
    if e then
        if e[tab] then
            _print_prefix("-- [[Already Printed]]", depth+1)
            io.write("\n")
            _print_prefix("},", depth)
            io.write("\n")
            return
        else
            e[tab] = true
        end
    end

    for k, v in pairs(tab) do
        local key
        if type(k) ~= "string" then
            key = string.format("[%s]", tostring(k))
        else
            key = string.format("'%s'", k)
        end
        _print_prefix(key .. " = ", depth + 1)
        local type_ = type(v)
        if type_ == "number" then
            io.write(v .. ",\n")
        elseif type_ == "string" then
            io.write("'" .. v .. "',\n")
        elseif type_ == "table" then
            if depth + 1 <= max_depth then
                io.write("{\t-- ", tostring(v), "\n")
                _print_table(v, depth + 1, e)
            else
                io.write("{...},\t-- ", tostring(v), " [[max-depth]]\n")
            end
        elseif type_ == "boolean" then
            io.write(tostring(v) .. ",\n")
        else
            io.write(string.format("[%s],\n", tostring(v)))
        end
    end
    _print_prefix("},", depth)
    io.write("\n")
end

-- print table to output or file
zcg.logTable = function(tab, filename, print_exist_table)
    local e
    local f
    if not print_exist_table then
        e = {}
    end
    if filename then
        f = io.open(filename, "w+")
        io.output(f)
    end
    if not tab then
        io.write("tab = nil\n")
        return
    end
    local type_ = type(tab)
    if type_ ~= "table" then
        io.write(string.format("%s\n", tostring(tab)))
    else
        io.write("ROOT = {\n")
        local depth = 0
        _print_table(tab, depth, e)
    end
    if f then
        f:flush()
        f:close()
    end
end


--------------------- dump table ----------------------
-- dump local variables in lua stack
zcg.dump_local = function(n)
    local idx = 1
    repeat
        local name, value = debug.getlocal(n, idx)
        if not name then
            break
        end
        print("var:", name, value)
        idx = idx + 1
    until false
end


-------------------- another class --------------------

cc.exports.Class = Class or
{
    __call = function (p, ...)
        local o = {}
        setmetatable(o, p)
        local c = {}
        local ctors = nil
        repeat
            if p.ctor ~= ctors then
                ctors = p.ctor
                table.insert(c, p.ctor)
            end
            p = getmetatable(p)
        until not p
        for i = #c, 1, -1 do
            c[i](o, ...)
        end
        return o
    end,

    extend = function(p, b)
        b.__index = b
        b.__call  = Class.__call
        if p then
            setmetatable(b, p)
        else
            setmetatable(b, Class)
        end
        return b
    end,

    parent = function(cls)
        return getmetatable(getmetatable(cls))
    end,
}
