local data =
{
	[1] = {
		id = 1001,
		level = 1,
		name = "英雄之刃",
		model = "attack",
		icon = "icon/skill/skill_1001.png",
		prepare_t = 0,
		effect_t = 1000,
		itv_t = 0,
		cd_t = 3000,
		type = 1,
		aura_caster = {},
		target_major = {},
		ratio_major = 0.5,
		extra_major = {
			{
				typ = 2,
				val = 100,
			},
			{
				typ = 4,
				val = 10,
			},
			{
				typ = 5,
				val = 20,
			},
		},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {
			{
				typ = 2,
				val = 100,
			},
			{
				typ = 4,
				val = 10,
			},
			{
				typ = 5,
				val = 20,
			},
		},
		aura_minor = {},
		prop_passive = {},
		aura_passive = {},
		desc = "最普通的技能",
	},

	[2] = {
		id = 1002,
		level = 1,
		name = "美人斩",
		model = "skill1",
		icon = "icon/skill/skill_1002.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 1000,
		cd_t = 7000,
		type = 1,
		aura_caster = {},
		target_major = {},
		ratio_major = 0.6,
		extra_major = {},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {},
		prop_passive = {},
		aura_passive = {},
		desc = "攻击目标造成大量伤害",
	},

	[3] = {
		id = 1002,
		level = 2,
		name = "美人斩",
		model = "skill1",
		icon = "icon/skill/skill_1002.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 1000,
		cd_t = 7000,
		type = 1,
		aura_caster = {},
		target_major = {},
		ratio_major = 0.7,
		extra_major = {},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {},
		prop_passive = {},
		aura_passive = {},
		desc = "攻击目标造成大量伤害",
	},

	[4] = {
		id = 1002,
		level = 3,
		name = "美人斩",
		model = "skill1",
		icon = "icon/skill/skill_1002.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 1000,
		cd_t = 7000,
		type = 1,
		aura_caster = {},
		target_major = {},
		ratio_major = 0.8,
		extra_major = {},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {},
		prop_passive = {},
		aura_passive = {},
		desc = "攻击目标造成大量伤害",
	},

	[5] = {
		id = 1002,
		level = 4,
		name = "美人斩",
		model = "skill1",
		icon = "icon/skill/skill_1002.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 1000,
		cd_t = 7000,
		type = 1,
		aura_caster = {},
		target_major = {},
		ratio_major = 0.9,
		extra_major = {},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {},
		prop_passive = {},
		aura_passive = {},
		desc = "攻击目标造成大量伤害",
	},

	[6] = {
		id = 1002,
		level = 5,
		name = "美人斩",
		model = "skill1",
		icon = "icon/skill/skill_1002.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 1000,
		cd_t = 7000,
		type = 1,
		aura_caster = {},
		target_major = {},
		ratio_major = 1,
		extra_major = {},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {},
		prop_passive = {},
		aura_passive = {},
		desc = "攻击目标造成大量伤害",
	},

	[7] = {
		id = 1003,
		level = 1,
		name = "蛇蝎心",
		model = "skill2",
		icon = "icon/skill/skill_1003.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 0,
		cd_t = 7000,
		type = 1,
		aura_caster = {
			{
				prob = 100,
				id = 2005,
				lv = 1,
			},
		},
		target_major = {},
		ratio_major = 0.85,
		extra_major = {
			{
				typ = 2,
				val = 100,
			},
			{
				typ = 4,
				val = 10,
			},
			{
				typ = 5,
				val = 20,
			},
		},
		aura_major = {
			{
				prob = 80,
				id = 2005,
				lv = 1,
			},
		},
		target_minor = {},
		ratio_minor = 0.55,
		extra_minor = {
			{
				typ = 2,
				val = 100,
			},
			{
				typ = 4,
				val = 10,
			},
			{
				typ = 5,
				val = 20,
			},
		},
		aura_minor = {
			{
				prob = 80,
				id = 2005,
				lv = 1,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "伤害大量伤害并增加掉防光环",
	},

	[8] = {
		id = 1003,
		level = 2,
		name = "蛇蝎心",
		model = "skill2",
		icon = "icon/skill/skill_1003.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 0,
		cd_t = 7000,
		type = 1,
		aura_caster = {
			{
				prob = 100,
				id = 2005,
				lv = 2,
			},
		},
		target_major = {},
		ratio_major = 1,
		extra_major = {
			{
				typ = 2,
				val = 110,
			},
			{
				typ = 4,
				val = 15,
			},
			{
				typ = 5,
				val = 25,
			},
		},
		aura_major = {
			{
				prob = 80,
				id = 2005,
				lv = 2,
			},
		},
		target_minor = {},
		ratio_minor = 0.6,
		extra_minor = {
			{
				typ = 2,
				val = 110,
			},
			{
				typ = 4,
				val = 15,
			},
			{
				typ = 5,
				val = 25,
			},
		},
		aura_minor = {
			{
				prob = 80,
				id = 2005,
				lv = 2,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "伤害大量伤害并增加掉防光环",
	},

	[9] = {
		id = 1003,
		level = 3,
		name = "蛇蝎心",
		model = "skill2",
		icon = "icon/skill/skill_1003.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 0,
		cd_t = 7000,
		type = 1,
		aura_caster = {
			{
				prob = 100,
				id = 2005,
				lv = 3,
			},
		},
		target_major = {},
		ratio_major = 1.15,
		extra_major = {
			{
				typ = 2,
				val = 120,
			},
			{
				typ = 4,
				val = 20,
			},
			{
				typ = 5,
				val = 30,
			},
		},
		aura_major = {
			{
				prob = 80,
				id = 2005,
				lv = 3,
			},
		},
		target_minor = {},
		ratio_minor = 0.65,
		extra_minor = {
			{
				typ = 2,
				val = 120,
			},
			{
				typ = 4,
				val = 20,
			},
			{
				typ = 5,
				val = 30,
			},
		},
		aura_minor = {
			{
				prob = 80,
				id = 2005,
				lv = 3,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "伤害大量伤害并增加掉防光环",
	},

	[10] = {
		id = 1003,
		level = 4,
		name = "蛇蝎心",
		model = "skill2",
		icon = "icon/skill/skill_1003.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 0,
		cd_t = 7000,
		type = 1,
		aura_caster = {
			{
				prob = 100,
				id = 2005,
				lv = 4,
			},
		},
		target_major = {},
		ratio_major = 1.3,
		extra_major = {
			{
				typ = 2,
				val = 130,
			},
			{
				typ = 4,
				val = 25,
			},
			{
				typ = 5,
				val = 35,
			},
		},
		aura_major = {
			{
				prob = 80,
				id = 2005,
				lv = 4,
			},
		},
		target_minor = {},
		ratio_minor = 0.7,
		extra_minor = {
			{
				typ = 2,
				val = 130,
			},
			{
				typ = 4,
				val = 25,
			},
			{
				typ = 5,
				val = 35,
			},
		},
		aura_minor = {
			{
				prob = 80,
				id = 2005,
				lv = 4,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "伤害大量伤害并增加掉防光环",
	},

	[11] = {
		id = 1003,
		level = 5,
		name = "蛇蝎心",
		model = "skill2",
		icon = "icon/skill/skill_1003.png",
		prepare_t = 0,
		effect_t = 3000,
		itv_t = 0,
		cd_t = 7000,
		type = 1,
		aura_caster = {
			{
				prob = 100,
				id = 2005,
				lv = 5,
			},
		},
		target_major = {},
		ratio_major = 1.45,
		extra_major = {
			{
				typ = 2,
				val = 140,
			},
			{
				typ = 4,
				val = 30,
			},
			{
				typ = 5,
				val = 40,
			},
		},
		aura_major = {
			{
				prob = 80,
				id = 2005,
				lv = 5,
			},
		},
		target_minor = {},
		ratio_minor = 0.75,
		extra_minor = {
			{
				typ = 2,
				val = 140,
			},
			{
				typ = 4,
				val = 30,
			},
			{
				typ = 5,
				val = 40,
			},
		},
		aura_minor = {
			{
				prob = 80,
				id = 2005,
				lv = 5,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "伤害大量伤害并增加掉防光环",
	},

	[12] = {
		id = 1004,
		level = 1,
		name = "貂蝉之吻",
		model = "skill2",
		icon = "icon/skill/skill_1004.png",
		prepare_t = 0,
		effect_t = 2000,
		itv_t = 0,
		cd_t = 7000,
		type = 2,
		aura_caster = {
			{
				prob = 100,
				id = 2004,
				lv = 1,
			},
		},
		target_major = {},
		ratio_major = 0,
		extra_major = {},
		aura_major = {
			{
				prob = 80,
				id = 2004,
				lv = 1,
			},
		},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {
			{
				prob = 80,
				id = 2004,
				lv = 1,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "增加吸血光环",
	},

	[13] = {
		id = 1004,
		level = 2,
		name = "貂蝉之吻",
		model = "skill2",
		icon = "icon/skill/skill_1004.png",
		prepare_t = 0,
		effect_t = 2000,
		itv_t = 0,
		cd_t = 7000,
		type = 2,
		aura_caster = {
			{
				prob = 100,
				id = 2004,
				lv = 2,
			},
		},
		target_major = {},
		ratio_major = 0,
		extra_major = {},
		aura_major = {
			{
				prob = 80,
				id = 2004,
				lv = 2,
			},
		},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {
			{
				prob = 80,
				id = 2004,
				lv = 2,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "增加吸血光环",
	},

	[14] = {
		id = 1004,
		level = 3,
		name = "貂蝉之吻",
		model = "skill2",
		icon = "icon/skill/skill_1004.png",
		prepare_t = 0,
		effect_t = 2000,
		itv_t = 0,
		cd_t = 7000,
		type = 2,
		aura_caster = {
			{
				prob = 100,
				id = 2004,
				lv = 3,
			},
		},
		target_major = {},
		ratio_major = 0,
		extra_major = {},
		aura_major = {
			{
				prob = 80,
				id = 2004,
				lv = 3,
			},
		},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {
			{
				prob = 80,
				id = 2004,
				lv = 3,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "增加吸血光环",
	},

	[15] = {
		id = 1004,
		level = 4,
		name = "貂蝉之吻",
		model = "skill2",
		icon = "icon/skill/skill_1004.png",
		prepare_t = 0,
		effect_t = 2000,
		itv_t = 0,
		cd_t = 7000,
		type = 2,
		aura_caster = {
			{
				prob = 100,
				id = 2004,
				lv = 4,
			},
		},
		target_major = {},
		ratio_major = 0,
		extra_major = {},
		aura_major = {
			{
				prob = 80,
				id = 2004,
				lv = 4,
			},
		},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {
			{
				prob = 80,
				id = 2004,
				lv = 4,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "增加吸血光环",
	},

	[16] = {
		id = 1004,
		level = 5,
		name = "貂蝉之吻",
		model = "skill2",
		icon = "icon/skill/skill_1004.png",
		prepare_t = 0,
		effect_t = 2000,
		itv_t = 0,
		cd_t = 7000,
		type = 2,
		aura_caster = {
			{
				prob = 100,
				id = 2004,
				lv = 5,
			},
		},
		target_major = {},
		ratio_major = 0,
		extra_major = {},
		aura_major = {
			{
				prob = 80,
				id = 2004,
				lv = 5,
			},
		},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {},
		aura_minor = {
			{
				prob = 80,
				id = 2004,
				lv = 5,
			},
		},
		prop_passive = {},
		aura_passive = {},
		desc = "增加吸血光环",
	},

	[17] = {
		id = 1005,
		level = 1,
		name = "天使圣光",
		model = "",
		icon = "icon/skill/skill_1005.png",
		prepare_t = 0,
		effect_t = 0,
		itv_t = 0,
		cd_t = 0,
		type = 0,
		aura_caster = {},
		target_major = {},
		ratio_major = 0,
		extra_major = {
			{
				typ = 1,
				val = 10,
			},
			{
				typ = 2,
				val = 20,
			},
			{
				typ = 3,
				val = 30,
			},
			{
				typ = 4,
				val = 4,
			},
			{
				typ = 5,
				val = 5,
			},
		},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {
			{
				typ = 1,
				val = 10,
			},
			{
				typ = 2,
				val = 20,
			},
			{
				typ = 3,
				val = 30,
			},
			{
				typ = 4,
				val = 4,
			},
			{
				typ = 5,
				val = 5,
			},
		},
		aura_minor = {},
		prop_passive = {
			{
				id = 0,
				part = 0,
				val = 250,
			},
			{
				id = 1,
				part = 0,
				val = 30,
			},
			{
				id = 2,
				part = 0,
				val = 55,
			},
			{
				id = 3,
				part = 0,
				val = 22,
			},
			{
				id = 4,
				part = 0,
				val = 6,
			},
			{
				id = 5,
				part = 0,
				val = 45,
			},
		},
		aura_passive = {
			{
				prob = 100,
				id = 2004,
				lv = 5,
			},
		},
		desc = "吸天地精华，淬炼自身",
	},

	[18] = {
		id = 1005,
		level = 2,
		name = "天使圣光",
		model = "",
		icon = "icon/skill/skill_1005.png",
		prepare_t = 0,
		effect_t = 0,
		itv_t = 0,
		cd_t = 0,
		type = 0,
		aura_caster = {},
		target_major = {},
		ratio_major = 0,
		extra_major = {
			{
				typ = 1,
				val = 20,
			},
			{
				typ = 2,
				val = 22,
			},
			{
				typ = 3,
				val = 40,
			},
			{
				typ = 4,
				val = 6,
			},
			{
				typ = 5,
				val = 10,
			},
		},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {
			{
				typ = 1,
				val = 20,
			},
			{
				typ = 2,
				val = 22,
			},
			{
				typ = 3,
				val = 40,
			},
			{
				typ = 4,
				val = 6,
			},
			{
				typ = 5,
				val = 10,
			},
		},
		aura_minor = {},
		prop_passive = {
			{
				id = 0,
				part = 0,
				val = 300,
			},
			{
				id = 1,
				part = 0,
				val = 30,
			},
			{
				id = 2,
				part = 0,
				val = 60,
			},
			{
				id = 3,
				part = 0,
				val = 24,
			},
			{
				id = 4,
				part = 0,
				val = 7,
			},
			{
				id = 5,
				part = 0,
				val = 50,
			},
		},
		aura_passive = {
			{
				prob = 100,
				id = 2004,
				lv = 5,
			},
		},
		desc = "吸天地精华，淬炼自身",
	},

	[19] = {
		id = 1005,
		level = 3,
		name = "天使圣光",
		model = "",
		icon = "icon/skill/skill_1005.png",
		prepare_t = 0,
		effect_t = 0,
		itv_t = 0,
		cd_t = 0,
		type = 0,
		aura_caster = {},
		target_major = {},
		ratio_major = 0,
		extra_major = {
			{
				typ = 1,
				val = 30,
			},
			{
				typ = 2,
				val = 24,
			},
			{
				typ = 3,
				val = 50,
			},
			{
				typ = 4,
				val = 8,
			},
			{
				typ = 5,
				val = 15,
			},
		},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {
			{
				typ = 1,
				val = 30,
			},
			{
				typ = 2,
				val = 24,
			},
			{
				typ = 3,
				val = 50,
			},
			{
				typ = 4,
				val = 8,
			},
			{
				typ = 5,
				val = 15,
			},
		},
		aura_minor = {},
		prop_passive = {
			{
				id = 0,
				part = 0,
				val = 350,
			},
			{
				id = 1,
				part = 0,
				val = 30,
			},
			{
				id = 2,
				part = 0,
				val = 65,
			},
			{
				id = 3,
				part = 0,
				val = 26,
			},
			{
				id = 4,
				part = 0,
				val = 8,
			},
			{
				id = 5,
				part = 0,
				val = 55,
			},
		},
		aura_passive = {
			{
				prob = 100,
				id = 2004,
				lv = 5,
			},
		},
		desc = "吸天地精华，淬炼自身",
	},

	[20] = {
		id = 1005,
		level = 4,
		name = "天使圣光",
		model = "",
		icon = "icon/skill/skill_1005.png",
		prepare_t = 0,
		effect_t = 0,
		itv_t = 0,
		cd_t = 0,
		type = 0,
		aura_caster = {},
		target_major = {},
		ratio_major = 0,
		extra_major = {
			{
				typ = 1,
				val = 40,
			},
			{
				typ = 2,
				val = 25,
			},
			{
				typ = 3,
				val = 60,
			},
			{
				typ = 4,
				val = 10,
			},
			{
				typ = 5,
				val = 20,
			},
		},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {
			{
				typ = 1,
				val = 40,
			},
			{
				typ = 2,
				val = 25,
			},
			{
				typ = 3,
				val = 60,
			},
			{
				typ = 4,
				val = 10,
			},
			{
				typ = 5,
				val = 20,
			},
		},
		aura_minor = {},
		prop_passive = {
			{
				id = 0,
				part = 0,
				val = 400,
			},
			{
				id = 1,
				part = 0,
				val = 30,
			},
			{
				id = 2,
				part = 0,
				val = 70,
			},
			{
				id = 3,
				part = 0,
				val = 28,
			},
			{
				id = 4,
				part = 0,
				val = 9,
			},
			{
				id = 5,
				part = 0,
				val = 60,
			},
		},
		aura_passive = {
			{
				prob = 100,
				id = 2004,
				lv = 5,
			},
		},
		desc = "吸天地精华，淬炼自身",
	},

	[21] = {
		id = 1005,
		level = 5,
		name = "天使圣光",
		model = "",
		icon = "icon/skill/skill_1005.png",
		prepare_t = 0,
		effect_t = 0,
		itv_t = 0,
		cd_t = 0,
		type = 0,
		aura_caster = {},
		target_major = {},
		ratio_major = 0,
		extra_major = {
			{
				typ = 1,
				val = 50,
			},
			{
				typ = 2,
				val = 26,
			},
			{
				typ = 3,
				val = 70,
			},
			{
				typ = 4,
				val = 12,
			},
			{
				typ = 5,
				val = 25,
			},
		},
		aura_major = {},
		target_minor = {},
		ratio_minor = 0,
		extra_minor = {
			{
				typ = 1,
				val = 50,
			},
			{
				typ = 2,
				val = 26,
			},
			{
				typ = 3,
				val = 70,
			},
			{
				typ = 4,
				val = 12,
			},
			{
				typ = 5,
				val = 25,
			},
		},
		aura_minor = {},
		prop_passive = {
			{
				id = 0,
				part = 0,
				val = 200,
			},
			{
				id = 1,
				part = 0,
				val = 30,
			},
			{
				id = 2,
				part = 0,
				val = 50,
			},
			{
				id = 3,
				part = 0,
				val = 20,
			},
			{
				id = 4,
				part = 0,
				val = 5,
			},
			{
				id = 5,
				part = 0,
				val = 40,
			},
		},
		aura_passive = {
			{
				prob = 100,
				id = 2004,
				lv = 5,
			},
		},
		desc = "吸天地精华，淬炼自身",
	},

}

return data
