local springComponent = require(script.Parent)

type config = springComponent.config & {
    count: number,
    delay: number?,
}

export type springs = { springComponent.spring }

--[[
	Creates the needed amount of springs using the `springComponent` component.

	@param {springComponent.targets} targets [The target values.]
	@param {config} config [The spring config.]
	@returns { springComponent.spring }, { springComponent.update }
--]]
local function createSprings(targets: springComponent.targets, config: config): (springs, { springComponent.update })
    local springs: springs = {}
    local springUpdaters: { springComponent.update } = {}

    for index = 1, config.count do
        local spring, updateSpring = springComponent(targets, config)
        springs[index] = spring
        springUpdaters[index] = updateSpring
    end

    return springs, springUpdaters
end

type updateCount = (newCount: number) -> never

--[[
	Creates multiple springs for tweening. Allows
	for a `delay` parameter so that springs
	can be staggered.

	@extends springComponent
	@param {config} config [The spring config.]
	@returns springs, springComponent.update
--]]
local function springsComponent(
    targets: springComponent.targets,
    config: config
): (springs, springComponent.update, updateCount)
    local springs, springUpdaters = createSprings(targets, config)

    --[[
		Updates the target values.

		@param {targets} newTargets [The new target values.]
		@returns never
	--]]
    local function update(newTargets: springComponent.targets)
        -- To prevent yielding the main thread we
        -- use `task.spawn`.
        task.spawn(function()
            for _index: number, updateSpring in ipairs(springUpdaters) do
                updateSpring(newTargets)

                if typeof(config.delay) == "number" then
                    task.wait(config.delay)
                end
            end
        end)
    end

    --[[
		Updates the amount of springs.

		@param {number} newCount [The new amount of springs.]
		@returns never
	--]]
    local function updateCount(newCount: number)
        -- Do note that this will not destroy / remove springs.
        -- At the time of creating this I had no need because
        -- at most a there is a few extra unused springs.
        if newCount <= config.count then
            return
        end

        for index = config.count, newCount - config.count do
            local spring, updateSpring = springComponent(targets, config)
            springs[index] = spring
            springUpdaters[index] = updateSpring
        end

        config.count = newCount
    end

    return springs, update, updateCount
end

return springsComponent
