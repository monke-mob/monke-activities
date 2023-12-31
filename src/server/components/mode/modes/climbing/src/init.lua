local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Knit = require(ReplicatedStorage.Packages.Knit)

local config = require(script.Parent.config)
local freezePlayer = require(script.Parent.Parent.Parent.functions.freezePlayer)
local modeComponent = require(script.Parent.Parent)
local modeService

Knit:OnStart():andThen(function()
    modeService = Knit.GetService("mode")
end)

local class = {}
class.__index = class
setmetatable(class, modeComponent)

--[[
    Creates the mode.

    @constructor
    @param {modeComponent.players} players [The players.]
    @returns class
]]
function class.new(players: modeComponent.players)
    local baseClass = modeComponent.new(players, config)
    local mode = setmetatable(baseClass, class)
    mode._players = players
    mode._currentPlayer = nil
    mode._currentPlayerIndex = 0
    mode._cycle = 1

    -- Freeze all of the players to start with.
    for _index: number, player: number in pairs(players) do
        freezePlayer(player, true)
    end

    mode:_cycleToNextPlayer()

    return mode
end

--[[
    Cycles to the next players turn and if all players have went then it stops the round.

    @returns never
]]
function class:_cycleToNextPlayer()
    if self._currentPlayerIndex == #self._players then
        self._cycle += 1
        self._currentPlayerIndex = 0
        return
    end

    self._currentPlayerIndex += 1
    self:_setPlayerTurn(self._players[self._currentPlayerIndex])

    delay(config.mode.timeBetweenSwaps, function()
        self:_cycleToNextPlayer()
    end)
end

--[[
    Sets it to be a players turn.

    @param {number} player [The player.]
    @returns never
]]
function class:_setPlayerTurn(player: number)
    modeService.Client.event:FireAll("playerTurn", player)
    
    if self._currentPlayer ~= nil then
        self:_copyPlayerAtPosition(self._currentPlayer)
        freezePlayer(self._currentPlayer, true)
    end

    self._currentPlayer = player
    freezePlayer(player, false)
end

--[[
    Sets it to be a players turn.

    @param {number} player [The player.]
    @returns never
]]
function class:_copyPlayerAtPosition(userID: number)
    local player: Player = Players:GetPlayerByUserId(userID)
    local character: Model = player.Character or player.CharacterAdded:Wait()
    character.Archivable = true
    character = character:Clone()
    character.Parent = workspace
    character.Archivable = false
    self._janitor:Add(character)
    local characterRoot: Part = character:FindFirstChild("HumanoidRootPart") :: any
    characterRoot.Anchored = true

    for _index: number, instance: BasePart in pairs(character:GetChildren() :: any) do
        if instance.Name == "HumanoidRootPart" or instance:IsA("BasePart") == false then
            continue
        end

        instance.Transparency = 0.5
        instance.Color = Color3.fromRGB(255, 0, 0)
    end
end

return class
