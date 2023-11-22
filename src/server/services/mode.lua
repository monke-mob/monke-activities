local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local mapTypes = require(script.Parent.Parent.components.map.types)
local modeComponent = require(script.Parent.Parent.components.mode.modes)
local modeTypes = require(script.Parent.Parent.components.mode.types)

local modeService = Knit.CreateService({
    Name = "mode",
    _modes = {},
    _current = nil,
})

--[[
	@returns never
]]
function modeService:KnitInit()
    for _index: number, modeContainer: Folder in pairs(script.Parent.Parent.components.mode.modes:GetChildren()) do
        if modeContainer:IsA("Folder") == false then
            continue
        end

        local info: modeTypes.info = require(modeContainer:FindFirstChild("info"))
        local config: modeTypes.config = require(modeContainer:FindFirstChild("config"))
        self._modes[info.id] =
            { info = info, config = config, container = modeContainer }
    end
end

--[[
    Gets a number of mode infos.

    @param {number} count [The number of modes to be chosen.]
    @param {mapTypes.config} mapConfig [The map config.]
	@returns { modeTypes.info }
]]
function modeService:getRandomModesFromMap(count: number, mapConfig: mapTypes.config)
    local compatibleModes: mapTypes.compatibleModes = mapConfig.compatibleModes
    local modes: { modeTypes.info } = {}
    local modesChosen: { string } = {}

    while #modes < count do
        if #modes == #compatibleModes then
            break
        end

        local modeID: string = compatibleModes[math.random(1, #compatibleModes)]

        if table.find(modesChosen, modeID) then
            continue
        else
            table.insert(modesChosen, modeID)

            local mode = self._modes[modeID]
            table.insert(modes, mode.info)
        end
    end

    -- Force cleanup.
    compatibleModes = nil :: any
    modesChosen = nil :: any

    return modes
end

--[[
    Loads a mode.

    @param {string} id [The id of the mode.]
    @param {modeComponent.players} players [The players participating in the mode.]
	@returns never
]]
function modeService:load(id: string, players: modeComponent.players)
    local mode = require(self._modes[id].config.src).new(players)
    mode:start()
    self._current = mode
end

--[[
    Destroys the current mode.

	@returns never
]]
function modeService:remove()
    if self._current == nil then
        return
    end

    self._current:Destroy()
    self._current = nil
end

return modeService
