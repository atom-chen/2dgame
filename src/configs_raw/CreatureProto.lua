local data = 
{
	[1] = {
		id = 10001,
		level = 1,
		name = "鼠",
		model = "caocao",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1002,
				lv = 1,
			},
		},
		aura = {
			{
				id = 2001,
				lv = 1,
			},
			{
				id = 2001,
				lv = 1,
			},
		},
		atk = 100,
		def = 20,
		hp = 2400,
		crit = 5,
		crit_hurt = 40,
	},

	[2] = {
		id = 10002,
		level = 1,
		name = "牛",
		model = "caopi",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1002,
				lv = 2,
			},
		},
		aura = {
			{
				id = 2001,
				lv = 1,
			},
			{
				id = 2001,
				lv = 1,
			},
		},
		atk = 120,
		def = 22,
		hp = 2500,
		crit = 6,
		crit_hurt = 42,
	},

	[3] = {
		id = 10003,
		level = 1,
		name = "虎",
		model = "caoren",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1002,
				lv = 3,
			},
		},
		aura = {
			{
				id = 2001,
				lv = 1,
			},
			{
				id = 2001,
				lv = 2,
			},
		},
		atk = 140,
		def = 24,
		hp = 2600,
		crit = 7,
		crit_hurt = 44,
	},

	[4] = {
		id = 10004,
		level = 1,
		name = "兔",
		model = "daqiao",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1002,
				lv = 4,
			},
		},
		aura = {
			{
				id = 2001,
				lv = 1,
			},
			{
				id = 2001,
				lv = 2,
			},
		},
		atk = 160,
		def = 26,
		hp = 2700,
		crit = 8,
		crit_hurt = 46,
	},

	[5] = {
		id = 10005,
		level = 1,
		name = "龙",
		model = "zhugeliang",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1002,
				lv = 5,
			},
		},
		aura = {
			{
				id = 2002,
				lv = 1,
			},
			{
				id = 2002,
				lv = 3,
			},
		},
		atk = 180,
		def = 28,
		hp = 2800,
		crit = 9,
		crit_hurt = 48,
	},

	[6] = {
		id = 10006,
		level = 1,
		name = "蛇",
		model = "zhangfei",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1003,
				lv = 1,
			},
		},
		aura = {
			{
				id = 2002,
				lv = 1,
			},
			{
				id = 2002,
				lv = 3,
			},
		},
		atk = 200,
		def = 30,
		hp = 2900,
		crit = 10,
		crit_hurt = 50,
	},

	[7] = {
		id = 10007,
		level = 1,
		name = "马",
		model = "liubei",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1003,
				lv = 2,
			},
		},
		aura = {
			{
				id = 2002,
				lv = 1,
			},
			{
				id = 2002,
				lv = 4,
			},
		},
		atk = 220,
		def = 32,
		hp = 3000,
		crit = 11,
		crit_hurt = 52,
	},

	[8] = {
		id = 10008,
		level = 1,
		name = "羊",
		model = "guojia",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1003,
				lv = 3,
			},
		},
		aura = {
			{
				id = 2002,
				lv = 1,
			},
			{
				id = 2002,
				lv = 4,
			},
		},
		atk = 240,
		def = 34,
		hp = 3100,
		crit = 12,
		crit_hurt = 54,
	},

	[9] = {
		id = 10009,
		level = 1,
		name = "猴",
		model = "huanggai",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1003,
				lv = 4,
			},
		},
		aura = {
			{
				id = 2003,
				lv = 1,
			},
			{
				id = 2003,
				lv = 5,
			},
		},
		atk = 260,
		def = 36,
		hp = 3200,
		crit = 13,
		crit_hurt = 56,
	},

	[10] = {
		id = 10010,
		level = 1,
		name = "鸡",
		model = "jushou",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1003,
				lv = 5,
			},
		},
		aura = {
			{
				id = 2003,
				lv = 1,
			},
			{
				id = 2003,
				lv = 5,
			},
		},
		atk = 280,
		def = 38,
		hp = 3300,
		crit = 14,
		crit_hurt = 58,
	},

	[11] = {
		id = 10011,
		level = 1,
		name = "狗",
		model = "jiaxu",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1004,
				lv = 1,
			},
		},
		aura = {
			{
				id = 2003,
				lv = 1,
			},
			{
				id = 2003,
				lv = 2,
			},
		},
		atk = 300,
		def = 40,
		hp = 3400,
		crit = 15,
		crit_hurt = 60,
	},

	[12] = {
		id = 10012,
		level = 1,
		name = "猪",
		model = "lvbu",
		skill_common = {
			{
				id = 1001,
				lv = 1,
			},
		},
		skill_extra = {
			{
				id = 1005,
				lv = 1,
			},
		},
		aura = {
			{
				id = 2003,
				lv = 1,
			},
			{
				id = 2003,
				lv = 2,
			},
		},
		atk = 320,
		def = 42,
		hp = 3500,
		crit = 16,
		crit_hurt = 62,
	},

}

return data
