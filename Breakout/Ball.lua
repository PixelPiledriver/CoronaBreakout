-- Ball
-- bounces around
-- breaks bricks
-- use paddle to bounce
-- if goes past paddle respawns
-- gonna try to use a physics object
---------------------------------------------

local Events = require("Events")
local physics = require("physics")
local sound = require("Sound")
local Sprites = require("Sprites")
local Func = require("Func")


-- sprites
local spriteData = 
{
	{
		name = "ball",
		frames = {Sprites.ball}
	},

	{
		name = "ball2",
		frames = {Sprites.ball2}
	},

	{
		name = "ball3",
		frames = {Sprites.ball3}
	},

	{
		name = "ball4",
		frames = {Sprites.ball4}
	},

	{
		name = "ball5",
		frames = {Sprites.ball5}
	},


}


-- create object
local ball = display.newSprite( Sprites.spriteSheet, spriteData )

-- variables
ball.name = "ball"

-- set physics
physics.addBody( ball, {radius=8, density=3, friction=0.5, bounce=1})

-- pos 
ball.x = display.contentCenterX
ball.y = display.contentCenterY


----------------
-- Functions
----------------

-- gather animations into a table for later use
function ball:CreateAnimationTable()

	self.animations = {}

	for i=1, #spriteData do
		self.animations[#self.animations + 1] = spriteData[i].name
	end 

end 

-------------------------------------------------
-- Collision
-------------------------------------------------
function ball:collision(event)

	-- w/ wall
	if(event.other.name == "wall") then
		-- reduce speed a little
		local velocity = {}
		velocity.x, velocity.y = self:getLinearVelocity( )
		self:setLinearVelocity( velocity.x * 0.9, velocity.y * 0.9 )

		sound.play(sound.wallBounce)
	end

	-- w/ ceiling
	if(event.other.name == "ceiling") then

		-- reduce speed
		local velocity = {}
		velocity.x, velocity.y = self:getLinearVelocity( )
		self:setLinearVelocity( velocity.x * 0.5, velocity.y * 0.5 )

		sound.play(sound.ceilingBounce)
	end

	-- w/ paddle
	if(event.other.name == "paddle") then
		
		local v = math.VectorBetweenObjects(event.other, self)
		math.NormalizeVector(v)
		math.ScaleVector(v, event.other.ballBounce)
	
		self:applyForce( v.x, v.y, self.x, self.y )
		--self:applyLinearImpulse( v.x, v.y, self.x, self.y )

		sound.play(sound.paddleBounce)
	end

	-- w/ brick
	if(event.other.name == "brick") then

		if(event.other.brickType == 1) then
			-- destroy brick
			event.other:Break()

			-- reduce speed of ball
			local velocity = {}
			velocity.x, velocity.y = self:getLinearVelocity( )
			self:setLinearVelocity( velocity.x * 0.5, velocity.y * 0.5 )
	
		end 

		
		-- ball reacts to collision


	end

end

ball:addEventListener( "collision", ball )

-- move ball back to starting position
function ball:ResetBall()

	-- need to add a button for resetting the ball


	-- set ball to random sprite
	
	self:setSequence( Func:ChooseRandomlyFrom(self.animations) )


	self.x = display.contentCenterX
	self.y = display.contentCenterY
	self:setLinearVelocity( 0, 0 )
	self.angularVelocity = self.angularVelocity * 0.1
	self.rotation = 0

	local size = Func:ChooseRandomlyFrom{1, 2}
	ball.xScale = size
	ball.yScale = size

end

-- ball falls out of play
function ball:DropBall()
	if(self.y > display.contentHeight) then
		self:ResetBall()
		sound.play(sound.dropBall)
	end
end

-- stuff ball should check for
function ball:Update(event)
	self:DropBall()
end

--------------------------------------
-- Events
-- custom events ball should listen for
--------------------------------------
function ball:allBricksBroken(event)
	--ball:ResetBall()
end
Events.allBricksBroken:AddObject(ball)


----------------------
-- Run on require
----------------------

-- animation table
ball:CreateAnimationTable()

-- make ball a little bigger so it overlaps on collision a tiny bit
ball.xScale = 1.5
ball.yScale = 1.5


return ball