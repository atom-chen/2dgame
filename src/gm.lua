-- press 'z' will do this file

-- zcg.logTable(cc.Scheduler, "d:/a.txt")


-- zcg.logTable(debug.getregistry(), "d:/reg.txt")
-- print("+++", type(cc.Node), cc.Node[".isclass"])


-- GM请求
local gm_str =
{
    [1] = "save",                       -- 保存数据
    [2] = "item 4105|5",                -- 增加道具 道具ID|数量
    [3] = "hero 5001 5002",             -- 增加英雄 英雄ID
    [4] = "hero_up 5001 5002",          -- 增加英雄 英雄ID

}
--  MSG.SendGMCommand(gm_str[2])


-- 发送通知
-- MSG.SendNotice("fuck you, can i ?")


-- 打一架
-- Socket.SendPacket(Opcode.MSG_CS_MakeBattle, { id = 1, })


-- 集市购买
-- MSG.SendMarketBuy(1, 3)


-- 使用道具（有脚本的那种）
-- MSG.SendItemUse(4105, 2)


WinManager:CreateWindowHot(4)
