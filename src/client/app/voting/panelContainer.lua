local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.components.frame)
local list = require(script.Parent.Parent.components.list)
local optionsAction = require(script.Parent.Parent.actions.voting.options)
local panel = require(script.Parent.panel)
local stageAction = require(script.Parent.Parent.actions.voting.stage)
local types = require(ReplicatedStorage.types)

--[[
    Holds voting panels. 

	@returns Fusion.Component
--]]
local function panelContainer()
    local aspectRatio = Fusion.Computed(function()
        return if stageAction:get() == "map" then 1.5 else 1.1
    end)

    return frame({
        Size = UDim2.fromScale(1, 0.35),

        [Fusion.Children] = {
            list({
                Padding = UDim.new(0.015, 0),
                FillDirection = Enum.FillDirection.Horizontal,
            }),

            Fusion.ForPairs(optionsAction.value, function(id: number, option: types.votingOption)
                return id,
                    panel({
                        id = id,
                        data = option,
                        aspectRatio = aspectRatio,
                    })
            end, Fusion.cleanup),
        },
    }, {})
end

return panelContainer
