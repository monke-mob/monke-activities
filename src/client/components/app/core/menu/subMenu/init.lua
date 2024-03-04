local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local frame = require(script.Parent.Parent.Parent.components.frame)
local header = require(script.header)
local subMenuAction = require(script.Parent.Parent.Parent.actions.menu.subMenu)

--[[
	Handles a sub menu.

    @param {types.dictionaryAny} instanceProps [The instance props.]
	@param {header.componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function subMenu(instanceProps: types.dictionaryAny, componentProps: header.componentProps)
    local subMenuVisible = Fusion.Value(false)

    -- Connect to the action so that whenever it is toggled
    -- we can toggle the visibility of the sub menu frame.
    componentProps.action:connect(function(isOpen: boolean)
        if isOpen then
            subMenuVisible:set(true)
        else
            delay(subMenuAction.transitionTime, function()
                subMenuVisible:set(false)
            end)
        end
    end)

    return frame({
        Visible = subMenuVisible,
        Size = UDim2.fromScale(1, 1),

        [Fusion.Children] = {
            header(componentProps),

            frame(
                concatTables({
                    Size = UDim2.fromScale(1, 0.6),
                    Position = UDim2.fromScale(0, 0.3),
                }, instanceProps),
                {}
            ),
        },
    }, {})
end

return subMenu
