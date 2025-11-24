// check collision between player and door
var p = instance_place(x, y, oPlayer);

if (p != noone)
{
    if (keyboard_check_pressed(ord("g")) || keyboard_check_pressed(ord("G")))
{
    room_goto(Room2);
}
}

