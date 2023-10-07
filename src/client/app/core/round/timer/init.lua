local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.components.frame)
local timerLabel = require(script.timerLabel)

--[[
	Handles the round / intermission timer.
	
	@returns Fusion.Component
--]]
local function timer()
	return frame({
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromScale(0.35, 0.86),
		BackgroundTransparency = 0,

		[Fusion.Children] = {
			Fusion.New("UIGradient")({
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromHex("#ffd160")),
					ColorSequenceKeypoint.new(1, Color3.fromHex("#ffad00")),
				}),
				Rotation = 90,
			}),

			timerLabel(),
		},
	}, {
		cornerRadius = UDim.new(0, 20),
	})
end

return timer
