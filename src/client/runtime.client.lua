if script:FindFirstAncestorOfClass("Player") == nil then
    return
end

repeat
    task.wait()
until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local app = require(script.Parent.components.app)

Knit.AddControllersDeep(script.Parent:WaitForChild("controllers"))
Knit.Start()
    :andThen(function()
        app()
    end)
    :catch(warn)
