local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local mapTypes = require(script.Parent.Parent.components.map.types)

local mapService = Knit.CreateService({
    Name = "map",
    _maps = {},
    _currentMap = nil,
})

--[[
	@returns never
]]
function mapService:KnitInit()
    for _index: number, mapContainer: Folder in pairs(script.Parent.Parent.components.map.maps:GetChildren()) do
        if mapContainer:IsA("Folder") == false then
            continue
        end

        local info: mapTypes.info = require(mapContainer:FindFirstChild("info"))
        local config: mapTypes.config = require(mapContainer:FindFirstChild("config"))
        self._maps[info.id] = { info = info, config = config, src = mapContainer:FindFirstChild("src") }
    end
end

--[[
    Gets a number of map infos.

    @param {number} count [The number of maps.]
    @param {{ string }} blacklist [The ids of the maps that cannot be chosen from.]
	@returns { mapTypes.info }
]]
function mapService:getRandomMapInfos(count: number, blacklist: { string })
    local mapsFlattened: { mapTypes.info } = TableUtil.Map(
        TableUtil.Values(self._maps),
        function(map: { info: mapTypes.info, container: Folder })
            return map.info
        end
    )
    local maps: { mapTypes.info } = {}

    -- Remove blacklisted maps.
    for index: number, map: mapTypes.info in ipairs(mapsFlattened) do
        if table.find(blacklist, map.id) == nil then
            continue
        end

        table.remove(mapsFlattened, index)
    end

    while #maps < count do
        if #mapsFlattened == 0 then
            break
        end

        local index: number = math.random(1, #mapsFlattened)
        local map: mapTypes.info = mapsFlattened[index]
        table.remove(mapsFlattened, index)
        table.insert(maps, map)
    end

    -- Force cleanup.
    mapsFlattened = nil :: any

    return maps
end

--[[
    Gets a map config from its ID.

    @param {string} id [The id of the map.]
    @returns mapTypes.config
]]
function mapService:getConfigFromID(id: string)
    return self._maps[id].config
end

--[[
    Loads a map.

    @param {string} id [The id of the map.]
	@returns never
]]
function mapService:loadMap(id: string)
    local map: Folder = self._maps[id].src:Clone()
    map.Parent = workspace
    self._currentMap = map
end

--[[
    Removes the current map.

	@returns never
]]
function mapService:removeMap()
    if self._currentMap == nil then
        return
    end

    self._currentMap:Destroy()
    self._currentMap = nil
end

return mapService
