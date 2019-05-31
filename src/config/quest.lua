
local M = {}

local _quests       = {}
local _npc_quests   = {}

-------------------------------------------------------------------------------
-- json

-- 如果蛋疼的话，可以搞成自动生成列表
local quest_files =
{
    "src/config/quests/3001.json",
}


-------------------------------------------------------------------------------
-- load quests

for _, name in pairs(quest_files) do
    local tab = zcg.LoadFromJson(name)
    if tab == nil then
        zcg.logError("LoadFromJson failed: %s", name)
        tab = {}
    end

    for _, v in pairs(tab) do
        _quests[v.id] = v

        local npcid = v.accept_id
        if not _npc_quests[npcid] then
            _npc_quests[npcid] = {}
        end
        _npc_quests[npcid][v.id] = v
    end
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