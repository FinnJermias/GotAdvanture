grav = 0.4 //Gravity

xsp = 0 //x speed
ysp = 0 //y Speed
moveSpd = 1 //Speed Value(for x)

if(image_xscale = 1)//Check if object facingLeft (xscale = 1, facing left))
{
	isFacingLeft = true
	moveSpd = -moveSpd //set moveSpd to (-), so its move to the left
}
else
{
	isFacingLeft = false
	moveSpd = +moveSpd
}

facingTimer = 0; //prevent the object from glicthing when touch platform/wall due to high framerate
facingRate = 5;

knockbackX = 0;
knockbackY = 0;
knockbackTimer = 0;

isMoving = true;
isAlive = true; //Check if the object alive(currently no use)