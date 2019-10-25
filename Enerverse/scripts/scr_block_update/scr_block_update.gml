var zm_speed = 1500000;//more is slower

var mv_speed = 50000;

if (keyboard_check_direct(vk_shift))
	var mv_speed = 300000;
if (keyboard_check_direct(vk_control))
	var mv_speed = 5000000;

var newX = global.player_x;
var newY = global.player_y;

if (keyboard_check_direct(ord("A")))
{
	var nx = global.player_x - (delta_time / mv_speed);
	if (nx < 1)
	{
		newX = 1;
	}
	else
	{
		newX = nx;
	}
}

if (keyboard_check_direct(ord("D")))
{
	var nx = global.player_x + (delta_time / mv_speed);
	if (nx > global.active_world_width)
	{
		newX = global.active_world_width;
	}
	else
	{
		newX = nx;
	}
}

if (keyboard_check_direct(ord("W")))
{
	var ny = global.player_y + (delta_time / mv_speed);
	if (ny > global.active_world_height)
	{
		newY = global.active_world_height;
	}
	else
	{
		newY = ny;
	}
}

if (keyboard_check_direct(ord("S")))
{
	var ny = global.player_y - (delta_time / mv_speed);
	if (ny < 1)
	{
		newY = 1;
	}
	else
	{
		newY = ny;
	}
}

if (keyboard_check_direct(ord("E")))
{
	var nz = global.zoom_factor + (delta_time / zm_speed);
	if (nz > 2.0)
	{
		global.zoom_factor = 2.0;
	}
	else
	{
		global.zoom_factor = nz;
	}
}

if (keyboard_check_direct(ord("Q")))
{
	var nz = global.zoom_factor - (delta_time / zm_speed);
	if (nz < 0.5)
	{
		global.zoom_factor = 0.5;
	}
	else
	{
		global.zoom_factor = nz;
	}
}

if (abs(newX - global.player_x) > 1)
{
	if (newX < global.player_x)
		newX = global.player_x - 1;
	else
		newX = global.player_x + 1;
}

if (abs(newY - global.player_y) > 1)
{
	if (newY < global.player_y)
		newY = global.player_y - 1;
	else
		newY = global.player_y + 1;
}

var id_air = scr_get_block_id("EnerverseVin/block_air");

global.px = floor(global.player_x);
global.py = floor(global.player_y);

global.player_x = newX;
global.player_y = newY;
