type theme = {
    font: { [string]: Font },
    textColor: { [string]: Color3 },
    background: { [string]: Color3 },
    cornerRadius: { [string]: UDim },
    gradient: { [string]: ColorSequence },
}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local THEME_BLACKLIST = { "gradient" }

local currentTheme = Fusion.Value("default")
local themeColors = {}
local themes: theme = {
    font = {
        default = Font.fromName("GothamSSm", Enum.FontWeight.Heavy),
        light = Font.fromName("GothamSSm", Enum.FontWeight.Medium),
        caesar = Font.fromId(12187368843, Enum.FontWeight.Bold),
    },

    textColor = {
        default = Color3.fromRGB(255, 255, 255),
        dark = Color3.fromRGB(0, 0, 0),
    },

    foreground = {
        default = Color3.fromRGB(229, 229, 229),
    },

    background = {
        default = Color3.fromRGB(0, 0, 0),
    },

    cornerRadius = {
        default = UDim.new(0, 15),
        large = UDim.new(0, 20),
    },

    gradient = {
        brand = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#ffd160")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#ffad00")),
        }),
        dark = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#060d15")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#02080e")),
        }),
    },
}

local function update(theme: string)
    currentTheme:set(theme)
end

for name: string, colors in themes do
    if table.find(THEME_BLACKLIST, name) then
        continue
    end

    themeColors[name] = Fusion.Computed(function()
        return colors[currentTheme:get()]
    end)
end

return {
    update = update,
    themes = themes,
    current = themeColors,
}
