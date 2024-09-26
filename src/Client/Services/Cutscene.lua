local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CameraService = require(script.Parent.Camera)
local Future = require(ReplicatedStorage.Packages.Future)
local getQuadraticXY = require(ReplicatedStorage.Functions.getQuadraticXY)

export type cutscene = { [number]: Vector3 }

export type options = {
    speed: number,
}

local CutsceneService = {
    _cutsceneID = 0,
}

function CutsceneService:createFromAttachments(container: Instance): cutscene
    local cutscene: cutscene = {}

    for _, attachment: Instance in pairs(container:GetChildren()) do
        if not attachment:IsA("Attachment") or tonumber(attachment.Name) == nil then
            continue
        end

        cutscene[tonumber(attachment.Name) :: number] = attachment.WorldPosition
    end

    return cutscene
end

function CutsceneService:play(cutscene: cutscene, options: options)
    CameraService:setType(Enum.CameraType.Scriptable)

    local cutsceneID: number = os.clock()
    self._cutsceneID = cutsceneID

    return Future.new(function()
        for _, position: Vector3 in ipairs(cutscene) do
            -- Confirms that its still the same cutscene that needs to be played.
            if self._cutsceneID ~= cutsceneID then
                return
            end

            CameraService:setPosition(CFrame.new(position))

            task.wait(options.speed)
        end

        CameraService:setType(Enum.CameraType.Custom)

        return
    end)
end

return CutsceneService
