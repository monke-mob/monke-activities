local action = require(script.Parent.Parent)

local canToggleMenuAction = require(script.Parent.canToggle)
local homeOpenAction = require(script.Parent.homeOpen)
local playerListOpenAction = require(script.Parent.playerListOpen)

export type subMenu = "home" | "playerList" | ""

local subMenuActionMap: { [subMenu]: action.action } = {
	home = homeOpenAction,
	playerList = playerListOpenAction,
}
local currentSubMenu: subMenu

--[[
	Acts as a middle man between the sub menus and
	other menu ui.

	@interface
]]
local subMenuAction = {}
subMenuAction.transitionTime = 1

--[[
	Swaps to the requested sub menu using transitions.

	@param {subMenu} newSubMenu [The sub menu to transition to.]
	@returns never
--]]
function subMenuAction.swap(newSubMenu: subMenu)
	-- Dont update if we cant toggle the menu or
	-- if the current menu sub menu is the requested
	-- sub menu.
	if canToggleMenuAction:get() == false or newSubMenu == currentSubMenu then
		return
	end

	canToggleMenuAction:set(false)
	subMenuActionMap[currentSubMenu]:set(false)

	delay(subMenuAction.transitionTime, function()
		currentSubMenu = newSubMenu
		subMenuActionMap[newSubMenu]:set(true)

		delay(subMenuAction.transitionTime, function()
			canToggleMenuAction:set(true)
		end)
	end)
end

--[[
	Toggles a sub menu.

	@param {subMenu} subMenu [The sub menu.]
	@returns never
--]]
function subMenuAction.set(subMenu: subMenu)
	-- Dont update if the current sub menu is the
	-- requested sub menu.
	if subMenu == currentSubMenu then
		return
	end

	currentSubMenu = subMenu
	subMenuActionMap[subMenu]:set(true)
end

--[[
	Closes all the sub menus.

	@returns never
--]]
function subMenuAction.closeAll()
	currentSubMenu = ""

	-- Have to give the `subMenuActionMap` variable the
	-- type of any or else it will cause an type error.
	for _subMenu: subMenu, subMenuAction: action.action in pairs(subMenuActionMap :: any) do
		subMenuAction:set(false)
	end
end

return subMenuAction
