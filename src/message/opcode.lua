
cc.exports.Opcode = {}
local Opcode = Opcode


Opcode.MSG_CS_PING       = 1
Opcode.MSG_SC_PING       = 2

Opcode.MSG_CS_LOGIN      = 3
Opcode.MSG_SC_LOGIN      = 4

Opcode.MSG_CS_ENTER_GAME = 5
Opcode.MSG_SC_ENTER_GAME = 6

Opcode.MSG_CS_PlayerData = 7
Opcode.MSG_SC_PlayerData = 8


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
