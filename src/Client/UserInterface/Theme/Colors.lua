return {
    Background = {
        Primary = Color3.fromRGB(0, 0, 0),
    },

    Foreground = {
        Primary = Color3.fromRGB(255, 255, 255),
        Light = Color3.fromRGB(229, 229, 229),
    },

    Gradient = {
        Brand = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("#ffd160")),
            ColorSequenceKeypoint.new(1, Color3.fromHex("#ffad00")),
        }),
    },
}
