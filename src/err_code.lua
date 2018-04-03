
local x = 0
cc.exports.Error = {
    ERR_OK                      = x; x=x+1; -- 无错误
    ERR_FAILED                  = x; x=x+1; -- 操作失败
	ERR_LOGIN_FAILED            = x; x=x+1; -- 用户名、密码不正确
	ERR_LOGIN_DUP               = x; x=x+1; -- 已在线，重复登录
	ERR_NOT_LOGIN               = x; x=x+1; -- 未登录
	ERR_UNKNOWN_ITEM            = x; x=x+1; -- 未知道具ID
	ERR_ITEM_NOT_ENOUGH         = x; x=x+1; -- 道具数量不足
	ERR_ITEM_UNUSABLE           = x; x=x+1; -- 不可使用的道具
	ERR_ITEM_INVALID_HERO       = x; x=x+1; -- 未知的英雄
	ERR_ITEM_INVALID_CONFIG     = x; x=x+1; -- 未找到配置

    ERR_END
}
