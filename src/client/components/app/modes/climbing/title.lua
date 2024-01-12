local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local modeAction = require(script.Parent.Parent.Parent.actions.mode)
local modeDataAction = require(script.Parent.Parent.Parent.actions.mode.data)
local strokeLabel = require(script.Parent.Parent.Parent.components.label.stroke)

--[[
    The timer label.
	
	@returns Fusion.Component
--]]
local function timer()
    return strokeLabel({
        Text = Fusion.Computed(function()
            local playerName: string = ""

            if modeAction.value:get() == "climbing" then
                playerName = Players:GetPlayerByUserId(modeDataAction.player:get())
            end

            return playerName
        end),
        Position = UDim2.fromScale(0, 0.1),
        Size = UDim2.fromScale(1, 0.05),
        TextScaled = true,
    })
end

return timer
