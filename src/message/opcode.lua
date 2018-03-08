
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
