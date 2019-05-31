
local AuraProto     = require "config.excel.Aura"
local CreatureProto = require "config.excel.Creature"
local CreatureTeam  = require "config.excel.CreatureTeam"
local HeroProto     = require "config.excel.Hero"
local HeroProp      = require "config.excel.HeroProp"
local HeroTalent    = require "config.excel.HeroTalent"
local ItemProto     = require "config.excel.Item"
local SkillProto    = require "config.excel.Skill"

local Global        = require "config.excel.Global"
local MarketConf    = require "config.excel.Market"

local RefineSuper   = require "config.excel.RefineSuper"
local RefineNormal  = require "config.excel.RefineNormal"

local Object        = require "config.excel.Object"
local Scene         = require "config.excel.Scene"

local Chapter       = require "config.excel.Chapter"
local Break         = require "config.excel.Break"


local M = {}
local _configs = {}


--------------------------------------------------------------------------------

local map_by__id_level = function(cfg, tab)
    for _, v in pairs(tab) do
        local tmp = cfg[v.id]
        if not tmp then
            tmp = {}
            cfg[v.id] = tmp
        end
        tmp[v.lv] = v
    end
end


local map_by__id = function(cfg, tab)
    for _, v in pairs(tab) do
        if not cfg[v.id] then
            cfg[v.id] = v
        end
    end
end


-- 按id、level排序
local get_by__id_level = function(tab)
    return function(id, lv)
        if tab[id] then
            return tab[id][lv]
        end
    end
end


-- 按id排序
local get_by__id = function(tab)
    return function(id)
        return tab[id]
    end
end


-- 不需要排序
local get_by__index = function(tab)
    return function(index)
        return tab[index]
    end
end


--------------------------------------------------------------------------------

-- AuraProto
_configs.AuraProto = {}
map_by__id_level(_configs.AuraProto, AuraProto)


-- CreatureProto
_configs.CreatureProto = {}
map_by__id(_configs.CreatureProto, CreatureProto)


-- CreatureTeam
_configs.CreatureTeam = {}
map_by__id(_configs.CreatureTeam, CreatureTeam)


-- HeroProto
_configs.HeroProto = {}
map_by__id(_configs.HeroProto, HeroProto)

-- HeroProp
_configs.HeroProp = {}
map_by__id_level(_configs.HeroProp, HeroProp)

-- HeroTalent
_configs.HeroTalent = {}
map_by__id_level(_configs.HeroTalent, HeroTalent)

-- ItemProto
_configs.ItemProto = {}
map_by__id(_configs.ItemProto, ItemProto)


-- SkillProto
_configs.SkillProto = {}
map_by__id_level(_configs.SkillProto, SkillProto)


-- Object
_configs.Object = {}
map_by__id(_configs.Object, Object)


-- Scene
_configs.Scene = {}
map_by__id(_configs.Scene, Scene)

-- Chapter
_configs.Chapter = {}
map_by__id(_configs.Chapter, Chapter)

-- Break
_configs.Break = {}
map_by__id(_configs.Break, Break)



--------------------------------------------------------------------------------

M.AllObjects        = function(name) return _configs[name] end

M.Global            = Global
M.MarketConf        = MarketConf

M.GetAuraProto      = get_by__id_level(_configs.AuraProto)
M.GetSkillProto     = get_by__id_level(_configs.SkillProto)
M.GetHeroProp       = get_by__id_level(_configs.HeroProp)
M.GetHeroTalent     = get_by__id_level(_configs.HeroTalent)

M.GetCreatureProto  = get_by__id(_configs.CreatureProto)
M.GetHeroProto      = get_by__id(_configs.HeroProto)
M.GetItemProto      = get_by__id(_configs.ItemProto)
M.GetCreatureTeam   = get_by__id(_configs.CreatureTeam)
M.GetObject         = get_by__id(_configs.Object)
M.GetScene          = get_by__id(_configs.Scene)
M.GetChapter        = get_by__id(_configs.Chapter)
M.GetBreak          = get_by__id(_configs.Break)

M.GetMarketConf     = get_by__index(MarketConf)
M.GetRefineSuper    = get_by__index(RefineSuper)
M.GetRefineNormal   = get_by__index(RefineNormal)


--------------------------------------------------------------------------------
-- 需要特殊处理的配置
--------------------------------------------------------------------------------

_configs.objects_in_scene = {}
for _, v in pairs(_configs.Object) do
    local sid = v.sceneId
    local tmp = _configs.objects_in_scene[sid]
    if not tmp then
        tmp = {}
        _configs.objects_in_scene[sid] = tmp
    end
    tmp[v.id] = v
end

-- 获取场景内所有的对象
M.GetSceneObjects = function(sid)
    return _configs.objects_in_scene[sid]
end


--------------------------------------------------------------------------------
return M