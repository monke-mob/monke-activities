local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Spawn = require(ReplicatedStorage.Packages.Spawn)

local CreditsData = require(script.Data)
local CreditsGUI = require(script.UserInterface.GUI)
local CreditsValues = require(script.Values)

local Credits = {
    _gui = nil,
}

--[[
    Creates the GUI.

    @returns never
]]
function Credits:prepare()
    self._gui = CreditsGUI()
end

--[[
    Displays the credits.

    @returns never
]]
function Credits:load()
    Spawn(function()
        for index: number = 1, #CreditsData do
            CreditsValues.name:set(CreditsData[index][1])
            CreditsValues.role:set(CreditsData[index][2])
            CreditsValues._transparency:set(0)

            task.wait(CreditsValues.duration - 1.5)

            CreditsValues._transparency:set(1)

            task.wait(0.5)
        end
    end)
end

--[[
    Destroys the GUI.

    @returns never
]]
function Credits:unload()
    self._gui:Destroy()
end

return Credits
