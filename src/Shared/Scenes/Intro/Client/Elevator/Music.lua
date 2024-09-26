local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Future = require(ReplicatedStorage.Packages.Future)

local FADE: number = 2

local sound: Sound
local volume = Fusion.Value(0)

local Music = {}

--[[
    Creates the sound instance.

    @returns never
]]
function Music:prepare()
    sound = Fusion.New("Sound")({
        Volume = Fusion.Tween(volume, TweenInfo.new(FADE, Enum.EasingStyle.Sine)),
        SoundId = "rbxassetid://13060063674",
        Parent = game:GetService("SoundService"),
    }) :: Sound
end

--[[
    Plays the sound instance.

    @returns Future
]]
function Music:load()
    sound:Play()
    volume:set(1)

    return Future.new(function()
        task.wait(FADE)

        return
    end)
end

--[[
    Destroys the sound instance.

    @returns Future
]]
function Music:unload()
    volume:set(0)

    return Future.new(function()
        task.wait(FADE)

        sound:Destroy()

        return
    end)
end

return Music
