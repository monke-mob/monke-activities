local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fluid = require(ReplicatedStorage.Packages.Fluid)
local Knit = require(ReplicatedStorage.Packages.Knit)
local types = require(ReplicatedStorage.types)

type dataIndex = "default" | "atmosphere" | "bloom" | "blur"

local lightingConfigs = script.Parent.Parent:WaitForChild("data"):WaitForChild("lighting")
local atmosphere: Atmosphere = Lighting:WaitForChild("Atmosphere")
local bloomEffect: BloomEffect = Lighting:WaitForChild("Bloom")
local blurEffect: BlurEffect = Lighting:WaitForChild("Blur")

local lightingController = Knit.CreateController({
    Name = "lighting",
    _ready = false,
    _current = "",
    _configs = {},
    _tweens = {},
    _tweenable = {},
})

--[[
	Configures lighting congig.

	@returns never
--]]
function lightingController:KnitStart()
    for _index: number, config: ModuleScript in ipairs(lightingConfigs:GetChildren()) do
        self._configs[config.Name] = require(config)
    end

    self._ready = true
    self:setConfig("default")
end

--[[
	Sets the lighting config.

	@param {string} configName [The name of the config.]
	@returns never
--]]
function lightingController:setConfig(configName: string)
    repeat
        task.wait()
    until self._ready

    self._current = configName

    local config = self._configs[configName]

    for dataIndex: dataIndex, data: types.dictionaryStringAny in pairs(config) do
        self:_updateInstanceWithDataFromConfig(dataIndex, data)
    end
end

--[[
	Toggles if a value is tweenable. Used in the `tweenValue` method.

	@param {string} valueName [The value name.]
	@param {boolean} tweenable [Is this value tweenable?]
	@returns never
--]]
function lightingController:toggleTweenable(valueName: string, tweenable: boolean)
    self._tweenable[valueName] = tweenable
end

--[[
	Tweens a value for a lighting instance.
	This function is used because it allows the calling
	function to describe if the tween should reset to the current
	config value.

	@param {dataIndex} dataIndex [The instance to tween.]
	@param {string} valueName [The name of the value to tween.]
	@param {any} value [The value to tween to. Disregard if `resetValueToConfig` is true.]
	@param {boolean?} resetValueToConfig [Is the target value the config value?]
	@param {((...any) -> ())?} callback [The callback for when the tween is finished.]
	@returns never
--]]
function lightingController:tweenValue(
    dataIndex: dataIndex,
    valueName: string,
    value: any,
    resetValueToConfig: boolean?,
    callback: ((...any) -> ())?
)
    if self._tweenable[valueName] == false then
        return
    end

    local instance

    if dataIndex == "default" then
        instance = Lighting
    elseif dataIndex == "atmosphere" then
        instance = atmosphere
    elseif dataIndex == "bloom" then
        instance = bloomEffect
    elseif dataIndex == "blur" then
        instance = blurEffect
    end

    local tween = Fluid:create(instance, {
        duration = 1,
        easing = "InOutSine",
        destroyOnComplete = true,
    }, {
        [valueName] = if resetValueToConfig then self._configs[self._current][dataIndex][valueName] else value,
    })
    self._tweens[valueName] = tween
    tween.completed:Connect(function()
        self._tweens[valueName] = nil

        if callback ~= nil then
            callback()
        end
    end)
    tween:play()
end

--[[
	Updates a instance value with the config value.

	@private
	@param [dataIndex] dataIndex [The instance to update.]
	@param {dictionaryStringAny} data [The values.]
	@returns never
--]]
function lightingController:_updateInstanceWithDataFromConfig(dataIndex: dataIndex, data: types.dictionaryStringAny)
    for index: string, value: any in pairs(data) do
        -- If this value is already being tweened then we do not
        -- want to interfer with the current tween.
        if self._tweens[index] ~= nil then
            continue
        end

        self:tweenValue(dataIndex, index, value)
    end
end

return lightingController
