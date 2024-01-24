-- This has to be done because the script will run if its still parented under StarterPlayerScripts
-- causing it to run twice. So instead check the parent before running.
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
