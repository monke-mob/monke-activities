local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

--[[
	Adds an instance to the children array. If a child array is not
	available it will create one.

	@param {dictionaryAny} props [The props to add to.]
	@param {Fusion.Component} instance [The instance add.]
	@returns never
--]]
local function addInstanceToChildren(props: types.dictionaryAny, instance)
    if props[Fusion.Children] == nil then
        props[Fusion.Children] = {}
    end

    table.insert(props[Fusion.Children], instance)
end

return addInstanceToChildren
