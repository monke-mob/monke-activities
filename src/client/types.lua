local ReplicatedStorage = game:GetService("ReplicatedStorage")

local types = require(ReplicatedStorage.types)

export type votingOption = {
    name: string,
    description: string,
    teamType: types.teamType,
}

return nil
