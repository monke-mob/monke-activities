local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local types = require(script.Parent.Parent.types)

--[[
	Combines two tables. This uses TableUtil.Assign and the entire reason that this is a wrapper is so that
    the type can be casted to types.dictionaryAny.

	@param {...} params [The params.]
	@returns types.dictionaryAny
]]
local function concatTables(...): types.dictionaryAny
    return TableUtil.Assign(...)
end

return concatTables
