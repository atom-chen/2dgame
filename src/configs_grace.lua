
local AuraProto     = require "configs_raw.Aura"
local CreatureProto = require "configs_raw.Creature"
local CreatureTeam  = require "configs_raw.CreatureTeam"
local HeroProto     = require "configs_raw.Hero"
local ItemProto     = require "configs_raw.Item"
local SkillProto    = require "configs_raw.Skill"

local Global        = require "configs_raw.Global"
local MarketConf    = require "configs_raw.Market"

local RefineSuper   = require "configs_raw.RefineSuper"
local RefineNormal  = require "configs_raw.RefineNormal"


local Object        = require "configs_raw.Object"
local Scene         = require "configs_raw.Scene"


local M = {}
local _configs = {}


--------------------------------------------------------------------------------

local sort_by__id_level = function(cfg, tab)
    for _, v in pairs(tab) do
        local tmp = cfg[v.id]
        if not tmp then
            tmp = {}
            cfg[v.id] = tmp
        end
        tmp[v.level] = v
    end
end


local sort_by__id = function(cfg, tab)
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
sort_by__id_level(_configs.AuraProto, AuraProto)


-- CreatureProto
_configs.CreatureProto = {}
sort_by__id_level(_configs.CreatureProto, CreatureProto)


-- CreatureTeam
_configs.CreatureTeam = {}
sort_by__id(_configs.CreatureTeam, CreatureTeam)


-- HeroProto
_configs.HeroProto = {}
sort_by__id_level(_configs.HeroProto, HeroProto)


-- ItemProto
_configs.ItemProto = {}
sort_by__id(_configs.ItemProto, ItemProto)


-- SkillProto
_configs.SkillProto = {}
sort_by__id_level(_configs.SkillProto, SkillProto)


-- Object
_configs.Object = {}
sort_by__id_level(_configs.Object, Object)


-- Scene
_configs.Scene = {}
sort_by__id_level(_configs.Scene, Scene)

--------------------------------------------------------------------------------

M.Global            = Global
M.MarketConf        = MarketConf

M.GetAuraProto      = get_by__id_level(_configs.AuraProto)
M.GetSkillProto     = get_by__id_level(_configs.SkillProto)
M.GetHeroProto      = get_by__id_level(_configs.HeroProto)
M.GetCreatureProto  = get_by__id_level(_configs.CreatureProto)

M.GetItemProto      = get_by__id(_configs.ItemProto)
M.GetCreatureTeam   = get_by__id(_configs.CreatureTeam)
M.GetObject         = get_by__id(_configs.Object)
M.GetScene          = get_by__id(_configs.Scene)

M.GetMarketConf     = get_by__index(MarketConf)
M.GetRefineSuper    = get_by__index(RefineSuper)
M.GetRefineNormal   = get_by__index(RefineNormal)

return M
