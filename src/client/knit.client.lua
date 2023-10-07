if script:FindFirstAncestorOfClass("Player") == nil then
	return
end

repeat
	task.wait()
until game:IsLoaded()

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
Knit.AddControllersDeep(script.Parent:WaitForChild("controllers"))
Knit.Start():catch(warn)
