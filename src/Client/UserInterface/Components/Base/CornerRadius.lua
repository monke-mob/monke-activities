local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

local concatTables = require(script.Parent.Parent.Parent.Functions.concatTables)

--[[
	The base class for a `UICorner`.
	
	@param {Types.Dictionary} instanceProperties [The properties to apply to the instance.]
	@returns UICorner
--]]
function CornerRadius(instanceProperties: Types.Dictionary): UICorner
    return Fusion.New("UICorner")(concatTables({
        CornerRadius = 5,
    }, instanceProperties)) :: UICorner
end

return CornerRadius
