local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local mapTypes = require(script.Parent.Parent.components.map.types)
local modeComponent = require(script.Parent.Parent.components.mode)
local modeTypes = require(script.Parent.Parent.components.mode.types)

local modeService = Knit.CreateService({
    Name = "mode",
    _modes = {},
    _current = nil,
    Client = {
        loadMode = Knit.CreateSignal(),
        event = Knit.CreateSignal(),
    },
})

--[[
    Stores mode info.
    
	@returns never
]]
function modeService:KnitInit()
    -- Storing all of the modes allows for easier access to them.
    for _index: number, modeContainer: Folder in pairs(script.Parent.Parent.game.modes:GetChildren()) do
        if modeContainer:IsA("Folder") == false then
            continue
        end

        local info: modeTypes.info = require(modeContainer:FindFirstChild("info"))
        local config: modeTypes.config = require(modeContainer:FindFirstChild("config"))
        self._modes[config.id] = { info = info, config = config, container = modeContainer }
    end
end

--[[
    Gets a random amount of mode infos.

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

        local id: string = compatibleModes[math.random(1, #compatibleModes)]

        if table.find(modesChosen, id) then
            continue
        else
            table.insert(modesChosen, id)

            local mode = self._modes[id]
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

    @param {string} id [The ID of the mode.]
    @param {modeComponent.players} players [The players participating in the mode.]
	@returns never
]]
function modeService:load(id: string, players: modeComponent.players)
    self.Client.loadMode:FireAll(id)

    -- Its best to only require the mode whenever its needed
    -- to save on memory and increase performance.
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

    self.Client.loadMode:FireAll(nil)
    self._current:destroy()
    self._current = nil
end

--[[
    Returns the current mode.

	@returns modeComponent.class?
]]
function modeService:getMode()
    return self._current
end

--[[
    Gets the info of a mode.

    @param {string} id [The ID of the mode.]
	@returns modeTypes.info?
]]
function modeService.Client:getInfoFromID(_player: Player, id: string)
    return self.Server._modes[id].info
end

return modeService
