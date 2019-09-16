var c_x = 0;
var c_y = 0;
var hold_c = false;

var c_speed = 0.5;
var c_maxspeed = c_speed * 4;

if (keyboard_check_direct(ord("A")))
{
	if (global.lplayer_x + c_x < c_maxspeed && global.lplayer_x + c_x > c_maxspeed * -1)
	{
		c_x = c_speed * (delta_time / 100000);
	}
	else
	{
		hold_c = true;
		c_x = c_maxspeed;
	}
}

if (keyboard_check_direct(ord("D")))
{
	if (global.lplayer_x + c_x < c_maxspeed && global.lplayer_x + c_x > c_maxspeed * -1)
	{
		c_x = c_speed * -1 * (delta_time / 100000);
	}
	else
	{
		hold_c = true;
		c_x = c_maxspeed * -1;
	}
}

if (keyboard_check_direct(ord("W")))
{
	global.lplayer_y = 2;
}

if (keyboard_check_direct(ord("S")))
{
	global.lplayer_y = -2;
}

if (!keyboard_check_direct(ord("W")) && !keyboard_check_direct(ord("S")))
{
	global.lplayer_y = 0;
}

if (!hold_c)
{
	if (c_x == 0)
	{
		global.lplayer_x *= (delta_time / 100000);
	}
	else
	{
		global.lplayer_x += c_x;
	}
}
else
{
	//global.debug = 1;
	global.lplayer_x = c_x;
}

global.debug = keyboard_check_direct(ord("A"));

global.player_x += global.lplayer_x;
global.player_y += global.lplayer_y;

if (global.player_x > 0)
{
	global.player_x = 0;
	global.lplayer_x = 0;
}

if (global.player_y > 0)
{
	global.player_y = 0;
	global.lplayer_y = 0;
}