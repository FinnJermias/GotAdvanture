visible = true //make player visible

grav = 0.4

xPrev = 0
yPrev = 0
xsp = 0
ysp = 0

playerSpd = 3 //speed
jumpPower = 8 //jump

DashTimer = 0
dashPower = 20 //the xsp value while dashing
dashAnimTimer = 0
isDashLeft = false;
isDashRight = false;

isShooting = false;
bulletDirectionX = 0;
bulletDirectionY = 0;
bulletRotation = 0;
isVerticalDash = false;

isDashing = false //check if player currently dashing
isKeyPress = false

isFacingLeft = false; //Check if the player facing left

isGameOver = false
isMoving = true
isAlive = true;
playerHealth = 3;
canBeDamagedTimer = 0;
canBeDamagedTimerRate = 15; //prevent the player getting damaged too fast

isGrounded = false; //check if the player on the ground
platformGround = [oPlatformEdge, oPlatformMiddle, oPlatformEdgeFull, oPlatformMiddleFull, oPlatformDiagonalDown, oPlatformDiagonalUp];
jumpHangFrames = 4;
jumpHangTimer = 0;
isJumpMercy = false;

canDash = true
dashCooldown = 0;        // current cooldown timer
dashCooldownMax = 60;    // 1 second cooldown (60 frames)

knockbackX = 0;
knockbackY = 0;
knockbackTimer = 0;
knocbacker = 0; //Object that Knockback the player

show_prompt = false;

gemCount = 0;  // starts at 0

