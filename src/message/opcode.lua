
cc.exports.Opcode = {}
local Opcode = Opcode


Opcode.MSG_CS_PING              = 0x0001
Opcode.MSG_SC_PING              = 0x0002

Opcode.MSG_CS_LOGIN             = 0x0003
Opcode.MSG_SC_LOGIN             = 0x0004

Opcode.MSG_CS_ENTER_GAME        = 0x0005
Opcode.MSG_SC_ENTER_GAME        = 0x0006

Opcode.MSG_CS_PlayerData        = 0x0007
Opcode.MSG_SC_PlayerData        = 0x0008

Opcode.MSG_CS_GMCommand         = 0x0009
Opcode.MSG_SC_GMCommand         = 0x000A

Opcode.MSG_CS_Notice            = 0x000B
Opcode.MSG_SC_Notice            = 0x000C

Opcode.MSG_CS_MakeBattle        = 0x000D
Opcode.MSG_SC_MakeBattle        = 0x000E

Opcode.MSG_SC_ItemCntChanged    = 0x000F

Opcode.MSG_CS_UseItem           = 0x0010
Opcode.MSG_SC_UseItem           = 0x0011

Opcode.MSG_CS_MarketBuy         = 0x0012
Opcode.MSG_SC_MarketBuy         = 0x0013

Opcode.MSG_CS_HeroLevelup       = 0x0014
Opcode.MSG_SC_HeroLevelup       = 0x0015

Opcode.MSG_CS_HeroRefine        = 0x0016
Opcode.MSG_SC_HeroRefine        = 0x0017



--------- protobuf map: message & name -----------------------------------------------------------

cc.exports.MsgName = {}
local MsgName = MsgName


MsgName[Opcode.MSG_CS_PING]         = "msg.PingRequest"
MsgName[Opcode.MSG_SC_PING]         = "msg.PingResponse"
MsgName[Opcode.MSG_CS_LOGIN]        = "msg.LoginRequest"
MsgName[Opcode.MSG_SC_LOGIN]        = "msg.LoginResponse"
MsgName[Opcode.MSG_CS_ENTER_GAME]   = "msg.EnterGameRequest"
MsgName[Opcode.MSG_SC_ENTER_GAME]   = "msg.EnterGameResponse"
MsgName[Opcode.MSG_CS_PlayerData]   = "msg.PlayerDataRequest"
MsgName[Opcode.MSG_SC_PlayerData]   = "msg.PlayerDataResponse"
MsgName[Opcode.MSG_CS_GMCommand]    = "msg.GMCommandRequest"
MsgName[Opcode.MSG_SC_GMCommand]    = "msg.GMCommandResponse"
MsgName[Opcode.MSG_CS_Notice]       = "msg.NoticeRequest"
MsgName[Opcode.MSG_SC_Notice]       = "msg.NoticeResponse"
MsgName[Opcode.MSG_CS_MakeBattle]   = "msg.MakeBattleRequest"
MsgName[Opcode.MSG_SC_MakeBattle]   = "msg.MakeBattleResponse"

MsgName[Opcode.MSG_SC_ItemCntChanged]   = "msg.ItemCntChangedNotice"

MsgName[Opcode.MSG_CS_UseItem]      = "msg.UseItemRequest"
MsgName[Opcode.MSG_SC_UseItem]      = "msg.UseItemResponse"

MsgName[Opcode.MSG_CS_MarketBuy]    = "msg.MarketBuyRequest"
MsgName[Opcode.MSG_SC_MarketBuy]    = "msg.MarketBuyResponse"

MsgName[Opcode.MSG_CS_HeroLevelup]  = "msg.HeroLevelupRequest"
MsgName[Opcode.MSG_SC_HeroLevelup]  = "msg.HeroLevelupResponse"

MsgName[Opcode.MSG_CS_HeroRefine]   = "msg.HeroRefineRequest"
MsgName[Opcode.MSG_SC_HeroRefine]   = "msg.HeroRefineResponse"
