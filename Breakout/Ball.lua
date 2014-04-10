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
local spriteSheet = require("SpriteSheet")
local spriteData = 
{
	name = "idle",
	frames = {2}
}

-- create object
local ball = display.newSprite( spriteSheet, spriteData )

-- variables
ball.name = "ball"

-- set physics
physics.addBody( ball, {radius=8, density=3, friction=0.5, bounce=1})

-- pos 
ball.x = display.contentCenterX
ball.y = display.contentCenterY

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

		-- destroy brick
		event.other.Break()

		-- reduce speed
		local velocity = {}
		velocity.x, velocity.y = self:getLinearVelocity( )
		self:setLinearVelocity( velocity.x * 0.5, velocity.y * 0.5 )
		
		-- ball reacts to collision


	end

end

ball:addEventListener( "collision", ball )

-- move ball back to starting position
function ball:ResetBall()
	self.x = display.contentCenterX
	self.y = display.contentCenterY
	self:setLinearVelocity( 0, 0 )
	self.angularVelocity = self.angularVelocity * 0.1
	self.rotation = 0
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




-- make ball a little bigger so it overlaps on collision a tiny bit
ball:scale(1.5,1.5)

return ball