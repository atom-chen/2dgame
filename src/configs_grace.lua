
local AuraProto     = require "configs_raw.AuraProto"
local CreatureProto = require "configs_raw.CreatureProto"
local CreatureTeam  = require "configs_raw.CreatureTeam"
local HeroProto     = require "configs_raw.HeroProto"
local ItemProto     = require "configs_raw.ItemProto"
local SkillProto    = require "configs_raw.SkillProto"

local Global        = require "configs_raw.global"
local MarketConf    = require "configs_raw.MarketConf"

local RefineSuper   = require "configs_raw.RefineSuper"
local RefineNormal  = require "configs_raw.RefineNormal"


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


--------------------------------------------------------------------------------

M.Global            = Global
M.MarketConf        = MarketConf

M.GetAuraProto      = get_by__id_level(_configs.AuraProto)
M.GetSkillProto     = get_by__id_level(_configs.SkillProto)
M.GetHeroProto      = get_by__id_level(_configs.HeroProto)
M.GetCreatureProto  = get_by__id_level(_configs.CreatureProto)

M.GetItemProto      = get_by__id(_configs.ItemProto)
M.GetCreatureTeam   = get_by__id(_configs.CreatureTeam)

M.GetMarketConf     = get_by__index(MarketConf)
M.GetRefineSuper    = get_by__index(RefineSuper)
M.GetRefineNormal   = get_by__index(RefineNormal)

return M
