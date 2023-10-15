local core = require(script.core)
local intro = require(script.intro)
local voting = require(script.voting)

--[[
    Handles starting the ui modules.

    @returns never
]]
local function app()
    core()
    intro()
    voting()
end

return app
