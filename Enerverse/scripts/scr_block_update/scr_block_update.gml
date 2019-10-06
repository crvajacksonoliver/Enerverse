var mv_speed = 500000;//more is slower

if (keyboard_check_direct(ord("A")))
{
	var nx = global.player_x - (delta_time / mv_speed);
	if (nx < 0)
	{
		global.player_x = 0;
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
	if (ny < 0)
	{
		global.player_y = 0;
	}
	else
	{
		global.player_y = ny;
	}
}

if (keyboard_check_direct(ord("E")))
{
	var nz = global.zoom_factor + (delta_time / 1000000);
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
	var nz = global.zoom_factor - (delta_time / 1000000);
	if (nz < 0.5)
	{
		global.zoom_factor = 0.5;
	}
	else
	{
		global.zoom_factor = nz;
	}
}
