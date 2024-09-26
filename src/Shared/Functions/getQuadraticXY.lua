--[[
	Adds an instance to the instance properties child entry.

	@param {Types.Dictionary} properties [The instance properties.]
	@param {Instance} instance [The instance add.]
	@returns never
--]]
function getQuadraticXY(position: number, point1: Vector3, point2: Vector3, point3: Vector3)
    return {
        x = (1 - position) * (1 - position) * point1.X
            + 2 * (1 - position) * position * point2.X
            + position * position * point3.X,
        y = (1 - position) * (1 - position) * point1.Y
            + 2 * (1 - position) * position * point2.Y
            + position * position * point3.Y,
    }
end

return getQuadraticXY
