local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local Knit = require(ReplicatedStorage.Packages.Knit)

type componentProps = {
    enabled: any,
    rootTransparency: any,
    groupSplashTransparency: any,
    groupSplashStart: (startFrame: number?) -> never,
    groupSplashStop: () -> never,
}

--[[
	Handles the logic for the intro.

    @param {componentProps} componentProps [The component props.]
	@returns never
--]]
local function handleLogic(componentProps: componentProps)
    local intermissionService = Knit.GetService("intermission")
    local playerController = Knit.GetController("player")

    task.spawn(function()
        playerController:disableMovement()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

        task.wait(3)

        componentProps.groupSplashTransparency:set(0)

        task.wait(3)

        for _index = 1, 3 do
            componentProps.groupSplashStart(math.random(1, 25))
            task.wait(0.1)

            componentProps.groupSplashStop()
            task.wait(0.25)
        end

        componentProps.groupSplashStart()

        task.wait(2)

        componentProps.groupSplashTransparency:set(1)

        task.wait(3)

        componentProps.rootTransparency:set(1)

        task.wait(2)

        componentProps.enabled:set(false)
        playerController:enableMovement()
        intermissionService:setReady(true)
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
    end)
end

return handleLogic
