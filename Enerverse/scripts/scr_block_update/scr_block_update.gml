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
var hdpy = floor(newY - 0.375) + 1;
var horizontalState = floor(newX) == round(newX);

var px = floor(newX);
var py = floor(newY);
var fx = floor(global.player_x);
var fy = floor(global.player_y);

var b_down = false;
var b_up = false;
var b_left = false;
var b_right = false;

if (horizontalState)
{//left state
	if (floor(newX - 0.1875) == px)
	{//check double
		
		
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air || array_get(scr_block_get(px, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air || array_get(scr_block_get(px, hdpy), 0) != id_air;
		b_right = array_get(scr_block_get(px, fy - 1), 0) != id_air || array_get(scr_block_get(px, fy), 0) != id_air;
	}
	else
	{//check single
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air;
	}
}
else
{//right state
	if (floor(newX + 0.1875) == px)
	{//check double
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air || array_get(scr_block_get(px, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air || array_get(scr_block_get(px, hdpy), 0) != id_air;
	}
	else
	{//check single
		b_down = array_get(scr_block_get(px, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px, hdpy), 0) != id_air;
	}
}

//apply collisions

if (b_down && !b_left && !b_right)
	newY = floor(newY + 1);
if (b_up && !b_left && !b_right)
	newY = floor(newY) + 0.375;
if (b_left)
	newX = ceil(newX) - 0.1875;
if (b_right)
	newX = floor(newX) + 0.1875;

global.debug[0] = b_down;
global.debug[1] = b_up;
global.debug[2] = b_left;
global.debug[3] = b_right;

/*

(use_x == global.px + 0 && use_y == global.py - 1)
(use_x == global.px - 1 && use_y == global.py - 1)
(use_x == global.px + 0 && use_y == global.py + 0)
(use_x == global.px - 1 && use_y == global.py + 0)
(use_x == global.px + 0 && use_y == global.py + 1)
(use_x == global.px - 1 && use_y == global.py + 1)

*/

global.px = floor(newX);
global.py = floor(newY);

global.player_x = newX;
global.player_y = newY;
