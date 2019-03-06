
‘
session.protomsg"!
PingRequest
time (Rtime""
PingResponse
time (Rtime"6
LoginRequest
acct (	Racct
pass (	Rpass"-
LoginResponse
	ErrorCode (R	ErrorCode"
EnterGameRequest"1
EnterGameResponse
	ErrorCode (R	ErrorCodebproto3
à!

game.protomsg"<
Item
flag (Rflag
id (Rid
cnt (Rcnt"5
PlayerLvExpUpdate
lv (Rlv
exp (Rexp"#
PlayerDataRequest
id (Rid"-
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
pid (	Rpid
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
lv (Rlv"ª

BattleUnit
type (Rtype
id (Rid
lv (Rlv
pos (Rpos
attacker (Rattacker
apm (Rapm
atk (Ratk
def (Rdef
hp	 (Rhp
crit
 (Rcrit
hurt (Rhurt$
comm (2.msg.BattleSkillRcomm&
skill (2.msg.BattleSkillRskill"€
BattleEventSkill
time (Rtime
caster (Rcaster&
skill (2.msg.BattleSkillRskill
targets (Rtargets"
BattleEventAura
time (Rtime
owner (Rowner
caster (Rcaster#
aura (2.msg.BattleAuraRaura
obtain (Robtain"‘
BattleEventHurt
time (Rtime
caster (Rcaster
target (Rtarget
hurt (Rhurt
crit (Rcrit
type (Rtype"½
BattleEventAuraEffect
time (Rtime
owner (Rowner
caster (Rcaster
type (Rtype
arg1 (Rarg1
arg2 (Rarg2
arg3 (Rarg3
arg4 (Rarg4"ü
BattleResult
win (Rwin%
units (2.msg.BattleUnitRunits+
skill (2.msg.BattleEventSkillRskill(
aura (2.msg.BattleEventAuraRaura(
hurt (2.msg.BattleEventHurtRhurt2
effect (2.msg.BattleEventAuraEffectReffect"#
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
count (Rcount"1
MarketBuyResponse
	ErrorCode (R	ErrorCode"-
HeroLevelupRequest
hero_id (RheroId"3
HeroLevelupResponse
	ErrorCode (R	ErrorCode"B
HeroRefineRequest
hero_id (RheroId
super (Rsuper"J
HeroRefineResponse
	ErrorCode (R	ErrorCode
result (Rresult"7
HeroInfoUpdateResponse
hero (2	.msg.HeroRhero"/
	QuestData
key (Rkey
val (Rval"S
	QuestInfo
id (Rid
task (Rtask"
data (2.msg.QuestDataRdata"
QuestListRequest";
QuestListResponse&
quests (2.msg.QuestInfoRquests">
QuestOpRequest
id (Rid
op (Rop
r (Rr"ƒ
QuestOpResponse
id (Rid
op (Rop
r (Rr
	ErrorCode (R	ErrorCode$
quest (2.msg.QuestInfoRquest"5
QuestUpdate&
quests (2.msg.QuestInfoRquests"[
ChapterInfo
LootTs (RLootTs
BreakId (RBreakId
Chapters (RChapters"
ChapterInfoRequest"Y
ChapterInfoResponse
	ErrorCode (R	ErrorCode$
Info (2.msg.ChapterInfoRInfo",
ChapterFightingRequest
Team (RTeam"”
ChapterFightingResponse
	ErrorCode (R	ErrorCode
Win (RWin#
Rewards (2	.msg.ItemRRewards$
Info (2.msg.ChapterInfoRInfo"'
ChapterRewardsRequest
Id (RId"‘
ChapterRewardsResponse
	ErrorCode (R	ErrorCode
Id (RId#
Rewards (2	.msg.ItemRRewards$
Info (2.msg.ChapterInfoRInfo"
ChapterLootRequest"X
ChapterLootResponse
	ErrorCode (R	ErrorCode#
Rewards (2	.msg.ItemRRewardsbproto3