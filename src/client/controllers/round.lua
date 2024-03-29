local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local playerCountAction = require(script.Parent.Parent.components.app.actions.round.playerCount)
local timerAction = require(script.Parent.Parent.components.app.actions.round.timer)
local updateTimeAction = require(script.Parent.Parent.functions.updateTimeAction)
local roundInterface

local roundController = Knit.CreateController({
    Name = "round",
})

--[[
    Sets up round data.
    
	@returns never
--]]
function roundController:KnitStart()
    roundInterface = Knit.GetService("roundInterface")

    roundInterface.playerCount:Observe(function(newPlayerCount: number)
        playerCountAction:set(newPlayerCount)
    end)

    roundInterface.timer:Observe(function(newTime: number)
        updateTimeAction(timerAction, newTime)
    end)
end

return roundController
