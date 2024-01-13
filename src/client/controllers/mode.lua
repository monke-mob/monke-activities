local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local modeTypes = require(script.Parent.Parent.components.mode.types)
local modeService

local modeController = Knit.CreateController({
    Name = "mode",
    _modes = {},
    _current = {
        mode = nil,
        config = nil,
    },
})

--[[
	@returns never
]]
function modeController:KnitStart()
    modeService = Knit.GetService("mode")

    -- Storing all of the modes allows for easier access to them.
    for _index: number, modeContainer: Folder in pairs(script.Parent.Parent.game.modes:GetChildren()) do
        if modeContainer:IsA("Folder") == false then
            continue
        end

        local config: modeTypes.config = require(modeContainer:FindFirstChild("config"))
        local _success: boolean, info = modeService:getInfo(config.id):await()
        self._modes[config.id] = { info = info, config = config, container = modeContainer }
    end

    modeService.loadMode:Connect(function(id: string?)
        -- If the ID is nil then the mode is being removed.
        if id == nil then
            modeController:_remove()
        else
            modeController:_load(id)
        end
    end)
end

--[[
    Returns the current mode.

	@returns modeComponent.class?
]]
function modeController:getMode()
    return self._current.mode
end

--[[
    Returns the current mode config.

	@returns modeTypes.config?
]]
function modeController:getModeConfig()
    return self._current.config
end

--[[
    Loads a mode.

    @param {string} id [The id of the mode.]
	@returns never
]]
function modeController:_load(id: string)
    local mode = require(self._modes[id].config.src).new()
    self._current.mode = mode
    self._current.config = self._modes[id].config
    mode:start()
end

--[[
    Destroys the current mode.

	@returns never
]]
function modeController:_remove()
    if self._current == nil then
        return
    end

    self._current:Destroy()
    self._current.mode = nil
    self._current.config = nil
end

return modeController
