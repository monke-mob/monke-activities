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

    icons = {
        logo = "rbxassetid://14827422191",
        credits = "rbxassetid://15999740081",
        settings = "rbxassetid://15999742619",
        players = "rbxassetid://15999739064",
        codes = "rbxassetid://15999737853",
        menu = "rbxassetid://14800609693",
        friendRequest = "rbxassetid://16006823235",
        score = "rbxassetid://16000738233",
    },
}
