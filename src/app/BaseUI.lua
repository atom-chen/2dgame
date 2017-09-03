
cc.exports.UI_INDEX = {}

local x = 1
UI_INDEX.UI_HEADBAR         = x;    x = x + 1;
UI_INDEX.UI_TOOLBAR         = x;    x = x + 1;
UI_INDEX.UI_SETTING         = x;    x = x + 1;


cc.exports.UI_LIST =
{
    [UI_INDEX.UI_HEADBAR] = { "app.ui.ui_toolbar", "csb/ui_toolbar.csb", },
    [UI_INDEX.UI_TOOLBAR] = { "app.ui.ui_toolbar", "csb/ui_toolbar.csb", },
    [UI_INDEX.UI_SETTING] = { "app.ui.ui_toolbar", "csb/ui_toolbar.csb", },
}


cc.exports.BaseUI = {
	_ui_index   = nil,
	_panel      = nil,
    _show       = false,
}


function BaseUI:initWithNode(id, conf)
    self._ui_index = id
	self._panel = cc.CSLoader:createNode(conf[2])
	self:on_init()
end


function BaseUI:show(visible)
    if self._show == visible then
        return
    end
    self._show = visible
    if visible then
        self:on_show()
    else
        self:on_hide()
    end
    self._panel:setVisible(visible)
end


------------------------------ virtual method ------------------------------
function BaseUI:on_init()
end

function BaseUI:on_show()
end

function BaseUI:on_hide()
end

function BaseUI:on_close()
end