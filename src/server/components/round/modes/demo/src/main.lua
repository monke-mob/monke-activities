local mode = require(script.Parent.Parent.Parent.mode)

local class = {}
class.__index = class
setmetatable(class, mode)

return class