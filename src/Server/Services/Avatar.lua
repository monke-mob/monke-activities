local ReplicatedStorage = game:GetService("ReplicatedStorage")

local AvatarAccessories: Folder = ReplicatedStorage.Assets.AvatarAccessories

type AccessoryMetaData = {
	accessory: Accessory,
	color: Color3,
}

type AvatarAccessory = Accessory | AccessoryMetaData

export type Avatar = {
	color: Color3,
	accessories: { AvatarAccessory },
}

local AvatarService = {
    DEFAULT_AVATAR = {
        color = Color3.fromRGB(255, 255, 255),
        accessories = {},
    },

    accessories = {},
}

for _, groupFolder: Folder in ipairs(AvatarAccessories:GetChildren() :: {}) do
    local group: string = groupFolder.Name
    AvatarService.accessories[group] = {}

    for _, accessory: Accessory in ipairs(groupFolder:GetChildren() :: {}) do
        table.insert(AvatarService.accessories[group], accessory)
    end
end

--[[
    Sets a character transparency.

    @apply {Model} character [The character.]
	@apply {number} transparency [The transparency.]
	@returns never
--]]
function AvatarService:setTransparency(character: Model, transparency: number)
	for _, instance: Instance in ipairs(character:GetDescendants()) do
		if not instance:IsA("BasePart") or instance.Name == "HumanoidRootPart" then
			continue
		end

		instance.Transparency = transparency
	end
end

--[[
    Applies a avatar to a character.

    @apply {Model} character [The character.]
    @apply {Avatar} avatar [The avatar data.]
    @returns never
]]
function AvatarService:apply(character: Model, avatar: Avatar)
    self:_applyColors(character, avatar.color)
	self:_applyAccessories(character, avatar.accessories)
end

--[[
	Applies the avatar accessories to a character. Gives them a random color if a accessory color is not given.

	@private
    @apply {Model} character [The character.]
	@param {{ AvatarAccessory }} accessories [The accessories.]
	@returns never
]]
function AvatarService:_applyAccessories(character: Model, accessories: { AvatarAccessory })
	local humanoid: Humanoid = character:FindFirstChildOfClass("Humanoid") :: Humanoid

	for _, accessoryData: AvatarAccessory in ipairs(accessories) do
		if accessoryData == nil then
			continue
		end

		local accessory: Accessory
		local accessoryColor: Color3

		if typeof(accessoryData) == "table" then
			accessory = accessoryData.accessory
			accessoryColor = accessoryData.color
		else
			accessory = accessoryData
			accessoryColor = self:randomColor()
		end

		accessory = accessory:Clone();
		-- Type casting these fixes a few type errors.
		((accessory :: any).Handle :: BasePart).Color = accessoryColor
		humanoid:AddAccessory(accessory)
	end
end

--[[
	Applies a color to a character.

	@private
	@param {Model} character [The character to apply the accessories to.]
	@param {Color3} color [The avatar color.]
	@returns never
]]
function AvatarService:_applyColors(character: Model, color: Color3)
	local characterBodyColors: BodyColors = character:FindFirstChildOfClass("BodyColors") :: BodyColors
	characterBodyColors.HeadColor3 = color
	characterBodyColors.LeftArmColor3 = color
	characterBodyColors.LeftLegColor3 = color
	characterBodyColors.RightArmColor3 = color
	characterBodyColors.RightLegColor3 = color
	characterBodyColors.TorsoColor3 = color
end

return AvatarService
