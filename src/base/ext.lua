
math.round = function (v)
    if (v >= 0) then
        return math.floor(v + 0.5)
    else
        return math.ceil(v - 0.5)
    end
end

-------------------------------------------------------------------------------

table.shuffle = function (t)
    if t == nil then return nil end

    local n
    for i = 2, #t do
        n = math.random(i)
        t[i], t[n] = t[n], t[i]
    end

    return t
end


table.dump = function (t)

    local function tab_indent(lv)
        for i = 1, lv do
            io.write("    ")
        end
    end

    local function print_key(k, kt, lv)
        tab_indent(lv)
        if kt == "number" then
            io.write("["..k.."]")
        else
            io.write(k)
        end
    end

    local function print_val(v, vt, lv)
        if vt == "number" then
            io.write(v)
        elseif vt == "string" then
            io.write("\""..v.."\"")
        elseif vt == "boolean" then
            io.write(v and "true" or "false")
        elseif vt == "table" then
            if lv < 16 then
                print()
                tab_indent(lv)
                print("{")

                local keyt, valt
                for key, val in pairs(v) do
                    keyt = type(key)
                    valt = type(val)

                    print_key(key, keyt, lv + 1)
                    io.write(" = ")
                    print_val(val, valt, lv + 1)
                    print()
                end

                tab_indent(lv)
                io.write("}")
            else
                io.write("{}")
            end
        else
            io.write("<<< "..tostring(v).." >>>")
        end
        if lv > 0 then io.write(",") end
    end

    io.write("Root = ")
    print_val(t, type(t), 0)
end


string.split = function (str, sep)
    sep = sep or " "

    local t = {}
    for v in string.gmatch(str, "[^"..sep.."]+") do
        table.insert(t, v)
    end
    return t
end


table.print = function(tab)
    for k, v in pairs(tab) do
        print(k, v)
    end
end


table.size = function(tab)
    local count = 0
    for k, v in pairs(tab) do
        count  = count + 1
    end
    return count
end


table.default_value = function(tab, val)
    if type(tab) ~= "table" then
        print("[luaext ERROR]: Not a table!")
        return
    end
    local __index_func = function(t, k)
        rawset(t, k, val)
        return val
    end
    local mt = getmetatable(tab)
    if not mt then
        setmetatable(tab, { __index = __index_func })
    else
        if mt.__index then
            print("[luaext ERROR]: Alreay has a __index meta")
            return
        else
            mt.__index = __index_func
        end
    end
end


table.exist = function(val, tab)
    for _, v in ipairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end


table.exist_key = function(key, tab)
    for k, _ in pairs(tab) do
        if k == key then
            return true
        end
    end
    return false
end


table.exist_val = function(val, tab)
    for _, v in pairs(tab) do
        if v == val then
            return true
        end
    end
    return false
end


local function __print_table(tab, lv)
    local prefix_item = string.rep("  ", lv+1)
    local prefix_head = ""
    if lv > 0 then
        prefix_head = string.rep("  ", lv)
    end

    print(prefix_head .. "{")

    for k, v in pairs(tab) do
        local k_type = type(k)
        if type(v) ~= "table" then
            if k_type == "number" then
                print(prefix_item .. string.format("[%d] = %s,", tonumber(k), tostring(v)))
            else
                print(prefix_item .. string.format("%s = %s", tostring(k), tostring(v)))
            end
        else
            if k_type == "number" then
                print(prefix_item .. string.format("[%d] =", tonumber(k)))
            else
                print(prefix_item .. string.format("%s =", tostring(k)))
            end
            __print_table(v, lv+1)
        end
    end

    print(prefix_head .. "},")
end

table.print_r = function(tab, tag)
    if not tag then
        print(string.format("================ [%s] ================", tostring(tab)))
    else
        print(string.format("================ [%s] ================", tag))
    end

    __print_table(tab, 0)
end