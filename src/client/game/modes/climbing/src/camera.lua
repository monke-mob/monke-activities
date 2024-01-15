local RunService = game:GetService("RunService")

local currentCamera = workspace.CurrentCamera

local camera = {}
camera.renderStepped = nil
camera.target = nil

--[[
    Changes the cameras target to the passed player.
    
    @param {Model} target [The target character.]
    @returns never 
]]
function camera.changeTarget(target: Model)
    camera.target = target:FindFirstChild("HumanoidRootPart")
end

--[[
    Starts the camera.
    
    @returns never
]]
function camera.start()
    repeat
        currentCamera.CameraType = Enum.CameraType.Scriptable
    until currentCamera.CameraType == Enum.CameraType.Scriptable

    camera.renderStepped = RunService.RenderStepped:Connect(function()
        if camera.target == nil then
            return
        end

        local forwardVector = camera.target.CFrame.LookVector
        local newCameraPosition = camera.target.Position - forwardVector * Vector3.new(0, 0, 25)
        currentCamera.CFrame = CFrame.new(newCameraPosition, camera.target.Position)
    end)
end

--[[
    Stops the RenderStepped connection.

    @returns never
]]
function camera.cleanup()
    if camera.renderStepped == nil then
        return
    end

    camera.target = nil
    camera.renderStepped:Disconnect()
    camera.renderStepped = nil
end

return camera
