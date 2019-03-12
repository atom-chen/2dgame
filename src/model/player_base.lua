local _base         = {}
local PlayerBase    = NewModel({_model_name="PlayerBase"})

-------------------------------------------------------------------

function PlayerBase.Clear()
    _base = {}
end

function PlayerBase.GetBase()
    return _base
end

function PlayerBase.Dump()
    table.print_r(_base, "player base")
end

-------------------------------------------------------------------
return PlayerBase
