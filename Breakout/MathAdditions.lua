
local function VectorLength(v)
	return math.sqrt( (v.x * v.x) + (v.y * v.y) )
end

local function NormalizeVector(v)
	v.x = v.x / VectorLength(v)
	v.y = v.y / VectorLength(v)
end

local function VectorBetweenObjects(a, b)
	local v = {x = b.x - a.x, y = b.y - a.y}
	return v
end

local function ScaleVector(v, s)
	v.x = v.x * s
	v.y = v.y * s
end

math.VectorLength = VectorLength
math.NormalizeVector = NormalizeVector
math.VectorBetweenObjects = VectorBetweenObjects
math.ScaleVector = ScaleVector