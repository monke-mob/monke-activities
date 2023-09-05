--[[
	Combines two tables.

	@param {{ any }} table1 [The first table.]
	@param {{ any }} table2 [The second table.]
	@returns { any }
]]
local function concatTables(table1, table2)
	for index: any, value: any in pairs(table2) do
		-- If the value is nil there is no need to overwrite it.
		if value == nil then
			continue
		end

		table1[index] = value
	end

	return table1
end

return concatTables
