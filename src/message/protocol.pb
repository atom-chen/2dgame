
¶
0.type.protomsg"<
Item
Flag (RFlag
Id (RId
Cnt (RCnt"'
Skill
Id (RId
Lv (RLv"&
Aura
Id (RId
Lv (RLv"Ü
Hero
Id (RId
Lv (RLv
Apm (RApm
Talent (RTalent
Aptitude (RAptitude
RefineLv (RRefineLv 
RefineTimes (RRefineTimes 
RefineSuper (RRefineSuper"
Active	 (2
.msg.SkillRActive$
Passive
 (2
.msg.SkillRPassive
Power (RPower
Status (RStatus
	LifePoint (R	LifePoint"
LifePointMax (RLifePointMax"-
BattleSkill
Id (RId
Lv (RLv",

BattleAura
Id (RId
Lv (RLv"™

BattleUnit
Type (RType
Id (RId
Lv (RLv
Pos (RPos
Attacker (RAttacker
Apm (RApm
Atk (RAtk
Def (RDef
Hp	 (RHp
Crit
 (RCrit
Hurt (RHurt$
Comm (2.msg.BattleSkillRComm&
Skill (2.msg.BattleSkillRSkill"Ä
BattleEventSkill
Time (RTime
Caster (RCaster&
Skill (2.msg.BattleSkillRSkill
Targets (RTargets"ê
BattleEventAura
Time (RTime
Owner (ROwner
Caster (RCaster#
Aura (2.msg.BattleAuraRAura
Obtain (RObtain"ë
BattleEventHurt
Time (RTime
Caster (RCaster
Target (RTarget
Hurt (RHurt
Crit (RCrit
Type (RType"Ω
BattleEventAuraEffect
Time (RTime
Owner (ROwner
Caster (RCaster
Type (RType
Arg1 (RArg1
Arg2 (RArg2
Arg3 (RArg3
Arg4 (RArg4"¸
BattleResult
Win (RWin%
Units (2.msg.BattleUnitRUnits+
Skill (2.msg.BattleEventSkillRSkill(
Aura (2.msg.BattleEventAuraRAura(
Hurt (2.msg.BattleEventHurtRHurt2
Effect (2.msg.BattleEventAuraEffectREffectbproto3
ˆ
1_session.protomsg"!
PingRequest
Time (RTime""
PingResponse
Time (RTime"`
LoginRequest
Pseudo (	RPseudo
Token (	RToken
Sdk (	RSdk
Svr (	RSvr"-
LoginResponse
	ErrorCode (R	ErrorCodebproto3
∞
2_player.protomsg0.type.proto"#
PlayerDataRequest
Id (RId"ã
PlayerDataResponse
Acct (	RAcct
Name (	RName
Pid (	RPid
Sid (RSid
Exp (RExp
Lv (RLv
Vip (RVip
Male (RMale
Items	 (2	.msg.ItemRItems
Heros
 (2	.msg.HeroRHeros
Auras (2	.msg.AuraRAuras",
GMCommandRequest
Command (	RCommand"+
GMCommandResponse
Result (RResult"Z
UseItemRequest
Id (RId
Cnt (RCnt
Arg1 (RArg1
Arg2 (RArg2")
UseItemResponse
Result (RResult">
MarketBuyRequest
Index (RIndex
Count (RCount"1
MarketBuyResponse
	ErrorCode (R	ErrorCode"'
ChangeNameRequest
Name (	RName"2
ChangeNameResponse
	ErrorCode (R	ErrorCode"-

ItemUpdate
Items (2	.msg.ItemRItems"3
PlayerExpUpdate
Lv (RLv
Exp (RExp":
NoticeUpdate
Flag (RFlag
Notice (	RNoticebproto3
®
3_hero.protomsg0.type.proto"$
HeroLevelupRequest
Id (RId"3
HeroLevelupResponse
	ErrorCode (R	ErrorCode"7
HeroRefineRequest
Id (RId
Flag (RFlag"J
HeroRefineResponse
	ErrorCode (R	ErrorCode
Result (RResult"%
HeroAptitudeRequest
Id (RId"L
HeroAptitudeResponse
	ErrorCode (R	ErrorCode
Result (RResult"#
HeroTalentRequest
Id (RId"J
HeroTalentResponse
	ErrorCode (R	ErrorCode
Result (RResult"7
HeroInfoUpdateResponse
Hero (2	.msg.HeroRHerobproto3

4_quest.protomsg"/
	QuestData
Key (RKey
Val (RVal"S
	QuestInfo
Id (RId
Task (RTask"
Data (2.msg.QuestDataRData"
QuestListRequest";
QuestListResponse&
Quests (2.msg.QuestInfoRQuests">
QuestOpRequest
Id (RId
Op (ROp
R (RR"É
QuestOpResponse
Id (RId
Op (ROp
R (RR
	ErrorCode (R	ErrorCode$
Quest (2.msg.QuestInfoRQuest"5
QuestUpdate&
Quests (2.msg.QuestInfoRQuestsbproto3
è
5_chapter.protomsg0.type.proto"[
ChapterInfo
LootTs (RLootTs
BreakId (RBreakId
Chapters (RChapters"
ChapterInfoRequest"Y
ChapterInfoResponse
	ErrorCode (R	ErrorCode$
Info (2.msg.ChapterInfoRInfo",
ChapterFightingRequest
Team (RTeam"∑
ChapterFightingResponse
	ErrorCode (R	ErrorCode
Win (RWin#
Rewards (2	.msg.ItemRRewards$
Info (2.msg.ChapterInfoRInfo!
Br (2.msg.BattleResultRBr"'
ChapterRewardsRequest
Id (RId"ë
ChapterRewardsResponse
	ErrorCode (R	ErrorCode
Id (RId#
Rewards (2	.msg.ItemRRewards$
Info (2.msg.ChapterInfoRInfo"
ChapterLootRequest"X
ChapterLootResponse
	ErrorCode (R	ErrorCode#
Rewards (2	.msg.ItemRRewardsbproto3