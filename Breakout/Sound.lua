local Sound = {}

audio.reserveChannels( 6 )
Sound.breakBrick = 
{ 
	sound = audio.loadSound("break.wav"), 
	channel = 1,
	multiPlay = true
}

Sound.paddleBounce = 
{
	sound = audio.loadSound( "paddleBounce.wav"),
	channel = 2
}

Sound.wallBounce = 
{
	sound = audio.loadSound( "wallBounce.wav"),
	channel = 3
}

Sound.ceilingBounce = 
{
	sound = audio.loadSound( "wallBounce.wav"),
	channel = 4
}

Sound.win = 
{
	sound = audio.loadSound( "gameWin.wav"),
	channel = 5
}

Sound.dropBall =
{
	sound = audio.loadSound( "dropBall.wav"),
	channel = 6,
}

-- accepts a sound table --> as defined above
function Sound.play(s)

	if(audio.isChannelActive(s.channel) == false) then
		audio.play(s.sound, {channel = s.channel})
	elseif(s.multiPlay == true) then
		audio.play(s.sound, {channel = 0})
	end


end


return Sound