
-- 游戏中可见的场景对象：包括怪、采集物、
cc.exports.Creature =
{

}

local meta_creature =
{
    obj_type = function(c)
        if c.type == 1 then
            return ObjectType.TyPlayer
        elseif c.type == 2 then
            return ObjectType.TyCreature
        elseif c.type == 3 then
            return ObjectType.TyItem
        else
            assert(false, "未知的对象类型")
        end
    end,


    -- 冒泡说话
    say = function(c, text)

    end,


}
meta_creature.__index = meta_creature


-- 新建一个对象
local function new_creature()
    local c =
    {
        entry       = 0,            -- 怪物唯一ID/原型ID
        pid         = 0,
        name        = "",           -- 名称
        hp          = 0,            -- 生命/生命上限
        hp_max      = 0,
        type        = 0,            -- 类型: 1:玩家 2:怪、3:道具
        dir         = 0,            -- 朝向:    0:左  1:右
        pos_x       = 0,            -- 位置
        pos_y       = 0,
        mod_id      = 0,            -- 模型ID
        mod_st      = 0,            -- 当前状态:idle ? walk ? attack? death?
        auras       = {},           -- 光环信息
    }
    setmetatable(c, mt_creature)
    return c
end


-- 角色管理器   当前地图可见的怪
cc.exports.CreatureMgr =
{
    objs = {},
}


function CreatureMgr:newCreature(c)
    objs[c.entry] = c
end


function CreatureMgr:delCreature(c)
    objs[c.entry] = nil
end


function CreatureMgr:getCreature(entry)
    return objs[entry]
end
