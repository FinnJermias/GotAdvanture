#region GRAVITY
if (!isDashing && isMoving)
{
    ysp += grav;
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
	if(canBeDamagedTimer > 0)
	{
		canBeDamagedTimer--;
	}
	else
	{
		canBeDamagedTimer = canBeDamagedTimerRate;
		playerHealth -= 1;
	}
}
function InstaKill()
{
	playerHealth = 0;
}

//Unstuck Player(Cheat)
if(keyboard_check_pressed(ord("U")))
{
	ysp = 0;
	y -= 50;
}
#endregion

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
	ysp = -jumpPower;
}
else
{
	yPrev = y;
}

if(ysp < 0 && !keyboard_check(vk_space) && isDashing = false)
{
	// You kept HEAD version, this is correct
	ysp = max(ysp, -jumpPower/2.5); 
}
#endregion

#region Dash and Shooting
if ((keyboard_check_pressed(ord("X")) 
	|| keyboard_check_pressed(ord("M")) 
	|| keyboard_check_pressed(vk_lshift))
	&& canDash = true
	&& isDashing = false 
	&& dashCooldown <= 0)
{
	dashCooldown = dashCooldownMax;

	xsp = 0;
	ysp = 0;
	
	isShooting = true;
	isDashing = true;

	DashTimer = 4;
	dashAnimTimer = 15;

	if keyboard_check(ord("D")) || keyboard_check(vk_right) || keyboard_check(ord("J"))
	{
		isDashRight = true
		isKeyPress = true;
		xsp = dashPower;
		bulletDirectionX = -1;
		bulletRotation = 0;
	}
	else if keyboard_check(ord("A")) || keyboard_check(vk_left) || keyboard_check(ord("L")) 
	{
		isDashLeft = true
		isKeyPress = true;
		xsp = -dashPower;
		bulletDirectionX = 1;
		bulletRotation = -180;
	}
	
	if keyboard_check(ord("W")) || keyboard_check(vk_up) || keyboard_check(ord("K"))
	{
		isKeyPress = true;
		if(keyboard_check(vk_space)) ysp = -dashPower / 2.5;
		else ysp = -dashPower;
		
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
		else bulletRotation = 90;
		
	}
	else if keyboard_check(ord("S")) || keyboard_check(vk_down) || keyboard_check(ord("I"))
	{
		isKeyPress = true;
		if(keyboard_check(vk_space)) ysp = dashPower / 2.5;
		else ysp = dashPower;
		
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
		else bulletRotation = -90;
	}
	
	if isKeyPress = false
	{
		bulletRotation = 0;
		if(image_xscale = -1) xsp = -dashPower;
		else xsp = dashPower;
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

if isDashing = true
{
	DashTimer--;
	if DashTimer <= 0 isDashing = false;
}

if(dashAnimTimer > 0) dashAnimTimer--;
#endregion
#endregion

#region COLLISION
if(isAlive = true)
{
	move_and_collide(xsp, ysp, platformGround)
}

if(ysp >= 0)
{
	if(place_meeting(x , y + 1, platformGround))
	{
		ysp = 0;
		isGrounded = true;
		jumpHangTimer = jumpHangFrames;
	}
	else 
	{
		if(place_meeting(x , y + ysp, platformGround) && isGrounded = false)
		{
			y += 1;
			isGrounded = true;
		}
		else
		{
			isGrounded = false;
			JumpMercy();
		}
	}
}
else
{
	if place_meeting(x , y + ysp, platformGround)
	{
		ysp = 0;
		jumpHangTimer = jumpHangFrames;
	}
	else 
	{
		isGrounded = false;
		JumpMercy();
	}
}

function JumpMercy()
{
	isJumpMercy = true;
	if(jumpHangTimer >= 0) jumpHangTimer--;
	else isJumpMercy = false;
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
		if (image_xscale == -1) sprite_index = sPlayerDashLeft;
		else sprite_index = sPlayerDashRight;
	}
}
else
{
	if (xPrev != x)
	{
		sprite_index = sPlayerMove;
		image_speed = 1;
	}
	else sprite_index = sPlayerIdle;

	if (isGrounded = false) sprite_index = sPlayerJump;
}
#endregion

#region Knockback
if(knockbackTimer > 0)
{
	isMoving = false;
	if(x > knocbacker.x)
		xsp = (knockbackX * abs(x - knocbacker.x)) / 10;
	else
		xsp = -(knockbackX * abs(x - knocbacker.x)) / 10;
	
	if(knockbackTimer > 5)
		ysp = -knockbackY;
	else
		ysp += grav;

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
		var vx = camera_get_view_x(view_camera[0]);
		var vy = camera_get_view_y(view_camera[0]);
		var vw = camera_get_view_width(view_camera[0]);
		var vh = camera_get_view_height(view_camera[0]);
		
		isGameOver = true;
		instance_create_layer(vx + vw/2, vy + vh/2, "Instances_UI", oGameOver);
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
    gemCount += 1;
    with (gem) instance_destroy();
}
#endregion

// DASH COOLDOWN COUNTER
if (dashCooldown > 0) dashCooldown--;

// interactable door
show_prompt = false;
show_prompt = (instance_place(x, y, oExitDoor) != noone) 
           || (instance_place(x, y, oGiantSewer) != noone);

if (show_prompt && keyboard_check_pressed(ord("G")))
{
    room_goto_next();
}
