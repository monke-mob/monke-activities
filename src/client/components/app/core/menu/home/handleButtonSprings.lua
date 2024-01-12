local homeOpenAction = require(script.Parent.Parent.Parent.Parent.actions.menu.homeOpen)
local springsComponent = require(script.Parent.Parent.Parent.Parent.components.spring.springs)

local BUTTON_COUNT: number = 4

--[[
	Handles the menu button springs.

	@returns springsComponent.springs
--]]
local function handleButtonSprings(): springsComponent.springs
	local springs, updateSprings = springsComponent({
		Scale = 0.8,
		Transparency = 1,
	}, {
		count = BUTTON_COUNT,
		delay = 0.1,
		speed = 12,
		damping = 0.6,
	})

	homeOpenAction:connect(function(isOpen: boolean)
		updateSprings({
			Scale = if isOpen then 1 else 0.8,
			Transparency = if isOpen then 0 else 1,
		})
	end)

	return springs
end

return handleButtonSprings
