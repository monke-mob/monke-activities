type theme = {
	font: { [string]: Font },
	foreground: { [string]: Color3 },
	background: { [string]: Color3 },
	cornerRadius: { [string]: UDim },
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local currentTheme = Fusion.Value("default")
local themeColors: theme = {} :: any

local THEMES: theme = {
	font = {
		default = Font.fromName("GothamSSm", Enum.FontWeight.Bold),
	},

	attentionFont = {
		default = Font.fromName("CaesarDressing", Enum.FontWeight.Bold),
	},

	foreground = {
		default = Color3.fromRGB(229, 229, 229),
	},

	background = {
		default = Color3.fromHex("#02080e"),
	},

	cornerRadius = {
		default = UDim.new(0, 15),
	}
}

--[[
	Updates the theme colors.

	@public
	@param {string} theme [The theme name.]
	@returns never
]]
local function update(theme: string)
	currentTheme:set(theme)
end

-- This sets the starting theme.
for name: string, colors in THEMES do
	themeColors[name] = Fusion.Computed(function()
		return colors[currentTheme:get()]
	end)
end

return {
	update = update,
	THEMES = THEMES,
	current = themeColors,
}
