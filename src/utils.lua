-- 播放战斗
function cc.exports.PlayBattle(b)
    WinManager:CreateWindow("BattleWin", b)
end


-- 显示提示信息
function cc.exports.ShowPromptText(text, color)

    if not color then
        color = cc.YELLOW
    end

    local tip = cc.Label:createWithSystemFont(text, "Arial", 24)

    tip:setColor(color)
    tip:setPosition(display.cx, display.cy + 120)

    local scene = display.getRunningScene()
    scene:addChild(tip)

    -- 向上移动/变淡
    local action1 = cc.DelayTime:create(0.3)
    local action2 = cc.Spawn:create(cc.FadeOut:create(2), cc.MoveBy:create(2, cc.p(0, 200)))
    local action3 = cc.CallFunc:create(function() tip:removeFromParent() end)

    tip:runAction(cc.Sequence:create(action1,action2,action3))
end