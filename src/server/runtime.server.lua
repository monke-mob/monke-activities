local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Echo = require(ReplicatedStorage.Packages.Echo)
local Knit = require(ReplicatedStorage.Packages.Knit)

Knit.AddServicesDeep(script.Parent.services)
Knit.Start()
    :andThen(function()
        Echo:start()
    end)
    :catch(warn)
