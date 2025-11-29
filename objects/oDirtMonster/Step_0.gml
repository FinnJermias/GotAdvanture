ysp += grav; //apply gravity

if(oPlayer.isAlive = false)
{
	solid = false;
}

if(isAlive = true)
{
	if(knockbackTimer > 0)
	{
		isMoving = false
		if(x > oPlayer.x)
		{
			xsp = knockbackX; //calculate position	within player and the enemy, then put the value on the power
		}
		else
		{
			xsp = -knockbackX;
		}
		ysp = -knockbackY;	
		knockbackTimer--;
	}
	else
	{
		xsp = moveSpd //give xsp a value
	}	

	move_and_collide(xsp, ysp, oPlayer.platformGround) //make the object can move and collide with platform/wall

	#region Collision
	if(place_meeting(x, y + 1, oPlayer.platformGround))
	{
		ysp = 0 //stop the ysp when toucing ground
	}

	if(place_meeting(x + sign(xsp), y, oPlayer.platformGround))
	{
		if(facingTimer > 0)
		{
			facingTimer-- //prevent glitching	
		}
		else
		{
			moveSpd = -moveSpd 
			if(moveSpd >= 0)
			{
				isFacingLeft = false	
			}
			else
			{
				isFacingLeft = true
			}
			facingTimer = facingRate
			image_xscale *= -1 //flip sprite
		}
	}
	#endregion
}
else
{
	instance_destroy();
}

#region LOGIC
if(dirtMonsterHealth <= 0)
{
	isAlive = false;
}
#endregion