local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local GUI = require(ReplicatedFirst.UserInterface.Components.Base.GUI)
local NameLabel = require(script.Parent.NameLabel)
local RoleLabel = require(script.Parent.RoleLabel)

--[[
	The intro credits GUI.
	
	@returns ScreenGui
--]]
function CreditsGUI(): ScreenGui
    return GUI({
        [Fusion.Children] = {
            NameLabel(),
            RoleLabel(),
        },
    })
end

return CreditsGUI
