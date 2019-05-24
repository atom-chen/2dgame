local _base         = {}
local PlayerBase    = NewModel({_model_name="PlayerBase"})

-------------------------------------------------------------------

function PlayerBase:Clear()
    _base = {}
end

function PlayerBase:GetBase()
    return _base
end

function PlayerBase:Dump()
    table.print(_base, "PLAYER BASE")
end

-------------------------------------------------------------------
return PlayerBase
