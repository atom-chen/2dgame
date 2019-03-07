
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"



-------------------------------------------------------------------------------
local ChapterWin = class("ChapterWin", WinBase)


function ChapterWin:ctor()
    WinBase.ctor(self)

    -- 关闭按钮
    local winSize   = cc.Director:getInstance():getWinSize()
    local btn_image = ccui.Scale9Sprite:create("unKnown.png")
    local btn_close = cc.ControlButton:create(btn_image)
    btn_close:setPreferredSize(btn_image:getPreferredSize())
    btn_close:setPosition(cc.p(winSize.width/2, winSize.height/2))
    btn_close:registerControlEventHandler(function()
        self:Close()
    end, 32)
    self:addChild(btn_close, 1)
end


------------------------------ inhert from WinBase ----------------------------

function ChapterWin:OnCreate(mapid)
    self:ShowMap(mapid)
end


function ChapterWin:OnDestroy()
    print("ChapterWin:OnDestroy")
end


function ChapterWin:OnShow()
    print("ChapterWin:OnShow")
end


function ChapterWin:OnHiden()
    print("ChapterWin:OnHiden")
end

-------------------------------------------------------------------------------

function ChapterWin:update_window()

    local conf = config.GetScene(mapid)
    assert(conf, "ChapterWin:ShowMap:mapid" .. tostring(mapid))

    self.mapid = mapid

    self:render_background(conf)
    self:render_objects(conf)

    return true
end

return ChapterWin
