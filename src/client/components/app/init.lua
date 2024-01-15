local blacklistedNames: { string } = { "actions", "components", "theme", "functions" }

--[[
    Starts the ui modules.

    @returns never
]]
local function app()
    for _index: number, instance: Instance in ipairs(script:GetChildren()) do
        if instance:IsA("ModuleScript") == false or table.find(blacklistedNames, instance.Name) then
            continue
        end

        require(instance)()
    end
end

return app
