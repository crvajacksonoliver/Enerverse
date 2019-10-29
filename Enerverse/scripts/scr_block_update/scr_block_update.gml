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

var disX = abs(newX - global.player_x);
var disY = abs(newY - global.player_y);

var fcX = newX - global.player_x;
var fcY = newY - global.player_y;

global.debug[7] = fcX;
global.debug[8] = fcY;

var maxRange = 0.1875;

var times = max(ceil(disX / maxRange), ceil(disY / maxRange));

if (times == 0)
	return;

var parX = fcX / times;
var parY = fcY / times;

var calX = newX + parX;
var calY = newY + parY;

global.debug[9] = times;

for (var i = 0; i < times; i++)
{
	var result = scr_block_collision(calX, calY);
	
	//global.debug[7] = result[0] - calX;
	
	calX = result[0] + parX;
	calY = result[1] + parY;
}

global.player_x = calX;
global.player_y = calY;
