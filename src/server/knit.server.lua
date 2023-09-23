local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
Knit.AddServicesDeep(script.Parent.services)
Knit.Start():catch(warn)
