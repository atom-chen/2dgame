
local WinBase       = require "core.WinBase"
local AnimLoader    = require "core.AnimLoader"
local Armature      = require "core.armature"

local config        = require "configs_grace"

local PlayerChapter = require "model.player_chapter"

-------------------------------------------------------------------------------
local ChapterWin = class("ChapterWin", WinBase)


function ChapterWin:ctor()
    WinBase.ctor(self)

    self.resourceNode_ = cc.CSLoader:createNode("1.layer/chapter.csb")
    self.resourceNode_:setIgnoreAnchorPointForPosition(false)    
    self.resourceNode_:setAnchorPoint(0.5, 0.5)
    self:addChild(self.resourceNode_)

    -- 关闭
    local btn = self.resourceNode_:getChildByName("btn_close")
    btn:addClickEventListener(function()
        self:Close()
    end)

    -- 挂机奖励
    local btn = self.resourceNode_:getChildByName("btn_loot")
    btn:addClickEventListener(function()
        Socket.SendPacket(Opcode.MSG_CS_ChapterLootRequest, {})
    end)

    -- 章节奖励
    local btn = self.resourceNode_:getChildByName("btn_chapter")
    btn:addClickEventListener(function()
        Socket.SendPacket(Opcode.MSG_CS_ChapterRewardsRequest, {Id=self.curr_chapter_id})
    end)
end


------------------------------ inhert from WinBase ----------------------------

function ChapterWin:OnCreate()
    self:update_view(1)
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

local function get_position(i)
    local row = math.ceil(i / 4)
    local col = i % 4
    if col == 0 then col = 4 end

    local x = col * 200
    local y = row * 72

    return -600+x, 120-y
end


local function btn_callback(ref, type)
    if type == ccui.TouchEventType.ended then
        print("1111:", ref.break_id)
        WinManager:CreateWindow("BattleTeamWin")
    end
end

function ChapterWin:update_view(chapter_id)
    local seq  = 0
    local conf = config.GetChapter(chapter_id)
    local data = PlayerChapter:Data()

    self.resourceNode_:getChildByName("txt_name"):setText(conf.name)

    for i = conf.breakStart, conf.breakEnd do   
        seq = seq + 1

        local btn = ccui.Button:create(
            "ccs/gm/public_button_001.png", 
            "ccs/gm/public_button_002.png", 
            "ccs/gm/public_button_003.png")
        btn:setPosition(get_position(seq))
        
        local c = config.GetBreak(i)
        local text
        if data.BreakId > i then
            text = c.name .. " <已通关>"
        else
            text = c.name .. " <未通关>"
        end

        btn.break_id = i
        btn:setTitleText(text)
        btn:addTouchEventListener(btn_callback)
        self:addChild(btn)
    end

    self.curr_chapter_id = chapter_id  
end

return ChapterWin
