
local Events = require("Events")

local Levels = {}

local function MakeLevel(data)
	local level = {}

	level.xStart = data.xStart or nil
	level.yStart = data.yStart or nil
	level.xSpace = data.xSpace or 32
	level.ySpace = data.ySpace or 16
	level.align = data.align or "center"
	level.columns = data.columns or #data.bricks[1]
	level.bricks = data.bricks --> required

	return level
end

Levels.test1 = MakeLevel
{
	bricks =
	{
		{2,2,0,0,0,2,2},
		{1,1,2,2,2,1,1},
		{1,1,0,2,0,1,1},
		{0,1,1,0,1,1,0}
	}
}

Levels.test2 = MakeLevel
{
	bricks =
	{
		{2,0,2},
		{1,2,1},
		{1,0,1}
	}
}

Levels.test3 = MakeLevel
{
	bricks =
	{
		{2,1,1,2},
		{2,0,0,2},
		{2,0,0,2},
		{1,1,1,1}
	}
}

Levels.test4 = MakeLevel
{
	bricks =
	{
		{0,2,0,0,2,0,0,2,0},
		{0,0,2,0,2,0,2,0,0},
		{0,0,0,0,2,0,0,0,0},
		{1,1,2,1,1,1,2,1,1},
		{0,0,0,0,1,0,0,0,0},
		{0,0,0,0,1,0,0,0,0},
		{0,0,0,0,1,0,0,0,0},
	}
}

Levels.test5 = MakeLevel
{
	bricks =
	{
		{0,0,0,2,2,2,0,0,0},
		{2,2,2,2,2,2,2,2,2},
		{1,1,1,1,1,1,1,1,1},
		{0,0,0,0,0,0,0,0,0},
		{2,2,0,0,2,0,0,2,2},
		{1,1,0,1,1,1,0,1,1}
	}
}

Levels.test6 = MakeLevel
{
	bricks =
	{
		{0,0,0,0,0,0,0,2,2},
		{2,2,0,0,2,0,0,0,0},
		{0,0,0,2,0,0,0,1,0},
		{0,1,0,0,0,2,2,1,0},
		{0,2,0,1,1,1,0,0,1},
		{1,1,0,1,0,1,0,1,0},
		{0,1,1,0,1,0,0,0,1},
		{0,0,0,0,0,0,0,0,0},
	}
}


Levels.ernesto1 = MakeLevel
{
	bricks =
	{
		{2,0,1,1,2,2,1,1,1},
		{0,2,0,1,0,1,0,2,2},
		{1,2,2,2,1,2,2,0,1},
		{0,1,0,2,0,1,0,2,1},
		{1,1,2,1,0,0,1,0,2},
		{0,1,0,2,0,0,2,1,1},
		{0,1,2,2,1,0,1,0,2},
		{0,0,1,0,2,0,0,2,0},
	}
}


Levels.tall1 = MakeLevel
{
	bricks =
	{
		{2,2,2,2},
		{0,2,2,0},
		{0,1,1,0},
		{0,1,1,0},
		{2,0,0,2},
		{2,1,1,2},
		{1,2,2,1},
		{1,0,0,1},
		{1,0,0,1},
	}
}




-- stores all levels in ordered table so that one can be selected randomly by index
Levels.levels = 
{
	Levels.test1,
	Levels.test2,
	Levels.test3,
	Levels.test4,
	Levels.test5,
	Levels.test6,
	Levels.ernesto1,
	Levels.tall1,

}

function Levels:GetRandomLevel()
	return self.levels[math.random(#Levels.levels)]
end

Levels.notPlayedYet = {}
function Levels:GetRandomLevelUnique()

end

Levels.currentLevel = Levels:GetRandomLevel()

---------------
-- Events
----------------
function Levels:allBricksBroken(event)
	self.currentLevel = Levels:GetRandomLevel()
end
Events.allBricksBroken:AddObject(Levels)

return Levels