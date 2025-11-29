zoom = 40;

camWidth = 16 * zoom; //Camera Width 640
camHeight = 9 * zoom; //Camera Height 360

camWidthTarget = 16;
camHeightTarget = 9;

target = oPlayer; //Camera Target

xTo = x; 
yTo = target.y; //Follow the target or Locate target
currentPlayerPosY = target.y; //target y position while grounded

xpos = 0; //camera x position
ypos = 0; //camera y position

isFullScreen = false;