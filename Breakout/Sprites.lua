
local Sprites = {}

----------------
-- Functions
----------------

function Sprites:CreateAnimationTable(data)

	print(data.spriteData)
	for i=1, #data.spriteData do
		data.animationTable[#data.animationTable + 1] = data.spriteData[i].name
	end 
end 


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

-- adds a sprite to the given table
-- smooths the process of creating sprites
local function MakeFrameToTable(data)
	data.t[#data.t + 1] = MakeFrameFromData(data.name)
end 


-- loads multiple similar sprites
-- {names, }
local function MakeSprites(data)

	local vertical = data.vertical or false


	-- use bundle?
	--create bundle if it doesnt exist
	if(data.bundle) then
		if(Sprites[data.bundle] == nil) then
			Sprites[data.bundle] = {}
		end
	end

	-- create sprite data for each name given
	for i=1, #data.names do

		local x
		local y

		if(vertical) then
			x = data.x
			y = data.y + (i-1) * data.height
		else
			x = data.x + (i-1) * data.width
			y = data.y
		end 

		-- create the sprite data
		Sprites.data[data.names[i]] =
		{
			x = x,
			y = y,
			width = data.width,
			height = data.height
		}

		-- add the sprite data as frame data to the sprite table
		MakeFrameToTable{t = data.t, name = data.names[i] }

		-- if a bundle is specified add the sprite
		-- to the existing group of sprites
		if(data.bundle) then
			Sprites[data.bundle][#Sprites[data.bundle]+1] = data.names[i]
			--{ 
				--name = data.names[i],
				--value = Sprites[data.names[i]],
			--}
		end 

	end 

end

---------------------
-- Create Frames
---------------------

-- sprite data
Sprites.names = {}
Sprites.data = {}
local sheetFrames = {}

-- create all sprites from sheet
-- made in groups with tables

MakeSprites
{
	t = sheetFrames,
	x = 0,
	y = 0,
	width = 64,
	height = 16,
	names = 
	{
		"paddle"
	}
}

MakeSprites
{
	t = sheetFrames,
	x = 64,
	y = 24,
	width = 8,
	height = 8,
	names =
	{
		"ceiling", "wall", "wall2"
	}
}

MakeSprites
{
	t = sheetFrames,
	x = 32,
	y = 16,
	width = 8,
	height = 8,
	names =
	{
		"rubble1", "rubble2", "rubble3", "rubble4", "rubble5"
	}
}

MakeSprites
{
	vertical = true,
	t = sheetFrames,
	x = 0,
	y = 16,
	width = 32,
	height = 16,
	names = 
	{
		"brick", "brick2", "brick3"
	}
}

MakeSprites
{
	t = sheetFrames,
	x = 64,
	y = 0,
	width = 16,
	height = 16,
	names =
	{
		"ball", "ball2", "ball3", 
		"ball4", "ball5", "ball6", 
		"ball7", "ball8", 
		"ball9", "ball10", "ball11", "ball12"
	},

	-- if you pass a bundle name it
	-- will group all of the sprites in this function call
	-- into a single ordered table
	bundle = "balls"
}



-------------------
-- Create sheet
-------------------

local sheetOptions =
{
	frames = sheetFrames
}

Sprites.spriteSheet = graphics.newImageSheet( "breakoutGraphics.png", sheetOptions)
Sprites.spriteSheetData = {}
Sprites.spriteSheetData.width = 256
Sprites.spriteSheetData.height = 256

return Sprites