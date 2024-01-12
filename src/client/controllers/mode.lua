local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local modeAction = require(script.Parent.Parent.components.app.actions.mode)

local modeController = Knit.CreateController({
    Name = "mode",
    _modeService = nil,
    _current = nil,
    _eventHandler = nil,
})

--[[
	@returns never
--]]
function modeController:KnitStart()
    local modeService = Knit.GetService("mode")

    modeService.setMode:Connect(function(id: string)
        self._eventHandler = require(script.Parent.Parent.components.mode:FindFirstChild(id).eventHandler)
        self._current = id
        modeAction:set(id)
    end)

    modeService.event:Connect(function(event: string, ...)
        self._eventHandler[event](...)
    end)
end

return modeController
