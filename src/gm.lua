
-- press 'z' will do this file
zcg.logTable(cc.Scheduler, "e:/a.txt")


local gm_str = 
{
    [1] = "save"                    -- 保存数据
    [2] = "item 4001|1 4002|2"      -- 增加道具 道具ID|数量 
    [3] = "hero 5001 5002"          --  增加英雄 英雄ID
}

MSG.SendGMCommand(gm_str[1])


-- MSG.SendNotice("fuck you, can i ?")

