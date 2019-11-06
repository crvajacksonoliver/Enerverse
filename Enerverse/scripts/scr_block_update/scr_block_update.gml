if (!global.in_world || global.game_paused)
	return;

var zm_speed = 1500000;//more is slower
var fall_speed = 30000;//more is slower
var fall_lerp_speed = 500000;//more is slower
var jump_power = 70000;//more is slower
var jump_distance = 250000;//more is slower;

var mv_speed = 150000;
var mv_lerp_speed = 60000;

if (keyboard_check_direct(vk_shift))
	var mv_speed = 100000;
if (keyboard_check_direct(vk_control))
	var mv_speed = 250000;

var newX = global.player_x;
var newY = global.player_y;

if (keyboard_check_direct(ord("A")) && !global.moving_left)
{
	global.moving_left = true;
	global.moving_right = false;
	global.cplayer_x = (delta_time / mv_lerp_speed);
	
	var nx = -1 * (delta_time / mv_speed) * global.cplayer_x;
	if (nx + newX < 1)
	{
		newX = 1;
	}
	else
	{
		newX += nx;
	}
}
else if (keyboard_check_direct(ord("A")) && global.moving_left)
{
	global.cplayer_x += (delta_time / mv_lerp_speed);
	
	if (global.cplayer_x > 1.0)
		global.cplayer_x = 1.0;
	
	var nx = -1 * (delta_time / mv_speed) * global.cplayer_x;
	if (nx + newX < 1)
	{
		newX = 1;
	}
	else
	{
		newX += nx;
	}
}
else if (!keyboard_check_direct(ord("A")) && global.moving_left)
{
	global.cplayer_x -= (delta_time / mv_lerp_speed);
	
	if (global.cplayer_x > 0.0)
	{
		var nx = -1 * (delta_time / mv_speed) * global.cplayer_x;
		if (nx + newX < 1)
		{
			newX = 1;
		}
		else
		{
			newX += nx;
		}
	}
	else
	{
		global.moving_left = false;
		global.cplayer_x = 0.0;
	}
}

if (keyboard_check_direct(ord("D")) && !global.moving_right)
{
	global.moving_right = true;
	global.moving_left = false;
	global.cplayer_x = (delta_time / mv_lerp_speed);
	
	var nx = (delta_time / mv_speed) * global.cplayer_x;
	if (nx + newX > global.active_world_width)
	{
		newX = global.active_world_width;
	}
	else
	{
		newX += nx;
	}
}
else if (keyboard_check_direct(ord("D")) && global.moving_right)
{
	global.cplayer_x += (delta_time / mv_lerp_speed);
	
	if (global.cplayer_x > 1.0)
		global.cplayer_x = 1.0;
	
	var nx = (delta_time / mv_speed) * global.cplayer_x;
	if (nx + newX > global.active_world_width)
	{
		newX = global.active_world_width;
	}
	else
	{
		newX += nx;
	}
}
else if (!keyboard_check_direct(ord("D")) && global.moving_right)
{
	global.cplayer_x -= (delta_time / mv_lerp_speed);
	
	if (global.cplayer_x > 0.0)
	{
		var nx = (delta_time / mv_speed) * global.cplayer_x;
		if (nx + newX > global.active_world_width)
		{
			newX = global.active_world_width;
		}
		else
		{
			newX += nx;
		}
	}
	else
	{
		global.moving_right = false;
		global.cplayer_x = 0.0;
	}
}

if (keyboard_check_direct(ord("W")) && global.player_grounded)
{
	global.jumping = true;
	
	var ny = (delta_time / jump_power) * (1 - global.jump_dec);
	if (newY + ny > global.active_world_height)
	{
		newY = global.active_world_height;
	}
	else
	{
		newY += ny;
	}
}
else if (global.jumping && keyboard_check_direct(ord("W")) && global.jump_dec < 0.7)
{
	global.jump_dec += (delta_time / jump_distance);
	
	var ny = (delta_time / jump_power) * (1 - global.jump_dec);
	if (newY + ny > global.active_world_height)
	{
		newY = global.active_world_height;
	}
	else
	{
		newY += ny;
	}
}
else if (global.jumping && !keyboard_check_direct(ord("W")) && global.jump_dec < 0.7)
{
	global.jump_dec = 0.7;
	
	var ny = (delta_time / jump_power) * (1 - global.jump_dec);
	if (newY + ny > global.active_world_height)
	{
		newY = global.active_world_height;
	}
	else
	{
		newY += ny;
	}
}
else if (global.jumping && global.jump_dec >= 0.7)
{
	global.jump_dec += (delta_time / jump_distance);
	
	var ny = (delta_time / jump_power) * (1 - global.jump_dec);
	if (newY + ny > global.active_world_height)
	{
		newY = global.active_world_height;
	}
	else
	{
		newY += ny;
	}
	
	if (global.jump_dec > 1.0)
	{
		global.jumping = false;
		global.jump_dec = 0.0;
	}
}

if (global.player_grounded)
{
	global.cplayer_y = 0.0;
}
else if (!global.jumping)
{
	if (global.cplayer_y + (delta_time / fall_lerp_speed) > 1.0)
		global.cplayer_y = 1.0;
	else
		global.cplayer_y += (delta_time / fall_lerp_speed);
	
	var ny = -1 * (delta_time / fall_speed) * global.cplayer_y;
	if (newY + ny < 1)
	{
		newY = 1;
	}
	else
	{
		newY += ny;
	}
}

if (keyboard_check_pressed(ord("E")))
{
	if (global.zoom_factor == 0.5)
		global.zoom_factor = 1.0;
	else if (global.zoom_factor == 1.0)
		global.zoom_factor = 2.0;
}

if (keyboard_check_pressed(ord("Q")))
{
	if (global.zoom_factor == 2.0)
		global.zoom_factor = 1.0;
	else if (global.zoom_factor == 1.0)
		global.zoom_factor = 0.5;
}

var disX = abs(newX - global.player_x);
var disY = abs(newY - global.player_y);

var fcX = newX - global.player_x;
var fcY = newY - global.player_y;

//global.debug[7] = fcX;
//global.debug[8] = fcY;

if (fcX == 0 && fcY == 0)
	return;

var maxRange = 0.1875;

var times = max(ceil(disX / maxRange), ceil(disY / maxRange)) + 1;

var parX = fcX / times;
var parY = fcY / times;

var calX = global.player_x;
var calY = global.player_y;

var colX = false;
var colY = false;
global.player_grounded = false;

for (var i = 0; i < times; i++)
{
	if (!colX)
		calX += parX;
	if (!colY)
		calY += parY;
	
	var result = scr_block_collision(calX, calY, colX, colY);
	
	//global.cplayer_y = result[4];
	//global.debug[1] = result[4];
	
	colX = result[2];
	colY = result[3];
	
	calX = result[0];
	calY = result[1];
}

global.player_x = calX;
global.player_y = calY;
