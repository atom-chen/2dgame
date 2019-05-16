
local windows =
{
    ToolbarWin      = {},   -- 这个东西迟早要被替换的
    BattleWin       = {},   -- 战斗界面： 播放战斗
    ModelWin        = {},   -- 模型列表： 查看所选择的模型以及技能效果
    BagWin          = {},   -- 道具界面
    HeroWin         = {},   -- 英雄界面
    MapWin          = {},   -- 地图界面
    NpcMenuWin      = {},   -- 地图Npc菜单界面
    BattleTeamWin   = {},   -- 设置战斗队伍界面
    HeroSelectWin   = {},   -- 出战英雄选择界面
    ChapterWin      = {},   -- 章节关卡界面
    GmWin           = {},   -- gm界面
    LoginWin        = {},   -- 登录界面
    ServerListWin   = {},   -- 服务器列表界面
}

for k, v in pairs(windows) do
    local path = "wins." .. k
    v[1] = path
    v[2] = require(path)
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


function WinManager:_release_window(id)
    local v = windows[id]
    if not v then return end

    local s = v[1]
    package.loaded[s] = nil
    v[2] = require(s)
end


function WinManager:CreateWindow(id, ...)
    -- 发布版本时候屏蔽此行
    self:_release_window(id)

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
        win:OnCreate(...)
    end

    self:ShowWindow(win, true, ...)

    return win
end


function WinManager:DestroyWindow(win)
    if type(win) == "string" then
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


function WinManager:ShowWindow(win, b, ...)
    if type(win) == "string" then
        win = self:FindWindow(win)
    end
    if win then
        if b then
            win:OnShow(...)
            win:setVisible(true)
        else
            win:OnHiden(...)
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
