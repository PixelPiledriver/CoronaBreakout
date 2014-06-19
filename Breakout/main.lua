
-- setup
--------------------------------------
require("SetGraphics")
require("MathAdditions")
local physics = require("physics")
physics.start()

-- test
----------------------------------
require("Sprites")

-- objects
------------------------------------
local paddle = require("Paddle")
local ball = require("Ball")
local Bricks = require("Brick")
require("Wall")


local function Update(event)
	ball:Update()
	Bricks:Update()
end

Runtime:addEventListener( "enterFrame", Update )
