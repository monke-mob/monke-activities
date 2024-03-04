local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Fusion = require(ReplicatedStorage.Packages.Fusion)

local frame = require(script.Parent.Parent.Parent.Parent.components.frame)
local grid = require(script.Parent.Parent.Parent.Parent.components.grid)
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
        Size = UDim2.fromScale(0.5, 1),
        Position = UDim2.fromScale(0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0),
        ScrollBarThickness = 8,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.fromScale(0, 0),
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,

        [Fusion.Children] = {
            list({
                Padding = UDim.new(0, 15),
                VerticalAlignment = Enum.VerticalAlignment.Top,
            }),

            frame({
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.fromScale(1, 0),

                [Fusion.Children] = {
                    grid({
                        CellPadding = UDim2.fromOffset(0, 5),
                        CellSize = UDim2.new(1, 0, 0, 58),
                        HorizontalAlignment = Enum.HorizontalAlignment.Left,
                        VerticalAlignment = Enum.VerticalAlignment.Top,
                    }),

                    Fusion.ForPairs(playerList.players, function(index: number, player: Player)
                        return index,
                            playerCard({
                                player = player,
                                stats = playerList.stats[player.UserId],
                                spring = cardSprings[index],
                            })
                    end, Fusion.cleanup),
                },
            }, {}),
        },
    })
end

return body
