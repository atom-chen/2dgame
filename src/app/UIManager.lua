
cc.exports.UIManager = UIManager or
{
    _ui    = {},
    _layer = nil,
    _scene = nil,
}


function UIManager:init(node)
    local layer = cc.Layer:create()
    local win_size = cc.Director:getInstance():getWinSize()
    layer:setContentSize(win_size)
    layer:setPosition(win_size.width/2, win_size.height/2)
    layer:addTo(node)
    self._layer = layer
    self._scene = node
end


function UIManager:_create_ui(id)
    local conf = UI_LIST[id]
    if not conf then
        zcg.logWarning("UIManager:_create_ui: unknown id=%d", id)
        return
    end
    local cls = require(conf[1])
    local obj = cls:create()
    obj:initWithNode(id, conf)
    return obj
end


function UIManager:createUI(id)
    local ui = self._ui[id]
    if not ui then
        ui = self:_create_ui(id)
        self._ui[id] = ui
        self._layer:addChild(ui._panel)
        ui:show(true)
    end
end


function UIManager:destroyUI(id)
    local ui = self._ui[id]
    if ui then
        ui:show(false)
        ui:on_release()
        self._ui[id] = nil
        self._layer:removeChild(ui._panel)
    end
end


function UIManager:getUI(id)
    return self._ui[id]
end
