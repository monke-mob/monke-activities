local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Fusion = require(ReplicatedStorage.Packages.Fusion)
local types = require(ReplicatedStorage.types)

local concatTables = require(ReplicatedStorage.functions.concatTables)
local frame = require(script.Parent.frame)

type instanceProps = {
	wrapper: types.dictionaryAny,
	gif: types.dictionaryAny,
}

type componentProps = {
	spriteSheet: string,
	defaultImage: string?,
	frameRate: number?,
	frames: number?,
	rows: number,
	columns: number,
}

--[[
	Allows for animating sprite sheets.

	@param {instanceProps} instanceProps [The instance props.]
	@param {componentProps} componentProps [The component props.]
	@returns Fusion.Component, (startFrame: number?) -> never, () -> never
--]]
local function gif(instanceProps: instanceProps, componentProps: componentProps)
	local rectOffset = Fusion.Value(Vector2.new())
	local rectSize = Fusion.Value(Vector2.new())
	local playing = Fusion.Value(false)
	local frameRate: number = 60 / (componentProps.frameRate or 24)
	local frameCount: number = componentProps.frames or componentProps.rows * componentProps.columns
	local frameSize: Vector2 = Vector2.new(1024 / componentProps.rows, 1024 / componentProps.columns)
	local currentFrame: number = 0
	local updaterConnection: RBXScriptConnection

	rectSize:set(frameSize)

	--[[
		Sets the gif frame.

		@param {number} frame [The frame.]
		@returns never
	]]
	local function setFrame(frame: number)
		local frameX: number = frameSize.X * (frame % componentProps.rows)
		local frameY: number = frameSize.Y * ((frame - (frame % componentProps.rows)) / componentProps.rows)
		rectOffset:set(Vector2.new(frameX, frameY))
	end

	--[[
		Starts playing the gif.

		@param {number?} startFrame [The starting frame.]
		@returns never
	]]
	local function start(startFrame: number?)
		playing:set(true)
		currentFrame = startFrame or 0

		local updaterFrame: number = 0
		updaterConnection = RunService.RenderStepped:Connect(function()
			updaterFrame += 1

			if updaterFrame % frameRate ~= 0 then
				return
			end

			if currentFrame >= (frameCount - 1) then
				currentFrame = 0
			else
				currentFrame += 1
			end

			setFrame(currentFrame)
		end)
	end

	--[[
		Stops playing the gif.

		@returns never
	]]
	local function stop()
		updaterConnection:Disconnect()
		updaterConnection = nil :: any
		playing:set(false)
		setFrame(0)
	end

	return frame(
		concatTables({
			[Fusion.Children] = {
				if typeof(componentProps.defaultImage) == "string"
					then Fusion.New("ImageLabel")({
						Image = componentProps.defaultImage,
						ImageTransparency = instanceProps.gif.ImageTransparency,
						Visible = Fusion.Computed(function()
							return not playing:get()
						end),
						Position = UDim2.fromScale(0.5, 0.5),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromScale(1, 1),
						ScaleType = Enum.ScaleType.Fit,
						BackgroundTransparency = 1,
					})
					else {},

				Fusion.New("ImageLabel")({
					Image = componentProps.spriteSheet,
					ImageTransparency = instanceProps.gif.ImageTransparency,
					Visible = playing,
					ImageRectOffset = rectOffset,
					ImageRectSize = rectSize,
					Position = UDim2.fromScale(0.5, 0.5),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),
					ScaleType = Enum.ScaleType.Fit,
					BackgroundTransparency = 1,
				}),
			},
		}, instanceProps.wrapper),
		{}
	),
		start,
		stop
end

return gif
