local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local image = require(script.Parent.Parent.Parent.components.image)
local theme = require(script.Parent.Parent.Parent.theme)

--[[
	Handles the game logo.
	
    @param {Fusion.Tween} transparency [Used to control the transparency of the logo.]
	@returns Fusion.Component
--]]
local function menu(transparency)
    return image({
        ImageTransparency = Fusion.Computed(function()
            -- This expression converts the 0.8-1 range to a 0-1 range.
            return (transparency:get() - 0.8) / 0.2
        end),
        Image = theme.icons.logo,
        Size = UDim2.fromScale(1, 0.08),
        Position = UDim2.fromScale(0.5, 0.95),
        AnchorPoint = Vector2.new(0.5, 1),
        ScaleType = Enum.ScaleType.Fit,
    }, {
        constrained = false,
    })
end

return menu
