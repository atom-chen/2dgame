
-- ��ǰ���ǵ�����

cc.exports.Player = 
{
    -- ��Ϣ����
    name        = "nobody",     -- ��ɫ��
    sex         = 1,            -- 1:�� 0:Ů
    id          = 0,            -- ��ɫID
    
    -- ��������
    level       = 0,            -- �ȼ�/����
    exp         = 2,
    hp          = 90,           -- ����/��������
    hp_max      = 100,
    mp          = 40,           -- ��/����
    mp_max      = 140
    atk         = 80,           -- ��
    def         = 20,           -- ��
    
    -- ����
    packsack    = 
    {
        size    = 20,
        items   = {},
    },
    
    -- װ��
    bodysack    = 
    {
        items   = {},
    },

    -- �⻷��Ϣ
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


-- ��������
function Player:attack()
    -- ���͹�����Ϣ�������
end
