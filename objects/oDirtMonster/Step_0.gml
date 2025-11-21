ysp += grav //apply gravity
#region LOGIC and MOVEMENT
if(oPlayer.isAlive = false)
{
	solid = false
}

if(isAlive = true)
{
	xsp = moveSpd //give xsp a value
}
else
{
	xsp = 0
}
move_and_collide(xsp, ysp, oPlayer.platformGround) //make the object can move and collide with platform/wall
#endregion

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

#region KNOCKBACK
/*if(isKnockback = true)
{
	knockbackTimer--
	if(knockbackTimer <= 0)
	{
		isKnockback = false
		oPlayer.isMoving = true
		//oPlayer.playerHealth -= 1 //decrease player health by 1
	}
	else
	{
		oPlayer.isMoving = false
		
		if(isFacingLeft = false)
		{
			if(x > oPlayer.x)
			{
				oPlayer.xsp = sign(-xsp) * knockbackPower //make the player move back when touch the object
			}
			else
			{
				oPlayer.xsp = sign(xsp) * knockbackPower //make the player move back when touch the object
			}
		}
		else if(isFacingLeft = true)
		{
			if(x < oPlayer.x)
			{
				oPlayer.xsp = sign(-xsp) * knockbackPower //make the player move back when touch the object
			}
			else
			{
				oPlayer.xsp = sign(xsp) * knockbackPower //make the player move back when touch the object
			}
		}
		oPlayer.ysp = 4
	}
}*/


#endregion
