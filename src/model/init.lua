local parent = {}

function parent:Register(h)
    self._handlers[h] = true
end

function parent:Unregister(h)
    self._handlers[h] = nil
end

function parent:Notify(...)
    for h, v in pairs(self._handlers) do
        if v then
            h(...)
        end
    end
end


-------------------------------------------------------------------------------
-- exports

local models = {}

local mt = {
    __index = parent,
}

cc.exports.NewModel = function(tab)
    assert(tab._model_name, "NOT EXIST '_model_name'")
    models[tab._model_name] = tab
    setmetatable(tab, mt)
    if not tab._handlers then
        tab._handlers = {}
    end
    return tab
end

cc.exports.FindModel = function(name)
    return models[name]
end
