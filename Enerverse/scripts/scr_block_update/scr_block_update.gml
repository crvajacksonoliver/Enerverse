var c_x = 0;
var c_y = 0;
var hold_c = false;

var c_speed = 0.5;
var c_maxspeed = c_speed * 20;

if (keyboard_check_direct(ord("A")))
{
	if (global.lplayer_x + c_x < c_maxspeed && global.lplayer_x + c_x > c_maxspeed * -1)
		c_x = c_speed * (delta_time / 100000);
	else
		hold_c = true;
}

if (keyboard_check_direct(ord("D")))
{
	if (global.lplayer_x + c_x < c_maxspeed && global.lplayer_x + c_x > c_maxspeed * -1)
		c_x = c_speed * -1 * (delta_time / 100000);
	else
		hold_c = true;
}

if (c_x == 0)
{
	if (!hold_c)
		global.lplayer_x *= (delta_time / 100000);
}
else
{
	global.lplayer_x += c_x;
}

global.player_x += global.lplayer_x;
global.player_y += global.lplayer_y;