local RunService = game:GetService("RunService")

--[[
    Gets the value of the `NumberSequence` at a specific time.

    @param {NumberSequence} sequence [The number sequence.]
    @param {number} sequenceProgress [The progress of the sequence.]
    @returns number
]]
function evaluateNumberSequence(sequence: NumberSequence, sequenceProgress: number): number
    if sequenceProgress == 0 then
        return sequence.Keypoints[1].Value
    elseif sequenceProgress == 1 then
        return sequence.Keypoints[#sequence.Keypoints].Value
    end

    for index: number = 1, #sequence.Keypoints - 1 do
        local currentPoint = sequence.Keypoints[index]
        local nextPoint = sequence.Keypoints[index + 1]

        if sequenceProgress >= currentPoint.Time and sequenceProgress < nextPoint.Time then
            local alpha: number = (sequenceProgress - currentPoint.Time) / (nextPoint.Time - currentPoint.Time)
            return currentPoint.Value + (nextPoint.Value - currentPoint.Value) * alpha
        end
    end

    return 0
end

--[[
    A component for flickering lights.

    @class
]]
local FlickeringLight = {}
FlickeringLight.__index = FlickeringLight

--[[
    Creates a flickering light.

    @constructor
    @param {BasePart} bulb [The bulb for the flickering light.]
    @returns FlickeringLight
]]
function FlickeringLight.new(bulb: BasePart)
    local light: Light = bulb:FindFirstChildWhichIsA("Light") :: Light
    local beam: Beam = bulb:FindFirstChildOfClass("Beam") :: Beam

    local self = setmetatable({
        _bulb = bulb,
        _originalBulbColor = bulb.Color,
        _light = light,
        _originalLightBrightness = light.Brightness,
        _beam = beam,
        _originalBeamBrightness = beam.Brightness,
        _duration = bulb:GetAttribute("duration"),
        _brightnessCurve = bulb:GetAttribute("brightnessCurve"),
        _updater = nil,
    }, FlickeringLight)

    self._updater = RunService.Heartbeat:Connect(function()
        self:_advance()
    end)

    return self
end

--[[
    Destroys the object.

    @returns never
]]
function FlickeringLight:destroy()
    self._updater:Disconnect()

    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end

--[[
    Advances the brightness curve.

    @private
    @returns never
]]
function FlickeringLight:_advance()
    local durationTime: number = time() / self._duration
    local sequenceProgress: number = durationTime - math.floor(durationTime)
    local brightness: number = evaluateNumberSequence(self._brightnessCurve, sequenceProgress)

    self._light.Brightness = self._originalLightBrightness * brightness
    self._beam.Brightness = self._originalBeamBrightness * brightness
    self._bulb.Color = Color3.new(
        self._originalBulbColor.R * brightness,
        self._originalBulbColor.G * brightness,
        self._originalBulbColor.B * brightness
    )
end

return FlickeringLight
