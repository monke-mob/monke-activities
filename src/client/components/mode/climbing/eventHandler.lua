local modeDataAction = require(script.Parent.Parent.Parent.Parent.app.actions.mode.data)

--[[
    Sets it to be a players turn.

    @param {number} player [The player.]
    @returns never
]]
local function setPlayerTurn(player: number)
    modeDataAction["player"] = player
end

return {
    playerTurn = setPlayerTurn,
}