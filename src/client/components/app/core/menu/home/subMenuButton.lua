local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local BUTTON_GRADIENT: ColorSequence = ColorSequence.new(Color3.fromHex("#060d15"), Color3.fromHex("#02080e"))

local image = require(script.Parent.Parent.Parent.Parent.components.image)
local labeledExternalSpringButton =
    require(script.Parent.Parent.Parent.Parent.components.button.animated.labeledExternalSpring)
local list = require(script.Parent.Parent.Parent.Parent.components.list)
local spring = require(script.Parent.Parent.Parent.Parent.components.spring)
local subMenuAction = require(script.Parent.Parent.Parent.Parent.actions.menu.subMenu)
local theme = require(script.Parent.Parent.Parent.Parent.theme)

type componentProps = {
    spring: spring.spring,
    text: string,
    subMenu: subMenuAction.subMenu,
}

--[[
	Extends a `labeledExternalSpringButton` component. Adds the functionality
	to swap sub menus.
	
	@extends labeledExternalSpringButton
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component
--]]
local function subMenuButton(componentProps: componentProps)
    return labeledExternalSpringButton({
        wrapper = {
            Size = UDim2.fromScale(1, 0.076),
        },

        button = {
            [Fusion.OnEvent("Activated")] = function()
                subMenuAction.swap(componentProps.subMenu)
            end,
        },

        preLabelChildren = {
            list({
                FillDirection = Enum.FillDirection.Horizontal,
            }),

            Fusion.New("UIPadding")({
                PaddingBottom = UDim.new(0, 12),
                PaddingTop = UDim.new(0, 12),
                PaddingLeft = UDim.new(0, 20),
                PaddingRight = UDim.new(0, 20),
            }),

            image({
                Image = theme.icons[componentProps.subMenu],
                ImageTransparency = componentProps.spring.Transparency,
                Size = UDim2.fromScale(0, 0.9),
            }, {
                constrained = true,
            }),
        },

        label = {
            Text = componentProps.text,
        },
    }, {
        spring = componentProps.spring,
        gradient = BUTTON_GRADIENT,
    })
end

return subMenuButton
