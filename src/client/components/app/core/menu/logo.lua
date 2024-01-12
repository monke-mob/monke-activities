local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local LOGO = "rbxassetid://14827422191"

--[[
	Handles the game logo.
	
    @param {Fusion.Tween} transparency [Used to control the transparency of the logo.]
	@returns Fusion.Component
--]]
local function menu(transparency)
	return Fusion.New("ImageLabel")({
        ImageTransparency = Fusion.Computed(function()
            -- This expression converts the 0.8-1 range to a 0-1 range.
            return (transparency:get() - 0.8) / 0.2
        end),
        Image = LOGO,
        Size = UDim2.fromScale(1, 0.08),
        Position = UDim2.fromScale(0.5, 0.95),
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        ScaleType = Enum.ScaleType.Fit,
    })
end

return menu
