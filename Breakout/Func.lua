--functions 

local Func = {}


function Func:ChooseRandomlyFrom(data)

	local index = math.random(#data)

	return data[index]

end 



return Func