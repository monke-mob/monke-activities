return {
    font = {
        primary = Font.fromName("GothamSSm", Enum.FontWeight.Heavy),
        bold = Font.fromName("GothamSSm", Enum.FontWeight.Bold),
        light = Font.fromName("GothamSSm", Enum.FontWeight.Medium),
        caesar = Font.fromId(12187368843, Enum.FontWeight.Bold),
    },

    foreground = {
        primary = Color3.fromRGB(255, 255, 255),
        light = Color3.fromRGB(229, 229, 229),
        dark = Color3.fromRGB(0, 0, 0),
    },

    background = {
        primary = Color3.fromRGB(0, 0, 0),
    },

    cornerRadius = {
        primary = UDim.new(0, 15),
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