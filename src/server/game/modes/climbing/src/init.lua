local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local config = require(script.Parent.config)
local freezePlayer = require(script.Parent.Parent.Parent.Parent.components.mode.functions.freezePlayer)
local modeComponent = require(script.Parent.Parent.Parent.Parent.components.mode)
local teleportPlayer = require(script.Parent.Parent.Parent.Parent.components.mode.functions.teleportPlayer)
local modeService

Knit.OnStart():andThen(function()
    modeService = Knit.GetService("mode")
end)

--[[
    The class for the climbing mode.

    @class
    @public
    @extends modeComponent
]]
local class = {}
class.__index = class
setmetatable(class, modeComponent)

export type class = modeComponent.class & {
    _players: number,
    _currentPlayer: number,
    _currentPlayerIndex: number,
    _cycle: number,
    _spawn: CFrame,
    _cycleToNextPlayer: () -> never,
    _setPlayerTurn: () -> never,
    _calculatePlayerScore: () -> never,
    _copyCharacterAtPosition: () -> never,
}

--[[
    Creates the mode.

    @constructor
    @param {modeComponent.players} players [The players involved in the round.]
    @returns class
]]
function class.new(players: modeComponent.players): class
    local baseClass = modeComponent.new(players, config)
    local self = setmetatable(baseClass, class)
    self._players = players
    self._currentPlayer = nil
    self._currentPlayerIndex = 0
    self._cycle = 1
    self._spawn = baseClass._map:FindFirstChild("spawn").CFrame

    -- Freeze all of the players to start with.
    for _index: number, player: number in pairs(players) do
        freezePlayer(player, true)
    end

    self._janitor:Add(modeService.Client.event:Connect(function(player: Player, event: string, ...)
        if event == "getClimbable" then
            modeService.Client.event:Fire(player, "getClimbable", self._map:FindFirstChild("climbable"))
        end
    end))

    self:_cycleToNextPlayer()

    return self
end

--[[
    Cycles to the next players turn and if all players have went then it stops the round.

    @private
    @returns never
]]
function class:_cycleToNextPlayer()
    if self._currentPlayer ~= nil then
        local player: Player = Players:GetPlayerByUserId(self._currentPlayer)
        local character: Model = player.Character or player.CharacterAdded:Wait()

        local score: number = self:_calculatePlayerScore(character)
        self.scorePlugin:incrementScore(self._currentPlayer, score)
    end

    if self._cycle >= config.mode.attemptsPerPlayer and self._currentPlayerIndex == #self._players then
        self.endConditionPlugin:stop()
        return
    end

    if self._currentPlayerIndex == #self._players then
        self._cycle += 1
        self._currentPlayerIndex = 0
    end

    self._currentPlayerIndex += 1
    self:_setPlayerTurn(self._players[self._currentPlayerIndex])

    delay(config.mode.timeBetweenSwaps, function()
        self:_cycleToNextPlayer()
    end)
end

--[[
    Sets it to be a players turn.

    @private
    @param {number} userID [The ID of the player.]
    @returns never
]]
function class:_setPlayerTurn(userID: number)
    if self._currentPlayer ~= nil then
        local currentPlayer: number = self._currentPlayer
        local player: Player = Players:GetPlayerByUserId(currentPlayer)
        local character: Model = player.Character or player.CharacterAdded:Wait()

        self:_copyCharacterAtPosition(character)
        freezePlayer(currentPlayer, true)
    end

    self._currentPlayer = userID
    freezePlayer(userID, false)
    teleportPlayer(userID, self._spawn)

    -- TEMP
    local player: Player = Players:GetPlayerByUserId(userID)
    local character: Model = player.Character or player.CharacterAdded:Wait();
    (character:FindFirstChild("HumanoidRootPart") :: BasePart):SetNetworkOwner(player)

    modeService.Client.event:FireAll("setPlayerTurn", userID)
end

--[[
    Calculates a players score based on their position.

    @private
    @param {Model} character [The character.]
    @returns number
]]
function class:_calculatePlayerScore(character: Model): number
    local characterRoot: Part = character:FindFirstChild("HumanoidRootPart") :: any
    local endY: number = characterRoot.Position.Y
    local startY: number = self._spawn.Y
    return config.mode.studScoreModifier * (endY - startY)
end

--[[
    Copies a players character and sets it to be semi transparent and red.

    @private
    @param {Model} character [The character.]
    @returns never
]]
function class:_copyCharacterAtPosition(character: Model)
    character.Archivable = true
    character = character:Clone()
    character.Parent = workspace
    character.Archivable = false
    self._janitor:Add(character)

    local characterRoot: Part = character:FindFirstChild("HumanoidRootPart") :: any
    characterRoot.Anchored = true

    for _index: number, instance: Instance in pairs(character:GetChildren() :: any) do
        if
            instance.Name == "HumanoidRootPart"
            or (instance:IsA("BasePart") == false and instance:IsA("Decal") == false)
        then
            continue
        end

        (instance :: any).Transparency = 0.5;
        (instance :: any).Color = Color3.fromRGB(255, 0, 0)
    end
end

return class
