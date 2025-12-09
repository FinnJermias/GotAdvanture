// check collision between player and door
var p = instance_place(x, y, oPlayer);

if (p != noone)
{
    if (place_meeting(x, y, oPlayer))
{
    room_goto_next();
}
}

