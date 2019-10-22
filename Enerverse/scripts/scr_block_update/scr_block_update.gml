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

/* { +x, -y } */var b0 = array_get(scr_block_get(floor(newX - 0.1875), floor(newY - 1)), 0) != scr_get_block_id("EnerverseVin/block_air");
/* { -x, -y } */var b1 = array_get(scr_block_get(floor(newX - 0.8125), floor(newY - 1)), 0) != scr_get_block_id("EnerverseVin/block_air");
/* { +x, +y } */var b2 = array_get(scr_block_get(floor(newX - 0.1875), floor(newY + 0.625)), 0) != scr_get_block_id("EnerverseVin/block_air");
/* { -x, +y } */var b3 = array_get(scr_block_get(floor(newX - 0.8125), floor(newY + 0.625)), 0) != scr_get_block_id("EnerverseVin/block_air");
/* { +x,  y } */var b4 = array_get(scr_block_get(floor(newX - 0.1875), floor(newY - 0.1875)), 0) != scr_get_block_id("EnerverseVin/block_air");
/* { -x,  y } */var b5 = array_get(scr_block_get(floor(newX - 0.8125), floor(newY - 0.1875)), 0) != scr_get_block_id("EnerverseVin/block_air");

global.debug = b4;

if ((b0 || b2 || b4) && newX > global.player_x)
	newX = round(global.player_x) + 0.1875;

if ((b1 || b3 || b5) && newX < global.player_x)
	newX = round(global.player_x) - 0.1875;

if (b0 || b1 || b2 || b3 || b4 || b5)
{
	if (newY < global.player_y)
		newY = floor(global.player_y);
	else if (newY > global.player_y)
		newY = floor(global.player_y) + 0.375;
}

global.player_x = newX;
global.player_y = newY;
