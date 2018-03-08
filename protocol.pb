
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
Ô

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
notice (	Rnotice"-
BattleSkill
id (Rid
lv (Rlv",

BattleAura
id (Rid
lv (Rlv"»

BattleUnit
type (Rtype
id (Rid
lv (Rlv
pos (Rpos
atk (Ratk
def (Rdef
hp_cur (RhpCur
hp_max (RhpMax
crit	 (Rcrit
	crit_hurt
 (RcritHurt$
comm (2.msg.BattleSkillRcomm&
skill (2.msg.BattleSkillRskill0
aux_s_chief (2.msg.BattleSkillR	auxSChief/
aux_a_chief (2.msg.BattleAuraR	auxAChief3
aux_a_guarder (2.msg.BattleAuraRauxAGuarder"^
BattleDetail
a_pos (RaPos
d_pos (RdPos
a_hp (RaHp
d_hp (RdHp"#
MakeBattleRequest
id (Rid"v
MakeBattleResponse%
uints (2.msg.BattleUnitRuints'
cases (2.msg.BattleDetailRcases
win (Rwinbproto3