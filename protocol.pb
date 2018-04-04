
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
§

game.protomsg"#
PlayerDataRequest
id (Rid"<
Item
flag (Rflag
id (Rid
cnt (Rcnt"-
Skill
id (Rid
level (Rlevel",
Aura
id (Rid
level (Rlevel"Æ
Hero
id (Rid
level (Rlevel
refineLv (RrefineLv 
refineTimes (RrefineTimes 
refineSuper (RrefineSuper"
active (2
.msg.SkillRactive$
passive (2
.msg.SkillRpassive
power (Rpower
status	 (Rstatus
	lifePoint
 (R	lifePoint"
lifePointMax (RlifePointMax"™
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
lv (Rlv"Ë

BattleUnit
type (Rtype
id (Rid
lv (Rlv
pos (Rpos
atk (Ratk
def (Rdef
hp (Rhp
crit (Rcrit
	crit_hurt	 (RcritHurt$
comm
 (2.msg.BattleSkillRcomm&
skill (2.msg.BattleSkillRskillB
career_general_skill (2.msg.BattleSkillRcareerGeneralSkill?
career_general_aura (2.msg.BattleAuraRcareerGeneralAura?
career_guarder_aura (2.msg.BattleAuraRcareerGuarderAura"œ
CampaignDetail
host (Rhost
time (Rtime
flag (Rflag
arg1 (Rarg1
arg2 (Rarg2
arg3 (Rarg3
arg4 (Rarg4"Á
BattleCampaign
a_pos (RaPos
d_pos (RdPos
a_hp_s (RaHpS
d_hp_s (RdHpS
a_hp_e (RaHpE
d_hp_e (RdHpE-
details (2.msg.CampaignDetailRdetails"r
BattleResult%
units (2.msg.BattleUnitRunits)
camps (2.msg.BattleCampaignRcamps
win (Rwin"#
MakeBattleRequest
id (Rid"?
MakeBattleResponse)
result (2.msg.BattleResultRresult"Z
UseItemRequest
id (Rid
cnt (Rcnt
arg1 (Rarg1
arg2 (Rarg2")
UseItemResponse
result (Rresult"A
ItemCntInfo
add (Radd
id (Rid
cnt (Rcnt"<
ItemCntChangedNotice$
info (2.msg.ItemCntInfoRinfo">
MarketBuyRequest
index (Rindex
count (Rcount"2
MarketBuyResponse

error_code (R	errorCode"-
HeroLevelupRequest
hero_id (RheroId"4
HeroLevelupResponse

error_code (R	errorCode"B
HeroRefineRequest
hero_id (RheroId
super (Rsuper"K
HeroRefineResponse

error_code (R	errorCode
result (Rresult"7
HeroInfoUpdateResponse
hero (2	.msg.HeroRherobproto3