
local M = {}

--------------------------------------------------------------------------------
-- json

local _tab = zcg.LoadFromJson("src/configs_json/Quest.json")


local _quests       = {}
local _npc_quests   = {}


for _, v in pairs(_tab) do
    M._quests[v.id] = v

    local npcid = v.accept_id
    if not _npc_quests[npcid] then
        _npc_quests[npcid] = {}
    end
    _npc_quests[npcid][v.id] = v
end


-- get quest by quest id
M.GetQuest = function(id)
    return _quests[id]
end


-- get npc's quests
M.GetNpcQuests = function(npcid)
    return _npc_quests[npcid]
end


-------------------------------------------------------------------------------
return M