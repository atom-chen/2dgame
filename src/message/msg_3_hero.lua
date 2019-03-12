require "message.opcode"

local Event      = require "core.event"
local EventMgr   = require "core.event_mgr"

local md         = MessageDispatcher
local Opcode     = Opcode


local function MSG_SC_HeroLevelupResponse(tab)
    print("msg:MSG_SC_HeroLevelupResponse")
    
    local v = tab.Hero
    PlayerHero:UpdateHero(v.id, v)

    if tab.ErrorCode == 0 then
        print("英雄升级成功:", tab.ErrorCode)
    else
        print("英雄升级失败:", tab.ErrorCode)
    end
end
md[Opcode.MSG_SC_HeroLevelupResponse] = MSG_SC_HeroLevelupResponse


local function MSG_SC_HeroRefineResponse(tab)
    print("msg:MSG_SC_HeroRefineResponse")
    
    if tab.ErrorCode ~= 0 then
        print("精炼失败！", tab.ErrorCode)
    else
        print("精炼完成：是否成功:", tab.Result)
    end
end
md[Opcode.MSG_SC_HeroRefineResponse] = MSG_SC_HeroRefineResponse


local function MSG_SC_HeroInfoUpdateResponse(tab)
    print("msg:MSG_SC_HeroInfoUpdateResponse")
    -- TODO
end
md[Opcode.MSG_SC_HeroInfoUpdateResponse] = MSG_SC_HeroInfoUpdateResponse
