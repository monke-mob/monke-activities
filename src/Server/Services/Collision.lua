local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local COLLISION_GROUPS = require(ReplicatedStorage.Constants.COLLISION_GROUPS)

for _, group: string in pairs(COLLISION_GROUPS) do
    PhysicsService:RegisterCollisionGroup(group)
end

local CollisionService = {}

--[[
	Sets the collideability of two collision groups.
	
	@param {string} group1 [The first collision group.]
    @param {string} group2 [The second collision group.]
	@returns never
]]
function CollisionService:setCollidable(group1: string, group2: string, collideable: boolean)
    PhysicsService:CollisionGroupSetCollidable(group1, group2, collideable)
end

--[[
	Sets the collision group for an instance.
	
	@param {Instance} instance [The instance.]
	@param {string} group [The collision group.]
	@returns never
]]
function CollisionService:setInstanceGroup(instance: Instance, group: string)
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

CollisionService:setCollidable(COLLISION_GROUPS.players, COLLISION_GROUPS.players, false)
CollisionService:setCollidable(COLLISION_GROUPS.npcs, COLLISION_GROUPS.npcs, false)
CollisionService:setCollidable(COLLISION_GROUPS.players, COLLISION_GROUPS.npcs, false)

return CollisionService
