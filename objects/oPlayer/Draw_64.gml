 // Background bar
draw_rectangle_colour(20, 20, 220, 40, c_red, c_red, c_red, c_red, false);

// Current HP
var hpPerc = playerHealth / 3; // max HP = 3
draw_rectangle_colour(20, 20, 20 + (200 * hpPerc), 40, c_green, c_green, c_green, c_green, false);

// HP text
draw_set_colour(c_white);
draw_text(25, 45, "HP: " + string(playerHealth));

// DASH COOLDOWN BAR
var perc = 1 - (dashCooldown / dashCooldownMax);

// grey background bar
draw_rectangle_colour(20, 80, 220, 100, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);

// cooldown fill
draw_rectangle_colour(20, 80, 20 + (200 * perc), 100, c_aqua, c_aqua, c_aqua, c_aqua, false);

// text
if (dashCooldown > 0)
    draw_text(25, 100, "Dash Cooldown");
else
    draw_text(25, 100, "Dash Ready!");
