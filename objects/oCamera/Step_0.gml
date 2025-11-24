if(target == oPlayer)
{
	if(oPlayer.isFacingLeft = true)
	{
		xTo = target.x - 75; //Follow the target or Locate target
	}
	else if(oPlayer.isFacingLeft = false)
	{
		xTo = target.x + 75; //Follow the target or Locate target
	}
	else
	{
		xTo = target.x
	}
}
else
{
	xTo = target.x
}


x += (xTo - x)/20; //Smooth Camera(move more slower when it reaches the target until stop(camera.x == target.x))

xpos = x - camWidth/2 //Make camera.x in the middle(640/2)
xpos = clamp(xpos, 0, room_width-camera_get_view_width(view_camera[0])) //Make camera cannot overpass the border in the room


if(oPlayer.isGrounded = true)
{
	currentPlayerPosY = target.y;
	yTo = target.y;
	y += (yTo - y)/20 //Smooth Camera	
}
else if(oPlayer.isGrounded = false && target.y < currentPlayerPosY - 100)
{
	yTo = target.y;
	y += (yTo - y)/20 //Smooth Camera
}
//if the statement is just (isGrounded = false) it does nothing to the y, make the camera.y stay still

ypos = y - camHeight/2 //Make camera.y in the middle(360/2)
ypos = clamp(ypos, 0, room_height-camera_get_view_height(view_camera[0]))


camera_set_view_pos(view_camera[0], xpos, ypos);
	
