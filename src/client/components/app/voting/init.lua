local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.components.frame)
local gui = require(script.Parent.components.gui)
local list = require(script.Parent.components.list)
local panelContainer = require(script.panelContainer)
local title = require(script.title)
local votingAction = require(script.Parent.actions.voting.voting)

--[[
	Handles the voting ui.

	@returns Fusion.Component
--]]
local function voting()
    gui({
        Enabled = votingAction.value,
        DisplayOrder = 1,

        [Fusion.Children] = {
            frame({
                BackgroundTransparency = Fusion.Spring(
                    Fusion.Computed(function()
                        return if votingAction.value:get() then 0.8 else 1
                    end),
                    3,
                    1
                ),
                BackgroundColor3 = Color3.fromRGB(255, 255, 127),
                Size = UDim2.fromScale(1, 1),
                Visible = true,

                [Fusion.Children] = {
                    list({
                        Padding = UDim.new(0.04, 0),
                    }),

                    title(),
                    panelContainer(),
                },
            }, {}),
        },
    })
end

return voting
