-- Paddle
-- moves left and right with touch
-- used to bounce ball at bricks
-----------------------------------------
local physics = require("physics")

-- get the spriteSheet --> contains art for all objects
local spriteSheet = require("SpriteSheet")

-- choose paddle sprite
local spriteData = 
{
	name = "idle",
	frames = {1},
}

-- create object
local paddle = display.newSprite( spriteSheet, spriteData )

-- set physics
physics.addBody( paddle, "static", {friction=0.5, bounce=1})

---------------------
-- variables
---------------------
local xFromBorder = paddle.width * 0.5 + 8 -- player cant move past this point
local yFromBottom = 50 + 8 								 -- gives some space at bottom of screen

paddle.name = "paddle"
paddle.maxX = display.contentWidth - xFromBorder
paddle.minX = 0 + xFromBorder
paddle.ballBounce = 400 --> use for applyForce
--paddle.ballBounce = 12 --> use for applyLinearImpulse --> much stronger and seems to be more stable


-- set pos
paddle.x = display.contentCenterX
paddle.y = display.contentHeight - yFromBottom


-- touch movement
function MovePaddle(event)	
	paddle.x = event.x

	if(paddle.x > paddle.maxX) then
		paddle.x = paddle.maxX
	end

	if(paddle.x < paddle.minX) then
		paddle.x = paddle.minX
	end

end

display.currentStage:addEventListener( "touch", MovePaddle )



-- done
return paddle