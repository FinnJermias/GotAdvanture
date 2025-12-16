if (keyboard_check_pressed(vk_escape))
{
    game_end();
}
if (!variable_global_exists("gemCount"))
{
    global.gemCount = 0;
}