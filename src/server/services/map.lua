local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local mapTypes = require(script.Parent.Parent.components.map.types)

local mapService = Knit.CreateService({
    Name = "map",
    _maps = {},
    _current = {
        id = nil,
        instance = nil,
    },
})

--[[
    Stores map info.

	@returns never
]]
function mapService:KnitInit()
    for _index: number, mapContainer: Folder in pairs(script.Parent.Parent.game.maps:GetChildren()) do
        if mapContainer:IsA("Folder") == false then
            continue
        end

        local info: mapTypes.info = require(mapContainer:FindFirstChild("info"))
        local config: mapTypes.config = require(mapContainer:FindFirstChild("config"))
        self._maps[config.id] = { info = info, config = config, src = config.src }
    end
end

type map = { info: mapTypes.info, config: mapTypes.config, container: Folder }

--[[
    Gets a number of map infos.

    @param {number} count [The number of maps.]
    @param {{ string }} blacklist [The IDs of the maps that cannot be chosen from.]
	@returns { mapTypes.info }
]]
function mapService:getRandomMapInfos(count: number, blacklist: { string })
    local mapsFlattened: { map } = TableUtil.Map(TableUtil.Values(self._maps), function(map: map)
        return map
    end)
    local maps: { mapTypes.info } = {}

    -- Remove blacklisted maps.
    for index: number, map: { info: mapTypes.info, config: mapTypes.config, container: Folder } in ipairs(mapsFlattened) do
        if table.find(blacklist, map.config.id) == nil then
            continue
        end

        table.remove(mapsFlattened, index)
    end

    while #maps < count do
        if #mapsFlattened == 0 then
            break
        end

        local index: number = math.random(1, #mapsFlattened)
        local map: mapTypes.info = mapsFlattened[index].info
        table.remove(mapsFlattened, index)
        table.insert(maps, map)
    end

    -- Force cleanup.
    mapsFlattened = nil :: any

    return maps
end

--[[
    Gets a map config from its ID.

    @param {string} id [The ID of the map.]
    @returns mapTypes.config
]]
function mapService:getConfigFromID(id: string)
    return self._maps[id].config
end

--[[
    Loads a map.

    @param {string} id [The ID of the map.]
	@returns never
]]
function mapService:load(id: string)
    local map: Folder = self._maps[id].src:Clone()
    map.Parent = workspace
    self._current = map
end

--[[
    Removes the current map.

	@returns never
]]
function mapService:remove()
    if self._current.instance == nil then
        return
    end

    self._current.instance:Destroy()
    self._current.instance = nil
end

--[[
    Returns the current map.

    @returns Instance
]]
function mapService:getMap()
    return {
        id = self._current.id,
        instance = self._current.instance,
        config = self._maps[self._current.id].config,
    }
end

--[[
    Gets the info of a map.

    @param {Player} player [The player.]
    @param {string} id [The ID of the map.]
	@returns mapTypes.info?
]]
function mapService.Client:getInfoFromID(_player: Player, id: string)
    return self.Server._maps[id].info
end

return mapService
