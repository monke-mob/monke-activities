local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local DISABLE_MOVEMENT_ACTION = "disableMovement"

local playerController = Knit.CreateController({
	Name = "player",
})

--[[
    Enables player movement.

	@returns never
--]]
function playerController:enableMovement()
	ContextActionService:UnbindAction(DISABLE_MOVEMENT_ACTION)
end

--[[
    Disables player movement.

	@returns never
--]]
function playerController:disableMovement()
	ContextActionService:BindAction(DISABLE_MOVEMENT_ACTION, function()
		return Enum.ContextActionResult.Sink
	end, false, unpack(Enum.PlayerActions:GetEnumItems()))
end

--[[
    Sets the player character transparency.

    @param {number} transparency [The player transparency.]
	@returns never
--]]
function playerController:setTransparency(transparency: number)
	for _index: number, instance: Instance in ipairs(Players.LocalPlayer.Character:GetDescendants()) do
		if instance:IsA("BasePart") and instance.Name ~= "HumanoidRootPart" then
			instance.Transparency = transparency
		end
	end
end

return playerController
