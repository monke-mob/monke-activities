local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local mapService = Knit.CreateService({
    Name = "map",
})

return mapService
