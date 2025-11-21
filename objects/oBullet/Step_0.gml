x += bulletSpdX
y += bulletSpdY

if(place_meeting(x + sign(bulletSpdX), y + sign(bulletSpdY), oPlayer.platformGround))
{
	instance_destroy()
}
if(bulletTimer > 0)
{
	bulletTimer--;
}
else
{
	instance_destroy()
}