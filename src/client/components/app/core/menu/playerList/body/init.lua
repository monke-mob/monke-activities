local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.Parent.components.frame)
local handleCardSprings = require(script.handleCardSprings)
local handleList = require(script.handleList)
local list = require(script.Parent.Parent.Parent.Parent.components.list)
local playerCard = require(script.playerCard)

--[[
	Handles the body of the player list.

	@returns Fusion.Component
--]]
local function body()
    local playerList = handleList()
    local cardSprings = handleCardSprings()

    return Fusion.New("ScrollingFrame")({
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(0.5, 0.6),
        Position = UDim2.fromScale(0.5, 0.3),
        AnchorPoint = Vector2.new(0.5, 0),

        [Fusion.Children] = {
            list({}),

            frame({
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.fromScale(1, 0),

                [Fusion.Children] = {
                    Fusion.ForPairs(playerList, function(index: number, player: Player)
                        return index,
                            playerCard({
                                player = player,
                                spring = cardSprings[index],
                            })
                    end, Fusion.cleanup),
                },
            }, {}),
        },
    })
end

return body
