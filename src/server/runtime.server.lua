local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServicesDeep(script.Parent.services)
Knit.Start()
    :andThen(function()
        Fluid.start()
    end)
    :catch(warn)
