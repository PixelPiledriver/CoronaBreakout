local Bricks = display.newGroup() -- static object

local Events = require("Events")
local Levels = require("Levels")
local sound = require("Sound")
local physics = require("physics")
local spriteSheet = require("SpriteSheet")
local spriteData = 
{
	name = "idle",
	frames = {3}
}

-- get size from temp object for later use
local tempBrick = display.newSprite( spriteSheet, spriteData )
local brickSize = 
{
	width = tempBrick.width, 
	height = tempBrick.height
}
tempBrick:removeSelf( )

---------------------------------------------------
-- Level
-- bricks layout created from these variables
---------------------------------------------------
local totalBricks = 7  			-- starting number of bricks
local columns = 7					  -- how many bricks wide
local totalBricksBroken = 0 -- used to track when level is complete

-- contains all brick objects
local bricks = {}

-- create a single brick object
local function CreateBrick(data)
	local obj = display.newSprite( spriteSheet, spriteData )

	obj.name = "brick"
	obj.x = data.x or display.contentCenterX
	obj.y = data.y or 200
	obj.anchorX = 0
	obj.anchorY = 0

	function obj:Break()
		totalBricksBroken =  totalBricksBroken + 1
		print("Bricks: " .. totalBricks - totalBricksBroken)
		obj:removeSelf( )

		-- play sound
		sound.play(sound.breakBrick)

	end

	physics.addBody( obj, "static", {friction=0.5, bounce=1} )

	return obj
end

-- put all bricks in grid
local function PosArray(objs, data)
	local x = data.x or 100
	local y = data.y or 100

	local xSpace = data.xSpace or 50
	local ySpace = data.ySpace or 50
	local width = data.width or 3

	for i=0, #objs-1 do
		objs[i+1].x = x + ((i % width) * xSpace)
		objs[i+1].y = y + (math.floor(i / width) * ySpace)
	end

end



local currentLevel = testLevel

-- create level from bricks defined in an object
-- this allows for levels to be designed
local function CreateBricksFromTable(level)

	local activeBricksCount = 0

	---[[
	for yi=1, #level.bricks do
		for xi=1, #level.bricks[yi] do
			
			-- create
			if(level.bricks[yi][xi] == 1) then

				local xPos
				local yPos

				if(level.align == "center") then
					xPos = display.contentCenterX  - ((level.columns * brickSize.width) * 0.5) + ((xi-1) * level.xSpace)
					yPos = 100 + (yi * level.ySpace)
				else
					xPos = level.xStart + (xi * level.xSpace)
					yPos = level.yStart + (yi * level.ySpace)
				end

				local brickData = 
		  	{
			 		x = xPos,
					y = yPos
				}

				bricks[xi + (yi-1) * level.columns] = CreateBrick(brickData)

				activeBricksCount = activeBricksCount + 1

			end

		end 
	end
	--]]
	
	totalBricks = activeBricksCount

end

local function CreateBricksFromTotal()
	for i=1, totalBricks do
		bricks[i] = CreateBrick{}
	end 
	
	local posData=
	{
		x = display.contentCenterX - ((columns * brickSize.width) * 0.5),
		y = 100,
		xSpace = brickSize.width,
		ySpace = brickSize.height,
		width = columns
	}

	PosArray(bricks, posData)
end

-- create bricks for level --> set from above functions, change function to change brick build type
local CreateAllBricks = CreateBricksFromTable

-- called by a timer so I can pass arguments to CreateAllBricks
local function CreateAllBricksTimerCall()
	CreateAllBricks(Levels.currentLevel)
end 

-- remove all brick objects from memory
local function ClearBricks()

	for i=1, #bricks do
		bricks[i] = nil
	end

end

-- stuff run on enterFrame event
function Bricks:Update()

	if(totalBricksBroken == totalBricks) then
		Events.allBricksBroken:Dispatch()
	end

end

----------------
-- Events
----------------
function Bricks:allBricksBroken(event)
	-- cleanup bricks
	ClearBricks()
	local t = timer.performWithDelay( 1000, CreateAllBricksTimerCall)
	--CreateAllBricks()
	totalBricksBroken = 0		
	
	-- play happy sound for player to enjoy :)
	sound.play(sound.win)

	print("You Win!")
end
Events.allBricksBroken:AddObject(Bricks)

CreateAllBricks(Levels.currentLevel)

-- print total at start of game
print("Bricks: " .. totalBricks) 


return Bricks


