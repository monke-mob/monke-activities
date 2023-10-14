local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local collisionService = Knit.CreateService({
    Name = "collision",
})

--[[
	@returns never
]]
function collisionService:KnitStart()
    PhysicsService:RegisterCollisionGroup("npc")
    PhysicsService:RegisterCollisionGroup("player")

    PhysicsService:CollisionGroupSetCollidable("player", "player", false)
    PhysicsService:CollisionGroupSetCollidable("npc", "npc", false)
    PhysicsService:CollisionGroupSetCollidable("player", "npc", false)

    -- Get the players that could have already joined.
    for _index: number, player: Player in ipairs(Players:GetPlayers()) do
        self:_handlePlayer(player)
    end

    Players.PlayerAdded:Connect(function(...)
        self:_handlePlayer(...)
    end)
end

--[[
	Sets the collision group of a instance.
	
	@param {Instance} instance [The instance.]
	@param {string} group [The collision group name.]
	@returns never
]]
function collisionService:setInstanceGroup(instance: Instance, group: string)
    if instance:IsA("Model") then
        for _index: number, descendant: Instance in ipairs(instance:GetDescendants()) do
            if descendant:IsA("BasePart") == false then
                continue
            end

            (descendant :: BasePart).CollisionGroup = group
        end
    elseif instance:IsA("BasePart") then
        instance.CollisionGroup = group
    end
end

--[[
    Handles a player.

    @private
    @param {Player} player [The player.]
	@returns never
]]
function collisionService:_handlePlayer(player: Player)
    -- Get the current player character, if there is one.
    if player.Character then
        self:setInstanceGroup(player.Character, "player")
    end

    player.CharacterAdded:Connect(function(character: Model)
        self:setInstanceGroup(character, "player")
    end)
end

return collisionService
