
local _M = {}


-------------------------------------------------------------------------------

_M.PartBase     = 0
_M.PartPerc     = 1
_M.PartExtra    = 2

_M.PropType_HP   = 0    -- HP
_M.PropType_Apm  = 1    -- 速度
_M.PropType_Atk  = 2    -- 攻击
_M.PropType_Def  = 3    -- 防御
_M.PropType_Crit = 4    -- 暴击
_M.PropType_Hurt = 5    -- 暴伤

-- 属性总数量
_M.C_Property_Number = 6


-------------------------------------------------------------------------------

local Property = class("Property")
_M.Property = Property


function Property:ctor()
    self:Clear()
end

function Property:Clear()
    self.base   = 0
    self.perc   = 0
    self.extra  = 0
    self.total  = 0
    self.daity  = false
end

function Property:add(part, val, add)
    if val == 0 or part > _M.PartExtra then
        return
    end

    if not add then
        val = -val
    end

    if part == _M.PartBase then
        self.base = self.base + val
    elseif part == _M.PartPerc then
        self.perc = self.perc + val
    elseif part == _M.PartExtra then
        self.extra = self.extra + val        
    end

    self.daity = true
end

function Property:Calc()
    if not self.daity then
        return
    end

    self.daity = false
    self.total = self.base * (1 + self.perc/100) + self.extra

    if self.total < 0 then
        zcg.logError("Property:Calc ERROR: %f %f %f %f", self.base, self.perc, self.extra, self.total)
        self.total = 0
    end
end


function Property:Value()
    if self.daity then
        self:Calc()
    end

    return self.total
end

-------------------------------------------------------------------------------

local PropertyGroup = class("PropertyGroup")
_M.PropertyGroup = PropertyGroup

function PropertyGroup:ctor()
    self._props = 
    {
        [_M.PropType_HP]   = Property:create(),
        [_M.PropType_Apm]  = Property:create(),
        [_M.PropType_Atk]  = Property:create(),
        [_M.PropType_Def]  = Property:create(),
        [_M.PropType_Crit] = Property:create(),
        [_M.PropType_Hurt] = Property:create(),
    }
end

function PropertyGroup:AddProps(props)
    for _, v in pairs(props) do
        local m = self._props[v.id]
        if m then
            m:add(v.part, v.val, true)
        end
    end
end

function PropertyGroup:SubProps(props)
    for _, v in pairs(props) do
        local m = self._props[v.id]
        if m then
            m:add(v.part, v.val, false)
        end
    end
end

function PropertyGroup:Calc()
    for i = _M.PropType_HP, _M.PropType_Hurt do
        self._props[i]:Calc()
    end
end

function PropertyGroup:Value(id)
    if id < _M.PropType_HP or id > _M.PropType_Hurt then
        return 0
    end

    return self._props[id]:Value()
end

-------------------------------------------------------------------------------

return _M
