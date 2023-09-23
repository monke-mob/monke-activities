local roundTypes = require(script.Parent.Parent.Parent.types)
local createTeam = require(script.Parent.Parent.Parent.functions.createTeam)

return {
	teamType = "single",

	respawning = {
		enabled = true,
		scoreDamage = 1,
	},

	endingCondition = {
		type = "time",
		duration = 60,
	},

	teams = {
		usesCustomTeamBalancer = false,
		ids = {
			[1] = createTeam("team1", 2),
			[2] = createTeam("team2", 2),
		},
	},
} :: roundTypes.config
