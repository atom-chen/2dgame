
local AuraProto     = require "configs.AuraProto"
local CreatureProto = require "configs.CreatureProto"
local CreatureTeam  = require "configs.CreatureTeam"
local HeroProto     = require "configs.HeroProto"
local ItemProto     = require "configs.ItemProto"
local SkillProto    = require "configs.SkillProto"


local M = {}
local _configs = {}


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


---------------------------------------- aux function ----------------------------------------

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


local get_by__id_level = function(tab)
    return function(id, lv)
        if tab[id] then
            return tab[id][lv]
        end
    end
end


local get_by__id = function(tab)
    return function(id)
        return tab[id]
    end
end


M.GetAuraProto      = get_by__id_level(_configs.AuraProto)
M.GetSkillProto     = get_by__id_level(_configs.SkillProto)
M.GetHeroProto      = get_by__id_level(_configs.HeroProto)
M.GetCreatureProto  = get_by__id_level(_configs.CreatureProto)

M.GetItemProto      = get_by__id(_configs.ItemProto)
M.GetCreatureTeam   = get_by__id(_configs.CreatureTeam)



return M