local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local SceneService = require(ReplicatedFirst.Services.Scene)

local FloorNumber = {
    number = Fusion.Value(0),
}

--[[
    Hydrates the floor number label.

    @returns never
]]
function FloorNumber:prepare()
    Fusion.Hydrate(
        SceneService.map
            :FindFirstChild("Elevator")
            :FindFirstChild("FloorNumber")
            :FindFirstChild("GUI")
            :FindFirstChild("Number")
    )({
        Text = self.number,
    })
end

return FloorNumber
