
local win_list = 
{
    [1] = require("src/wins/ToolbarWin"), 
    [2] = require("src/wins/player_info"),                -- 角色信息
    [3] = require("src/wins/system_setting"),             -- 系统设置
}


cc.exports.WinManager = WinManager or
{
    _win_stack = {},
    _win_curr = nil,
    _win_whole = {},
}


function WinManager:Init()
    local win_size = cc.Director:getInstance():getWinSize()
    local layer = cc.Layer:create()
    layer:setContentSize(win_size)
    layer:setPosition(win_size.width/2, win_size.height/2)
    self._layer = layer
end


function WinManager:CreateWindow(id)
    local win = self:FindWindow(id)
    if not win then
        local conf = win_list[id]
        if not conf then
            zcg.logWarning("WinManager:CreateWindow: unknown id=%d", id)
            return
        end
        win = conf:create()
        self._win_whole[id] = win
    end
    if win then
        win:OnCreate()
        self:ShowWindow(win, true)
        self._layer:addChild(win)
    end
    return win
end


function WinManager:DestroyWindow(win)
    if type(win) == "number" then
        win = self.FindWindow(win)
    end
    if win then
        self:ShowWindow(win, false)
        win:OnDestroy()
        self._layer:removeChild(win)
        self._win_whole[win.id] = nil
    end
end


function WinManager:FindWindow(id)
    return self._win_whole[id]
end


function WinManager:ShowWindow(win, b)
    if type(win) == "number" then
        win = self.FindWindow(win)
    end
    if win then
        if b then
            win:OnShow()
            win:setVisible(true)
        else
            win:OnHiden()
            win:setVisible(true)
        end
    end
end
