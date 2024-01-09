local VOTING = require(script.Parent.VOTING)

return {
    minimumPlayers = 2,
    -- Intermission time should be at least the VOTING.timePerStage * 2, because there are two voting stages
    -- and time needs to be allocated for them during the intermission.
    intermissionTime = (VOTING.timePerStage * 2) + 15 --[[Change this number.]],
}
