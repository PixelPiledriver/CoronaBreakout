
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
local frameIndex = 1
local function MakeFrameFromData(name)
	local frame =
	{
		x = Sprites.data[name].x or 0,
		y = Sprites.data[name].y or 0,
		width = Sprites.data[name].width or 8,
		height = Sprites.data[name].height or 8
	}

	Sprites[name] = frameIndex
	Sprites.names[name] = name
	frameIndex = frameIndex + 1

	return frame
end 


-- program a way to load a group of sprites that are all
-- next to each other
-- set a starting point, direction flow, and then how many you want to load

---------------------
-- Create Frames
---------------------


-- sprite data
Sprites.names = {}
Sprites.data = {}
Sprites.data.paddle = {x=0, y=0, width=64, height=16} 

Sprites.data.ball = {x=64, y=0, width=16, height=16} 
Sprites.data.ball2 = {x=80, y=0, width=16, height=16}
Sprites.data.ball3 = {x=96, y=0, width=16, height=16}
Sprites.data.ball4 = {x=112, y=0, width=16, height=16}
Sprites.data.ball5 = {x=128, y=0, width=16, height=16}

Sprites.data.brick = {x=0, y=16, width=32, height=16}
Sprites.data.brick2 = {x=0, y=32, width=32, height=16}
Sprites.data.brick3 = {x=0, y=48, width=32, height=16}

Sprites.data.rubble1 = {x=32, y=16, width=8, width=8} 
Sprites.data.rubble2 = {x=40, y=16, width=8, width=8}

Sprites.data.wall = {x=72, y=24, width=8, height=8}
Sprites.data.ceiling = {x=64, y=24, width=8, height=8} 
	

-- frames

local sheetFrames = 
{
	MakeFrameFromData("paddle"),

	MakeFrameFromData("ball"),
	MakeFrameFromData("ball2"),
	MakeFrameFromData("ball3"),
	MakeFrameFromData("ball4"),
	MakeFrameFromData("ball5"),

	MakeFrameFromData("brick"),
	MakeFrameFromData("brick2"),
	MakeFrameFromData("brick3"),

	MakeFrameFromData("rubble1"),
	MakeFrameFromData("wall"),
	MakeFrameFromData("ceiling")
}

--print(Sprites.ball)
--print(Sprites.ball2)
--print(Sprites.ball3)


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

Sprites.spriteSheet = graphics.newImageSheet( "breakoutGraphics.png", sheetOptions)



return Sprites