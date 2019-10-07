var zm_speed = 2000000;//more is slower

var mv_speed = 500000;

if (keyboard_check_direct(vk_shift))
	var mv_speed = 300000;
if (keyboard_check_direct(vk_control))
	var mv_speed = 2000000;

if (keyboard_check_direct(ord("A")))
{
	var nx = global.player_x - (delta_time / mv_speed);
	if (nx < 1)
	{
		global.player_x = 1;
	}
	else
	{
		global.player_x = nx;
	}
}

if (keyboard_check_direct(ord("D")))
{
	var nx = global.player_x + (delta_time / mv_speed);
	if (nx > global.active_world_width)
	{
		global.player_x = global.active_world_width;
	}
	else
	{
		global.player_x = nx;
	}
}

if (keyboard_check_direct(ord("W")))
{
	var ny = global.player_y + (delta_time / mv_speed);
	if (ny > global.active_world_width)
	{
		global.player_y = global.active_world_height;
	}
	else
	{
		global.player_y = ny;
	}
}

if (keyboard_check_direct(ord("S")))
{
	var ny = global.player_y - (delta_time / mv_speed);
	if (ny < 1)
	{
		global.player_y = 1;
	}
	else
	{
		global.player_y = ny;
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
if (keyboard_check_direct(ord("1")))
	global.player_x = 1;
if (keyboard_check_direct(ord("2")))
	global.player_x = 2;
if (keyboard_check_direct(ord("3")))
	global.player_x = 3;
if (keyboard_check_direct(ord("4")))
	global.player_x = 4;
if (keyboard_check_direct(ord("5")))
	global.player_x = 5;