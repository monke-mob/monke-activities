local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Knit = require(ReplicatedStorage.Packages.Knit)

local canToggleMenuAction = require(script.Parent.Parent.Parent.actions.menu.canToggle)
local menuOpenAction = require(script.Parent.Parent.Parent.actions.menu.open)
local mouseUnlockAction = require(script.Parent.Parent.Parent.actions.mouseUnlock)
local subMenuAction = require(script.Parent.Parent.Parent.actions.menu.subMenu)

local lightingController = Knit.GetController("lighting")
local playerController = Knit.GetController("player")
local visible = Fusion.Value(false)
local transparency = Fusion.Value(1)
local transparencyTween = Fusion.Tween(transparency, TweenInfo.new(1, Enum.EasingStyle.Sine))

local function toggle()
    local isOpen: boolean = menuOpenAction:get()
    mouseUnlockAction:set(isOpen)
    transparency:set(if isOpen then 0.8 else 1)

    -- Determine to toggle all screens or open the home screen.
    if isOpen then
        visible:set(true)
        subMenuAction.set("home")
        playerController:disableMovement()
    else
        subMenuAction.closeAll()
        playerController:enableMovement()
        lightingController:toggleTweenable("ExposureCompensation", true)
    end

    lightingController:tweenValue("blur", "Size", if isOpen then 56 else 0)
    lightingController:tweenValue("default", "ExposureCompensation", 1, not isOpen, function()
        canToggleMenuAction:set(true)

        -- Whenever this tween finishes it should mean
        -- that the menu is closed / opened, so if we are closing
        -- the menu then make it not visible.
        if isOpen == false then
            visible:set(false)
        end
    end)

    -- Setting this before we started the tweens would
    -- cause the tweens not to work, so we do it after.
    if isOpen == true then
        lightingController:toggleTweenable("ExposureCompensation", false)
    end
end

--[[
	Handles the toggle logic for the menu.

	@returns Fusion.Value, Fusion.Tween
--]]
local function toggleLogic()
    lightingController = Knit.GetController("lighting")
    playerController = Knit.GetController("player")

    menuOpenAction:connect(toggle)

    UserInputService.InputBegan:Connect(function(input: InputObject)
        if input.KeyCode ~= Enum.KeyCode.Tab or canToggleMenuAction:get() == false then
            return
        end

        canToggleMenuAction:set(false)
        menuOpenAction:set(not menuOpenAction:get())
    end)

    return visible, transparencyTween
end

return toggleLogic
