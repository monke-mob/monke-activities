local playerListAction = require(script.Parent.Parent.Parent.Parent.Parent.actions.menu.playerList)
local springsComponent = require(script.Parent.Parent.Parent.Parent.Parent.components.spring.springs)

local cardCount: number = 16

--[[
	Handles the card springs.

	@returns springsComponent.springs
--]]
local function handleCardSprings(): springsComponent.springs
    local springs, updateSprings = springsComponent({
        Scale = 0.8,
        Transparency = 1,
    }, {
        count = cardCount,
        delay = 0.05,
        speed = 12,
        damping = 0.8,
    })

    playerListAction.open:connect(function(isOpen: boolean)
        updateSprings({
            Scale = if isOpen then 1 else 0.8,
            Transparency = if isOpen then 0 else 1,
        })
    end)

    return springs
end

return handleCardSprings
