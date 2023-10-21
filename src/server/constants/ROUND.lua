local ReplicatedStorage = game:GetService("ReplicatedStorage")

local VOTING = require(ReplicatedStorage.constants.VOTING)

return {
    minimumPlayers = 1,
    -- Intermission time should be at least the VOTING.timePerStage * 2, because there are two voting stages
    -- and time needs to be allocated for them during the intermission.
    intermissionTime = (VOTING.timePerStage * 2) + 10 --[[Change this number.]],
}
