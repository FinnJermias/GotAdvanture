#region Gravity
if(isDashing = false && isMoving = true)
{	
	ysp += grav; //Gravity
	xsp = 0; //Reset xsp
}
#endregion

#region LOGIC
if(playerHealth <= 0)
{
	isAlive = false;
	if(isGrounded = true)
	{
		isMoving = false;
	}
}

function DecreaseHealth()
{
	if(canBeDamagedTimer <= 0)
	{
		canBeDamagedTimer = canBeDamagedTimerRate;
		playerHealth -= 1;
	}
}
if(canBeDamagedTimer > 0)
{
	canBeDamagedTimer--;
}

//Unstuck Player(Cheat)
if(keyboard_check_pressed(ord("U")))
{
	ysp = 0;
	y -= 50;
}
#endregion

if(isAlive = true)
{
#region MOVEMENT
#region Move
if(isMoving = true)
{
	if (keyboard_check(ord("D")) || keyboard_check(vk_right))
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

	if (keyboard_check(ord("A")) || keyboard_check(vk_left))
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
}
#endregion
#region Jump
if(keyboard_check_pressed(vk_space) && (isGrounded = true || isJumpMercy = true))
{
	audio_play_sound(Carton_Jump, 1, false);
	ysp = -jumpPower //max jump power
}
else
{
	yPrev = y
}
if(ysp < 0 && !keyboard_check(vk_space) && isDashing = false)
{
	ysp = max(ysp, -jumpPower/2.5); //If let go of space, ysp will not be -2.5
}
#endregion
#region Dash and Shooting
if ((keyboard_check_pressed(ord("X")) || keyboard_check_pressed(ord("M")) || keyboard_check_pressed(vk_lshift)))
&& isDashing = false 
&& dashCooldown <= 0 // ← NEW: only dash if NOT cooling down
{
	image_yscale = 0.6;
	audio_play_sound(Big_Water_Splash_Sound_Effects, 0, false);
	dashCooldown = dashCooldownMax; // start cooldown

	xsp = 0;
	ysp = 0;
	
	isShooting = true;
	
	isDashing = true;
	layer_set_visible("Effect_ScreenShake", true); //Apply Screen Shake Layer
	DashTimer = 4; //how long the steps to dash, less means more faster but much shorter
	dashAnimTimer = 15; //dash Animation
	if keyboard_check(ord("D")) || keyboard_check(vk_right) || keyboard_check(ord("J"))
	{
		isDashRight = true
		isKeyPress = true;
		xsp = dashPower; //the xsp value while dashing
		bulletDirectionX = -1;
		bulletRotation = 0; //value for Rotation of the bullet
		
	}
	else if keyboard_check(ord("A")) || keyboard_check(vk_left) || keyboard_check(ord("L")) 
	{
		isDashLeft = true
		isKeyPress = true;
		xsp = -dashPower;
		bulletDirectionX = 1;
		bulletRotation = -180; //value for Rotation of the bullet
	}
	
	if keyboard_check(ord("W")) || keyboard_check(vk_up) || keyboard_check(ord("K"))
	{
		isKeyPress = true;
		if(keyboard_check(vk_space))
		{
			ysp = -dashPower / 2.5;
		}
		else
		{
			ysp = -dashPower;
		}
		bulletDirectionY = 1;

		if(isDashRight = true)
		{
			bulletRotation = 45;
			isDashRight = false;
		}
		else if(isDashLeft = true)
		{
			bulletRotation = 150;
			isDashLeft = false;
		}
		else
		{
			bulletRotation = 90;
		}
		
	}
	else if keyboard_check(ord("S")) || keyboard_check(vk_down) || keyboard_check(ord("I"))
	{
		isKeyPress = true;
		if(keyboard_check(vk_space))
		{
			ysp = dashPower / 2.5;
		}
		else
		{
			ysp = dashPower;
		}
		
		bulletDirectionY = -1;
		
		if(isDashRight = true)
		{
			bulletRotation = -45;
			isDashRight = false;
		}
		else if(isDashLeft = true)
		{
			bulletRotation = -150;
			isDashLeft = false;
		}
		else
		{
			bulletRotation = -90;
		}
	}
	
	if isKeyPress = false
	{
		bulletRotation = 0;
		if(image_xscale = -1)
		{
			xsp = -dashPower;
		}
		else
		{
			xsp = dashPower;
		}
	}
	isKeyPress = false;
}

if(isShooting = true)
{
	instance_create_layer(x, y, "Instances", oBullet);
	bulletDirectionX = 0;
	bulletDirectionY = 0;
	isShooting = false;
}

if isDashing = true //dash timer
{
	DashTimer--
	if DashTimer <= 0
	{
		image_yscale = 1;
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

//Make the player has a little bit of time to jump while leaving platform
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
		layer_set_visible("Effect_ScreenShake", false); //Deactivate Screen Shake Layer
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
#endregion

#region Knockback
if(knockbackTimer > 0)
{
	isMoving = false
	if(x > knocbacker.x)
	{
		//calculate position	within player and the enemy, then put the value on the power
		xsp = (knockbackX * abs(x - knocbacker.x)) / 10; 
	}
	else
	{
		xsp = -(knockbackX * abs(x - knocbacker.x)) / 10;
	}
	if(knockbackTimer > 5)
	{
		ysp = -knockbackY;	
	}
	else
	{
		ysp += grav;
	}
	knockbackTimer--;
}
else
{
	isMoving = true;
	knocbacker = 0;
}
#endregion
}
else
{
	sprite_index = sDead;
	solid = false;
	if(isGameOver = false)
	{
		var vx = camera_get_view_x(view_camera[0]); //grab the x value of viewport 0
		var vy = camera_get_view_y(view_camera[0]); //grab the y value of viewport 0
		var vw = camera_get_view_width(view_camera[0]); //grab the viewport width value
		var vh = camera_get_view_height(view_camera[0]); //grab the viewport height value
		
		isGameOver = true;
		instance_create_layer(vx + vw/2, vy +vh/2, "Instances_UI", oGameOver);	
		oCamera.target = oGameOver;
	}
	
	if(keyboard_check_pressed(vk_anykey))
	{
		isGameOver = false;
		room_restart();
	}
}

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