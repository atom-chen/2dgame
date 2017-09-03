
-- ��Ϸ�пɼ��ĳ������󣺰����֡��ɼ��
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
            assert(false, "δ֪�Ķ�������")
        end
    end,


    -- ð��˵��
    say = function(c, text)

    end,


}
meta_creature.__index = meta_creature


-- �½�һ������
local function new_creature()
    local c =
    {
        entry       = 0,            -- ����ΨһID/ԭ��ID
        pid         = 0,
        name        = "",           -- ����
        hp          = 0,            -- ����/��������
        hp_max      = 0,
        type        = 0,            -- ����: 1:��� 2:�֡�3:����
        dir         = 0,            -- ����:    0:��  1:��
        pos_x       = 0,            -- λ��
        pos_y       = 0,
        mod_id      = 0,            -- ģ��ID
        mod_st      = 0,            -- ��ǰ״̬:idle ? walk ? attack? death?
        auras       = {},           -- �⻷��Ϣ
    }
    setmetatable(c, mt_creature)
    return c
end


-- ��ɫ������   ��ǰ��ͼ�ɼ��Ĺ�
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
