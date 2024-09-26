local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Guard = require(ReplicatedStorage.Packages.Guard)
local Red = require(ReplicatedStorage.Packages.Red)

return Red.Event("LoadActivity", function(prepared)
    return Guard.Boolean(prepared)
end)
