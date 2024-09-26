local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Types = require(ReplicatedStorage.Types)

--[[
	Adds an instance to the instance properties child entry.

	@param {Types.Dictionary} properties [The instance properties.]
	@param {Instance} instance [The instance add.]
	@returns never
--]]
function addInstanceToChildren(properties: Types.Dictionary, instance: Instance)
    if properties[Fusion.Children] == nil then
        properties[Fusion.Children] = {}
    end

    table.insert(properties[Fusion.Children], instance)
end

return addInstanceToChildren
