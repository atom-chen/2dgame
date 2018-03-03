
“
session.protomsg"!
PingRequest
time (Rtime""
PingResponse
time (Rtime"6
LoginRequest
acct (	Racct
pass (	Rpass".
LoginResponse

error_code (R	errorCode"
EnterGameRequest"2
EnterGameResponse

error_code (R	errorCodebproto3
¼

game.protomsg"#
PlayerDataRequest
id (Rid"<
Item
flag (Rflag
id (Rid
cnt (Rcnt";
	Equipment
quality (Rquality
level (Rlevel"I
Skill
id (Rid
level (Rlevel
effectId (ReffectId",
Aura
id (Rid
level (Rlevel"•
Hero
id (Rid
level (Rlevel
quality (Rquality
power (Rpower&
equips (2.msg.EquipmentRequips"
skills (2
.msg.SkillRskills
auras (2	.msg.AuraRauras
status (Rstatus

statusData	 (R
statusData
dead
 (Rdead"™
PlayerDataResponse
acct (	Racct
name (	Rname
pid (Rpid
sid (Rsid
id (Rid
level (Rlevel
vipLevel (RvipLevel
male (Rmale
items	 (2	.msg.ItemRitems
heros
 (2	.msg.HeroRheros
auras (2	.msg.AuraRauras",
GMCommandRequest
command (	Rcommand"+
GMCommandResponse
result (Rresult";
NoticeRequest
flag (Rflag
notice (	Rnotice"<
NoticeResponse
flag (Rflag
notice (	Rnoticebproto3