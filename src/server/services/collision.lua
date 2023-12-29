local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local COLLISION_GROUPS = require(script.Parent.Parent.constants.COLLISION_GROUPS)

local collisionService = Knit.CreateService({
    Name = "collision",
})

--[[
	@returns never
]]
function collisionService:KnitStart()
    for _index: string, group: string in pairs(COLLISION_GROUPS) do
        PhysicsService:RegisterCollisionGroup(group)
    end

    self:setGroupsCollidable("player", "player", false)
    self:setGroupsCollidable("npc", "npc", false)
    self:setGroupsCollidable("player", "npc", false)

    -- Get the players that could have already joined.
    for _index: number, player: Player in ipairs(Players:GetPlayers()) do
        self:_handlePlayer(player)
    end

    Players.PlayerAdded:Connect(function(...)
        self:_handlePlayer(...)
    end)
end

--[[
	Sets the collideability of two collision groups.
	
	@param {string} group1 [The first collision group.]
    @param {string} group2 [The second collision group.]
	@returns never
]]
function collisionService:setGroupsCollidable(group1: string, group2: string, collideable: boolean)
    PhysicsService:CollisionGroupSetCollidable(COLLISION_GROUPS[group1], COLLISION_GROUPS[group2], collideable)
end

--[[
	Sets the collision group for an instance.
	
	@param {Instance} instance [The instance.]
	@param {string} group [The collision group.]
	@returns never
]]
function collisionService:setInstanceGroup(instance: Instance, group: string)
    group = COLLISION_GROUPS[group]

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
    Handles a player collisions.

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
