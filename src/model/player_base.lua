

-- 玩家数据



local PlayerData = {}



function PlayerData.Reset()

    _player_root._base      = {}    -- 基本信息
    _player_root._bag       = {}    -- 道具
    _player_root._active    = {}    -- 活动数据

end


function PlayerData.Init(root)

end



function PlayerData.InitBase(root)
    
end




return PlayerData
