local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CameraService = require(ReplicatedFirst.Services.Camera)
local CameraShaker = require(ReplicatedStorage.Packages.CameraShaker)
local Future = require(ReplicatedStorage.Packages.Future)
local SceneService = require(ReplicatedFirst.Services.Scene)

local Credits = require(script.Parent.Credits)
local CreditsData = require(script.Parent.Credits.Data)
local CreditsValues = require(script.Parent.Credits.Values)
local Doors = require(script.Doors)
local FloorNumber = require(script.FloorNumber)
local Music = require(script.Music)

local Elevator = {}

--[[
    Prepares the elevator components and camera for the scene.

    @returns never
]]
function Elevator:prepare()
    Music:prepare()
    Credits:prepare()
    Doors:prepare()
    FloorNumber:prepare()

    CameraService:setPosition(SceneService.map:FindFirstChild("Camera").CFrame)
    CameraService:toggleShaker(true)
    CameraService.shaker:ShakeSustain(CameraShaker.Presets.RoughDriving)
end

--[[
    Starts the credit user interface and handles the elevator effects.

    @returns Future
]]
function Elevator:load()
    Music:load():After(function()
        Credits:load()
    end)

    return Future.new(function()
        local creditsLength: number = #CreditsData * CreditsValues.duration

        for _ = 1, 8 do
            Doors.lightTween:play()
            FloorNumber.number:set(FloorNumber.number:get() + 1)

            task.wait(creditsLength / 8)
        end

        return
    end)
end

--[[
    Unloads the elevator components and stops the camera shaker.

    @returns Future
]]
function Elevator:unload()
    local musicFaded = Music:unload()
    local doorsOpened = Doors:unload()
    Credits:unload()

    CameraService.shaker:StopSustained(3)

    return Future.new(function()
        task.wait(3)

        CameraService:toggleShaker(false)

        musicFaded:Await()
        doorsOpened:Await()

        return
    end)
end

return Elevator
