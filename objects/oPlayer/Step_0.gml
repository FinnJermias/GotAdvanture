
#region Gravity
if(isDashing = false)
{	
	
		if(isGrounded = false && dashAnimTimer > 0)
		{
			ysp = 0 //make player stop after dash
			ysp += grav //Gravity
		}
		else if(isGrounded = false)
		{
			ysp += grav
		}
		xsp = 0 //Reset xsp
	}

#endregion

if(playerHealth <= 0)
{
	isAlive = false
}

if(isAlive = false)
{
	sprite_index = sDead
	solid = false
}

#region MOVEMENT
#region Move

if(isMoving = true && isAlive = true)
{
	if keyboard_check(ord("D")) || keyboard_check(vk_right) || keyboard_check(ord("L"))
	{
		if isDashing = false
		{
			isFacingLeft = false
			xsp = playerSpd
		}
	}
	else
	{
		xPrev = x
	}

	if keyboard_check(ord("A")) || keyboard_check(vk_left) || keyboard_check(ord("J"))
	{
		if isDashing = false
		{
			isFacingLeft = true
			xsp = -playerSpd
		}
	}
	else
	{
		xPrev = x
	}

	if (isFacingLeft = true)
	{
		image_xscale = -1
	}
	else
	{
		image_xscale = 1
	}

	//Facing up and down
	if keyboard_check(ord("W")) || keyboard_check(vk_up)
	{
		//Look Up
	}


	if keyboard_check(ord("S")) || keyboard_check(vk_down)
	{
		//look down
	}
}
#endregion
#region Jump
if(keyboard_check_pressed(vk_space) && (isGrounded = true || isJumpMercy = true) && isAlive = true)
{
	ysp = -jumpPower //max jump power
}
else
{
	yPrev = y
}
if(ysp < 0 && !keyboard_check(vk_space) && isDashing = false)
{
	ysp = max(ysp, -jumpPower/2.5) //If let go of space, ysp will not be -2.5
}
#endregion
#region Dash
if (keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("M")) || keyboard_check_pressed(vk_lshift))
&& isDashing = false 
&& isAlive = true
&& dashCooldown <= 0 // ← NEW: only dash if NOT cooling down
{
	dashCooldown = dashCooldownMax; // start cooldown

	xsp = 0
	ysp = 0
	
	isShooting = true
	
	isDashing = true
	DashTimer = 4 //how long the steps to dash, less means more faster but much shorter
	dashAnimTimer = 15 //dash Animation
	if keyboard_check(ord("D")) || keyboard_check(vk_right) || keyboard_check(ord("J"))
	{
		isKeyPress = true
		xsp = dashPower //the xsp value while dashing
		bulletDirectionX = -1
		
	}
	else if keyboard_check(ord("A")) || keyboard_check(vk_left) || keyboard_check(ord("L")) 
	{
		isKeyPress = true
		xsp = -dashPower
		bulletDirectionX = 1
	}
	
	if keyboard_check(ord("W")) || keyboard_check(vk_up) || keyboard_check(ord("K"))
	{
		isKeyPress = true
		ysp = -dashPower
		bulletDirectionY = 1
		
	}
	else if keyboard_check(ord("S")) || keyboard_check(vk_down) || keyboard_check(ord("I"))
	{
		isKeyPress = true
		ysp = dashPower
		bulletDirectionY = -1
	}
	
	if isKeyPress = false
	{
		if(image_xscale = -1)
		{
			xsp = -dashPower
		}
		else
		{
			xsp = dashPower	
		}
	}
	isKeyPress = false
}

if(isShooting = true)
{
	instance_create_layer(x, y, "Instances", oBullet)
	bulletDirectionX = 0
	bulletDirectionY = 0
	isShooting = false
}

if isDashing = true //dash timer
{
	DashTimer--
	if DashTimer <= 0
	{
		isDashing = false
	}
}

if(dashAnimTimer > 0)
{
	dashAnimTimer--	
}
#endregion
#endregion

#region COLLISION
if(isAlive = true)
{
	move_and_collide(xsp, ysp, platformGround)//make player can move, and can collide with array platformGround
}

if(ysp >= 0)//check if the player fall
{
	if(place_meeting(x , y + 1, platformGround))//check if the player collide with platformGround 1 pixel below(y + 1)
	{
		ysp = 0 //stop the gravity if meeting oPlatform
		isGrounded = true 
		jumpHangTimer = jumpHangFrames
	}
	else 
	{
		//unstuck player on the ground
		if(place_meeting(x , y + ysp, platformGround) && isGrounded = false)//check if the player stop before (y + 1) in the ground
		{
			y += 1 //move player 1 pixel down so it doesn't stuck in jump situation
			isGrounded = true
		}
		else
		{
			isGrounded = false
			JumpMercy()
		}
	}
}
else
{
	if place_meeting(x , y + ysp, platformGround)
	{
		ysp = 0 //stop the gravity if meeting oPlatform
		jumpHangTimer = jumpHangFrames
	}
	else 
	{
		isGrounded = false
		JumpMercy()
	}
}

function JumpMercy()
{
	isJumpMercy = true
	if(jumpHangTimer >= 0)
	{
		jumpHangTimer--
	}
	else
	{
		isJumpMercy = false
	}	
}

#endregion

#region ANIMATION

if (isAlive = true)
{
    
    if (dashAnimTimer > 0)
    {
       
        if (keyboard_check(ord("W")) || keyboard_check(vk_up))
        {
            if (keyboard_check(ord("D")) || keyboard_check(vk_right))
                sprite_index = sPlayerDashRightUp;
            else if (keyboard_check(ord("A")) || keyboard_check(vk_left))
                sprite_index = sPlayerDashLeftUp;
            else
                sprite_index = sPlayerDashUp;
        }
        else if (keyboard_check(ord("S")) || keyboard_check(vk_down))
        {
            if (keyboard_check(ord("D")) || keyboard_check(vk_right))
                sprite_index = sPlayerDashRightDown;
            else if (keyboard_check(ord("A")) || keyboard_check(vk_left))
                sprite_index = sPlayerDashLeftDown;
            else
                sprite_index = sPlayerDashDown;
        }
        else if (keyboard_check(ord("D")) || keyboard_check(vk_right))
        {
            sprite_index = sPlayerDashRight;
        }
        else if (keyboard_check(ord("A")) || keyboard_check(vk_left))
        {
            sprite_index = sPlayerDashLeft;
        }
        else
        {
            // No key pressed → just dash forward based on facing
            if (image_xscale == -1)
                sprite_index = sPlayerDashLeft;
            else
                sprite_index = sPlayerDashRight;
        }

    }
    else
    {
        // Idle / Move
        if (xPrev != x)
        {
            sprite_index = sPlayerMove;
            image_speed = 1;
        }
        else
        {
            sprite_index = sPlayerIdle;
        }

        // Jump
        if (isGrounded = false)
        {
            sprite_index = sPlayerJump;
        }
    }
}

#endregion


#endregion

#region Collect
if (place_meeting(x, y, oGems)) {
    var gem = instance_place(x, y, oGems);
    with (gem) instance_destroy();
}
#endregion

// DASH COOLDOWN COUNTER
if (dashCooldown > 0)
{
    dashCooldown--;
}
