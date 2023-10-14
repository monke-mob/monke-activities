local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local app = require(script.Parent.Parent.app)

local uiController = Knit.CreateController({
    Name = "ui",
})

--[[
	@returns never
--]]
function uiController:KnitInit()
    app()
end

return uiController
