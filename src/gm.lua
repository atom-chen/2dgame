-- press 'z' will do this file

-- zcg.logTable(cc.Scheduler, "d:/a.txt")


-- zcg.logTable(debug.getregistry(), "d:/reg.txt")
-- print("+++", type(cc.Node), cc.Node[".isclass"])


local gm_str =
{
    [1] = "save",                       -- 保存数据
    [2] = "item 4001|1 4002|2",         -- 增加道具 道具ID|数量
    [3] = "hero 5001 5002",             --  增加英雄 英雄ID
    [4] = "hero_up 5001 5002",             --  增加英雄 英雄ID

}


-- MSG.SendGMCommand(gm_str[1])


-- MSG.SendNotice("fuck you, can i ?")


-- 打一架
Socket.SendPacket(Opcode.MSG_CS_MakeBattle, { id = 1, })

