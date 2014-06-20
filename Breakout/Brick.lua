local Bricks = display.newGroup() -- static object

local Events = require("Events")
local Levels = require("Levels")
local sound = require("Sound")
local physics = require("physics")
local Sprites = require("Sprites")
local Func = require("Func")


local spriteData = 
{
	name = "idle",
	frames = {Sprites.brick}
}

-- get size from temp object for later use
local tempBrick = display.newSprite( Sprites.spriteSheet, spriteData )
local brickSize =
{
	width = tempBrick.width, 
	height = tempBrick.height
}
tempBrick:removeSelf( )


-- rubble
local rubbleSpriteData =
{
	{
		name = "rubble1",
		frames = {Sprites.rubble1}
	},

	{
		name = "rubble2",
		frames = {Sprites.rubble2}
	},

	{
		name = "rubble3",
		frames = {Sprites.rubble3}
	},

	{
		name = "rubble4",
		frames = {Sprites.rubble4}
	},

	{
		name = "rubble5",
		frames = {Sprites.rubble5}
	},

}

local rubbleAnimations = {}
local function RubbleAnimationTable()

	for i=1, #rubbleSpriteData do
		rubbleAnimations[#rubbleAnimations + 1] = rubbleSpriteData[i].name
	end 

end 

RubbleAnimationTable()

---------------------------------------------------
-- Level
-- bricks layout created from these variables
---------------------------------------------------
local totalBricks = 7  			-- starting number of bricks
local columns = 7					  -- how many bricks wide
local totalBricksBroken = 0 -- used to track when level is complete
local totalBricksAtStart = 0

-- contains all brick objects
local bricks = {}

local rubble = {}

local makeRubbleLater = {}


local function PrintBricks()
	for i=1, #bricks do
		print(bricks[i])
	end 
end 

local function CreateBrickRubble()

	if(#makeRubbleLater == 0) then
		return
	end 

	local rubbleCount = 3

	for i=1, #makeRubbleLater do

		for c=1, rubbleCount do



			local obj = display.newSprite(Sprites.spriteSheet, rubbleSpriteData)

			obj:setSequence( Func:ChooseRandomlyFrom(rubbleAnimations) )

			obj.x = makeRubbleLater[i].x + makeRubbleLater[i].width * 0.5
			obj.y = makeRubbleLater[i].y + makeRubbleLater[i].height * 0.5

			physics.addBody( obj, {friction=0.2, bounce=0.5, filter = {groupIndex = -1} } )

			local velocity = {}
			local v = 1000
			velocity.x = math.random(-v, v)
			velocity.x = velocity.x * 0.1

			velocity.y = math.random(-v, v)
			velocity.y = velocity.y * 0.1

			obj:setLinearVelocity(velocity.x, velocity.y)

		end 

	end 

	makeRubbleLater = {}

end 

-- create a single brick object
local function CreateBrick(data)

	-- random brick sprite
	spriteData.frames = { Func:ChooseRandomlyFrom{Sprites.brick, Sprites.brick2, Sprites.brick3} }


	local obj = display.newSprite( Sprites.spriteSheet, spriteData )

	obj.name = "brick"
	obj.x = data.x or display.contentCenterX
	obj.y = data.y or 200
	obj.anchorX = 0
	obj.anchorY = 0
	obj.brickType = data.brickType or 1
	obj.index = data.index

	-----------------
	-- Functions
	-----------------

	function obj:Break()
	
		totalBricksBroken =  totalBricksBroken + 1

		bricks[self.index] = nil

		obj:removeSelf( )

		-- play sound
		sound.play(sound.breakBrick)

		-- create rubble
		makeRubbleLater[#makeRubbleLater + 1] = 
		{
			x = self.x, 
			y = self.y,
			width = self.width,
			height = self.height
		}

	end

	function obj:Update()
		if(self == nil) then
			return
		end 

		if(self.y > display.contentHeight - 20) then
			obj:Break()
		end 
	end 


	-- brick type determines physics type -- for now
	-- need to make a table of brick types --> :P
	if(obj.brickType == 1) then
		physics.addBody( obj, "static", {friction=0.5, bounce=0.5 } )
	elseif(obj.brickType == 2) then
		physics.addBody( obj, {friction=0.2, bounce=0.5, density = 1 } )
	end 

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

	totalBricksAtStart = 0
	local activeBricksCount = 0

	---[[
	for yi=1, #level.bricks do
		for xi=1, #level.bricks[yi] do
			


			-- create brick?
			if(level.bricks[yi][xi] > 0) then

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
					y = yPos,
					brickType = level.bricks[yi][xi],
					index = activeBricksCount+1
				}

				
				--bricks[xi + (yi-1) * level.columns] = CreateBrick(brickData)
				bricks[activeBricksCount+1] = CreateBrick(brickData)
			
				activeBricksCount = activeBricksCount + 1

			end

		end 

	end
	--]]
	
	totalBricks = activeBricksCount
	totalBricksAtStart = activeBricksCount


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

	-- update individual bricks
	if(totalBricksAtStart > 0) then
		for i=1, totalBricksAtStart do
			-- brick exists?
			if(bricks[i]) then
				bricks[i]:Update()
			end 
		end 
	end

	-- create brick rubble
	CreateBrickRubble()

	-- is level over?
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
--print("Bricks: " .. totalBricks) 


return Bricks


