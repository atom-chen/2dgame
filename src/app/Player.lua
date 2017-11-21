
-- 当前主角的数据

cc.exports.Player = 
{
    -- 信息数据
    name        = "nobody",     -- 角色名
    sex         = 1,            -- 1:男 0:女
    id          = 0,            -- 角色ID
    
    -- 基础属性
    level       = 0,            -- 等级/经验
    exp         = 2,
    hp          = 90,           -- 生命/生命上限
    hp_max      = 100,
    mp          = 40,           -- 蓝/上限
    mp_max      = 140
    atk         = 80,           -- 攻
    def         = 20,           -- 防
    
    -- 背包
    packsack    = 
    {
        size    = 20,
        items   = {},
    },
    
    -- 装备
    bodysack    = 
    {
        items   = {},
    },

    -- 光环信息
    auras       = {},

}


function Player:obj_type = function()
    return ObjectType.TySelf
end


function Player:name()
    return self.name
end


function Player:getItemCount(item_id)
    return 0
end


-- 攻击动作
function Player:attack()
    -- 发送攻击消息到服务端
end
