
local windows =
{
    [1] = { "wins.ToolbarWin",      },      -- 这个东西迟早要被替换的
    [2] = { "wins.BattleWin",       },      -- 战斗界面： 播放战斗
    [3] = { "wins.HeroListWin",     },      -- 英雄列表： 查看所选择英雄的技能效果
}

for _, v in pairs(windows) do
    v[2] = require(v[1])
end


cc.exports.WinManager =
{
    _win_stack = {},
    _win_curr = nil,
    _win_whole = {},        -- id => win
    _layer = nil,           -- root
    _scene = nil,
}

local WinManager = cc.exports.WinManager


function WinManager:Init()
    local win_size = cc.Director:getInstance():getWinSize()
    local layer = cc.Layer:create()
    layer:setContentSize(win_size)
    layer:setPosition(win_size.width/2, win_size.height/2)
    self._layer = layer
    self._layer:retain()
end


function WinManager:Release()
    self._layer:release()
end


function WinManager:CreateWindowHot(id, ...)
    local v = windows[id]
    local s = v[1]
    package.loaded[s] = nil
    v[2] = require(s)
    self:CreateWindow(id, ...)
end


function WinManager:CreateWindow(id, ...)
    local win = self:FindWindow(id)
    if not win then
        local cls = windows[id][2]
        if not cls then
            zcg.logWarning("WinManager:CreateWindow: unknown id=%d", id)
            return
        end
        win = cls:create(...)
        win._id = id
        self._layer:addChild(win)
        self._win_whole[id] = win
        win:OnCreate()
    end
    self:ShowWindow(win, true)
    return win
end


function WinManager:DestroyWindow(win)
    if type(win) == "number" then
        win = self:FindWindow(win)
    end
    if win then
        self:ShowWindow(win, false)
        win:OnDestroy()
        self._win_whole[win._id] = nil
        self._layer:removeChild(win)
    end
end


function WinManager:FindWindow(id)
    return self._win_whole[id]
end


function WinManager:ShowWindow(win, b)
    if type(win) == "number" then
        win = self:FindWindow(win)
    end
    if win then
        if b then
            win:OnShow()
            win:setVisible(true)
        else
            win:OnHiden()
            win:setVisible(false)
        end
    end
end


function WinManager:AttachScene(scene)
    if self._scene then
        self._scene:removeChild(self._layer)
    end
    if scene then
        scene:addChild(self._layer)
    end
    self._scene = scene
end


WinManager:Init()
return WinManager
