ysp += grav //apply gravity
#region LOGIC and MOVEMENT
if(oPlayer.isAlive = false)
{
	solid = false
}

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

//KnockbackStep(oDirtMonster, oPlayer)
#endregion