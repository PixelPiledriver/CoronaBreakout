-- manages custom events
-- this makes it easier to call them, change them, add new ones, etc
-- functions as an event broadcaster ---> sends event to all objects listening for it
----------------------------------------------------------------------

local Events = {}

-- use to add a new event to the Events table
local function CreateEvent(e)
	local event =
	{
		name = e.name
	}

	function event:Dispatch()
		Runtime:dispatchEvent( self )
	end

	function event:AddObject(obj)
		Runtime:addEventListener( self.name, obj )
	end

	return event 
end 

------------------------
-- Events
------------------------
Events.allBricksBroken = CreateEvent{ name = "allBricksBroken"}



return Events