
�

PingRequest
time (
PingResponse
time (
LoginRequest
acct (	Racct
pass (	Rpass".


error_code (
EnterGameRequest"2
EnterGameResponse

error_code (
�!

game.protomsg"<
Item
flag (
id (
cnt (Rcnt"5
PlayerLvExpUpdate
lv (
exp (Rexp"#
PlayerDataRequest
id (Rid"-
Skill
id (
level (
Aura
id (
level (
Hero
id (
level (
refineLv (
refineTimes (
refineSuper (RrefineSuper"
active (2
.msg.SkillRactive$
passive (2
.msg.SkillRpassive
power (
status	 (
	lifePoint
 (
lifePointMax (
PlayerDataResponse
acct (	Racct
name (	Rname
pid (	Rpid
sid (
id (Rid
level (
vipLevel (
male (Rmale
items	 (2	.msg.ItemRitems
heros
 (2	.msg.HeroRheros
auras (2	.msg.AuraRauras",
GMCommandRequest
command (	Rcommand"+
GMCommandResponse
result (Rresult";

flag (Rflag
notice (	Rnotice"<
NoticeResponse
flag (Rflag
notice (	Rnotice"-
BattleSkill
id (
lv (

BattleAura
id (
lv (

BattleUnit
type (
id (
lv (
pos (
attacker (
apm (
atk (
def (
hp	 (
crit
 (
hurt (
comm (2.msg.BattleSkillRcomm&
skill
BattleEventSkill
time (
caster (
skill (2.msg.BattleSkillRskill
targets (
BattleEventAura
time (
owner (
caster (
aura (2.msg.BattleAuraRaura
obtain (Robtain"�
BattleEventHurt
time (
caster (
target (
hurt (
crit (
type (
BattleEventAuraEffect
time (
owner (
caster (
type (
arg1 (Rarg1
arg2 (Rarg2
arg3 (Rarg3
arg4 (Rarg4"�
BattleResult
win (Rwin%
units (2.msg.BattleUnitRunits+
skill (2.msg.BattleEventSkillRskill(
aura (2.msg.BattleEventAuraRaura(
hurt (2.msg.BattleEventHurtRhurt2
effect (2.msg.BattleEventAuraEffectReffect"#
MakeBattleRequest
id (
MakeBattleResponse)
result (2.msg.BattleResultRresult"Z
UseItemRequest
id (
cnt (
arg1 (Rarg1
arg2 (Rarg2")
UseItemResponse
result (
ItemCntInfo
add (
id (
cnt (Rcnt"<
ItemCntChangedNotice$
info (2.msg.ItemCntInfoRinfo">
MarketBuyRequest
index (
count (Rcount"2
MarketBuyResponse

error_code (
HeroLevelupRequest
hero_id (
HeroLevelupResponse

error_code (
HeroRefineRequest
hero_id (
super (
HeroRefineResponse

error_code (
result (
HeroInfoUpdateResponse
hero (2	.msg.HeroRhero"/
	QuestData
key (Rkey
val (Rval"S
	QuestInfo
id (
task (
data (2.msg.QuestDataRdata"
QuestListRequest";
QuestListResponse&
quests (2.msg.QuestInfoRquests">
QuestOpRequest
id (
op (
r (
QuestOpResponse
id (
op (
r (

error_code (
quest (2.msg.QuestInfoRquest"5
QuestUpdate&
Quests (2.msg.QuestInfoRQuests"
ChapterInfo"
ChapterInfoRequest"Z
ChapterInfoResponse

error_code (
info (2.msg.ChapterInfoRinfo"
ChapterFightingRequest"�
ChapterFightingResponse

error_code (
win (Rwin#
rewards (2	.msg.ItemRrewards$
info (2.msg.ChapterInfoRinfo"'
ChapterRewardsRequest
id (
ChapterRewardsResponse

error_code (
id (
rewards (2	.msg.ItemRrewards$
info (2.msg.ChapterInfoRinfo"
ChapterLootRequest"Y
ChapterLootResponse

error_code (
rewards (2	.msg.ItemRrewardsbproto3