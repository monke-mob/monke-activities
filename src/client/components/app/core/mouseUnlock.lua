local button = require(script.Parent.Parent.components.button)
local mouseUnlockAction = require(script.Parent.Parent.actions.mouseUnlock)

--[[
	Handles unlocking the player mouse while
	they are in first person.

	@returns Fusion.Component
--]]
local function mouseUnlock()
    return button({
        Visible = mouseUnlockAction.value,
        Modal = true,
        ZIndex = 0,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
    }, {})
end

return mouseUnlock
