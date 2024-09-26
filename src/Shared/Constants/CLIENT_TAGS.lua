local ReplicatedFirst = game:GetService("ReplicatedFirst")

local Components = ReplicatedFirst:FindFirstChild("Components")

return {
    ["FlickeringLight"] = { "BasePart", require(Components:FindFirstChild("FlickeringLight")) },
}
