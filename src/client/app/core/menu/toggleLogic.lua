local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Knit = require(ReplicatedStorage.Packages.Knit)

local mouseUnlockAction = require(script.Parent.Parent.Parent.actions.mouseUnlock)
local canToggleMenuAction = require(script.Parent.Parent.Parent.actions.menu.canToggle)
local menuOpenAction = require(script.Parent.Parent.Parent.actions.menu.open)

--[[
	Handles the toggle logic for the menu.

	@returns Fusion.Value
--]]
local function toggleLogic()
	local playerController = Knit.GetController("player")
	local menuVisible = Fusion.Value(false)
	local menuTransparency = Fusion.Value(1)

	UserInputService.InputBegan:Connect(function(input: InputObject)
		if input.KeyCode ~= Enum.KeyCode.Tab or canToggleMenuAction:get() == false then
			return
		end

		canToggleMenuAction:set(false)
		menuOpenAction:set(not menuOpenAction:get())

		local isOpen: boolean = menuOpenAction:get()

		-- Determine to toggle all screens or open the home screen.
		if isOpen then
			playerController:disableMovement()
			menuVisible:set(true)
		else
			playerController:enableMovement()
		end

		mouseUnlockAction:set(isOpen)
	end)

	return menuVisible, menuTransparency
end

return toggleLogic
