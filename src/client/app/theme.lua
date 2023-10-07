type theme = {
	font: { [string]: Font },
	textColor: { [string]: Color3 },
	background: { [string]: Color3 },
	cornerRadius: { [string]: UDim },
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local currentTheme = Fusion.Value("default")
local themeColors = {}
local themes: theme = {
	font = {
		default = Font.fromName("GothamSSm", Enum.FontWeight.Heavy),
		caesar = Font.fromId(12187368843, Enum.FontWeight.Bold),
	},

	textColor = {
		default = Color3.fromRGB(255, 255, 255),
		dark = Color3.fromRGB(0, 0, 0),
	},

	background = {
		default = Color3.fromRGB(0, 0, 0),
	},

	cornerRadius = {
		default = UDim.new(0, 10),
	},
}

local function update(theme: string)
	currentTheme:set(theme)
end

for name: string, colors in themes do
	themeColors[name] = Fusion.Computed(function()
		return colors[currentTheme:get()]
	end)
end

return {
	update = update,
	themes = themes,
	current = themeColors,
}
