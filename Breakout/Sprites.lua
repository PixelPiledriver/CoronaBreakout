
local Sprites = {}


----------------
-- Functions
----------------

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



-- returns frame data table made from Sprites structure
local frameIndex = 0
local function MakeFrameFromData(t)
	local frame =
	{
		x = t.data.x or 0,
		y = t.data.y or 0,
		width = t.data.width or 8,
		height = t.data.height or 8
	}

	t.frame = frameIndex
	frameIndex = 0

	return frame
end 


---------------------
-- Create Frames
---------------------


-- sprite data
Sprites.paddle = { data = {x=0, y=0, width=64, height=16} }
Sprites.ball = { data = {x=64, y=0, width=16, height=16} }
Sprites.brick = { data = {x=0, y=16, width=32, height=16} }
Sprites.rubble1 = { data = {x=32, y=16, width=8, width=8} }
Sprites.wall = { data = {x=72, y=24, width=8, height=8} }
Sprites.ceiling = { data = {x=64, y=24, width=8, height=8} }
	

-- frames

local sheetFrames =
{
	MakeFrameFromData(Sprites.paddle),
	MakeFrameFromData(Sprites.ball),
	MakeFrameFromData(Sprites.brick),
	MakeFrameFromData(Sprites.rubble1),
	MakeFrameFromData(Sprites.wall),
	MakeFrameFromData(Sprites.ceiling)
}

print(Sprites.ball.frame)



--[[
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
--]]

local sheetOptions =
{
	frames = sheetFrames
}

local spriteSheet = graphics.newImageSheet( "breakoutGraphics.png", sheetOptions)



return Sprites