local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.components.frame)
local home = require(script.home)
local playerList = require(script.playerList)
local toggleLogic = require(script.toggleLogic)

--[[
	Handles the menu.
	
	@returns Fusion.Component
--]]
local function menu()
    local visible, transparency = toggleLogic()

    return frame({
        Visible = visible,
        BackgroundTransparency = transparency,
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 127),

        [Fusion.Children] = {
            home(),
            playerList(),
        },
    }, {})
end

return menu
