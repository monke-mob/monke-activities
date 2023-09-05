local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")

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

return collisionService
