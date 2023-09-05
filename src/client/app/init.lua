local core = require(script.core)
local intro = require(script.intro)

--[[
    Handles starting the ui modules.

    @returns never
]]
local function app()
	core()
	intro()
end

return app
