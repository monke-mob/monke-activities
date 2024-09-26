local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local _transparency = Fusion.Value(1)

return {
    duration = 6,
    name = Fusion.Value(""),
    role = Fusion.Value(""),
    _transparency = _transparency,
    transparency = Fusion.Tween(_transparency, TweenInfo.new(0.5, Enum.EasingStyle.Sine)),
}
