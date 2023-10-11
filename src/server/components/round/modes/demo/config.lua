local roundTypes = require(script.Parent.Parent.Parent.types)

local createTeam = require(script.Parent.Parent.Parent.functions.createTeam)

return {
	teamType = "single",

	respawning = {
		enabled = true,
		scoreDamage = 1,
	},

	endCondition = {
		type = "time",
		duration = 20,
	},

	scoring = {
		type = "time",
		time = {
			pointsPerIncrement = 1,
		},
	},

	teams = {
		usesCustomTeamBalancer = false,
		ids = {
			[1] = createTeam("rocketer", 1),
			[2] = createTeam("players", 15),
		},
	},
} :: roundTypes.config
