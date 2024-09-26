local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Types = require(ReplicatedStorage.Types)

--[[
	Combines two tables.
    
    NOTE: This is a wrapper around `TableUtil.Assign` so that the type can be casted to `Types.Dictionary`.

	@param {...} ... [The tables to combine.]
	@returns Types.Dictionary
]]
function concatTables(...): Types.Dictionary
    return TableUtil.Assign(...)
end

return concatTables
