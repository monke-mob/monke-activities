local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local types = require(ReplicatedStorage.types)

local lightingService = Knit.CreateService({
    Name = "lighting",
    Client = {
        lighting = Knit.CreateProperty(),
    },
})

--[[
    Changes the lighting config.

    @param {types.lightingConfig} config [The lighting config.]
    @returns never
]]
function lightingService:changeLighting(config: types.lightingConfig)
    self.Client.lighting:Set(config)
end

return lightingService
