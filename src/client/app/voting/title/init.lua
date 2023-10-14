local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.components.frame)
local stage = require(script.timer)
local timer = require(script.timer)

--[[
    The title container. Holds the title and timer labels.
	
	@returns Fusion.Component
--]]
local function title()
    return frame({
        Size = UDim2.fromScale(1, 0.135),

        [Fusion.Children] = {
            stage(),
            timer(),
        },
    }, {})
end

return title
