local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

export type config = {
	speed: number,
	damping: number,
}

export type targets = types.dictionaryStringAny

export type spring = types.dictionaryStringAny

--[[
	Creates a `Fusion.Value` object for each index
	in the `targets` array and returns the array of values.

	@param {dictionaryStringAny} targets [The dictionary to create the values from.]
	@returns { [string]: Fusion.Value }
--]]
local function createValuesFromTargets(targets: targets): types.dictionaryStringAny
	local values: types.dictionaryStringAny = {}

	for property: string, value: any in pairs(targets) do
		values[property] = Fusion.Value(value)
	end

	return values
end

--[[
	Creates a `Fusion.Spring` object for each index
	in the `targets` array and returns the array of strings.

	@param {dictionaryStringAny} targets [The dictionary to create the springs from.]
	@returns spring
--]]
local function createSpringFromValues(values: types.dictionaryStringAny, config: config): spring
	local springs = {}

	for property: string, value: any in pairs(values) do
		springs[property] = Fusion.Spring(value, config.speed, config.damping)
	end

	return springs
end

export type update = (newTargets: types.dictionaryStringAny) -> never

--[[
	Creates a spring using the `Fusion.Spring` and `Fusion.Value` objects.
	This spring supports multiple values unlike a normal `Fusion.Spring` object.

	@param {targets} targets [The target values.]
	@param {config} config [The spring config.]
	@returns spring, update
--]]
local function springComponent(targets: targets, config: config): (spring, update)
	local targetValues = createValuesFromTargets(targets)
	local spring = createSpringFromValues(targetValues, config)

	--[[
		Updates the target values.
		
		@param {targets} newTargets [The new target values.]
		@returns never
	--]]
	local function update(newTargets: targets)
		for property: string, value: any in pairs(newTargets) do
			targetValues[property]:set(value)
		end
	end

	return spring, update
end

return springComponent
