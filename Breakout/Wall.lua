
local physics = require("physics")

-- sprite
local Sprites = require("Sprites")
local wallSprite =
{
	name = "idle",
	frames = {Sprites.wall}
}

local ceilingSprite =
{
	name = "idle",
	frames = {Sprites.ceiling}
}

local spriteData

-- create a wall object
local function CreateWall(data)
	local name = data.name or "wall"

	if(name == "wall") then
		spriteData = wallSprite
	elseif(name == "ceiling") then
		spriteData = ceilingSprite
	end

	local obj = display.newSprite( Sprites.spriteSheet, spriteData )
	obj.name = name
	obj.anchorX = 0
	obj.anchorY = 0
	obj.x = data.x
	obj.y = data.y
	obj.width = data.width or obj.width
	obj.height = data.height or obj.height


	physics.addBody( obj, "static", {friction=0.4, bounce=0.8} )

	return obj
end

-- create objects
local wallLeft = CreateWall
{
	x = 0,
	y = 0,
	height = display.contentHeight
}

local wallRight = CreateWall
{
	x = display.contentWidth - wallLeft.width, 
	y = 0,
	height = display.contentHeight
}

local wallTop = CreateWall
{
	name = "ceiling",
	x = 0,
	y = 0,
	width = display.contentWidth
}

