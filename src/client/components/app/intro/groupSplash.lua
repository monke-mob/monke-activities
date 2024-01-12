local ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(ReplicatedStorage.types)

local gif = require(script.Parent.Parent.components.gif)

--[[
	The group splash.

    @param {types.dictionaryAny} instanceProps [The instance props.]
	@returns Fusion.Component
--]]
local function groupSplash(instanceProps: types.dictionaryAny)
    return gif({
        wrapper = {
            Size = UDim2.fromScale(1, 0.3),
        },

        gif = instanceProps,
    }, {
        spriteSheet = "rbxassetid://13571354799",
        defaultImage = "rbxassetid://10810599234",
        frameRate = 20,
        frames = 80,
        rows = 9,
        columns = 9,
    })
end

return groupSplash
