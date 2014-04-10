-- returns a table to be used as frame data for 'complex' spritesheet
local function MakeFrame(_x, _y, _width, _height)
	local frame =
	{
		x = _x,
		y = _y,
		width = _width,
		height = _height
	}

	return frame
end

local sheetFrames = 
{
	-- paddle = 1
	MakeFrame(0,0,64,16),

	-- ball = 2
	MakeFrame(64,0,16,16),

	-- brick = 3
	MakeFrame(0,16,32,16),

	-- rubble1 = 4
	MakeFrame(32,16,8,8),

	-- wall = 5
	MakeFrame(72,24,8,8),

	-- ceiling = 6
	MakeFrame(64,24,8,8)
}

local sheetOptions =
{
	frames = sheetFrames
}

local spriteSheet = graphics.newImageSheet( "breakoutGraphics.png", sheetOptions)



return spriteSheet