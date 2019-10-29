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

var maxRange = 0.1875;

if (abs(newX - global.player_x) > maxRange)
{
	if (newX < global.player_x)
		newX = global.player_x - maxRange;
	else
		newX = global.player_x + maxRange;
}

if (abs(newY - global.player_y) > maxRange)
{
	if (newY < global.player_y)
		newY = global.player_y - maxRange;
	else
		newY = global.player_y + maxRange;
}

var id_air = scr_get_block_id("EnerverseVin/block_air");
var hdpy = floor(newY - 0.375) + 1;
var horizontalState = floor(newX) == round(newX);

var px = floor(newX);
var py = floor(newY);

var b_down = false;
var b_up = false;
var b_left = false;
var b_right = false;

var m_down = newY < global.player_y;
var m_up = newY > global.player_y;
var m_left = newX < global.player_x;
var m_right = newX > global.player_x;

if (horizontalState)
{//left state
	if (floor(newX - 0.1876) == px)
	{//check double
		global.debug[6] = "left - double (defined)";
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air || array_get(scr_block_get(px, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air || array_get(scr_block_get(px, hdpy), 0) != id_air;
		
		if (m_down && b_down)
		{
			b_right = array_get(scr_block_get(px, py + 1), 0) != id_air || array_get(scr_block_get(px, py), 0) != id_air;
		}
		else
		{
			b_right = array_get(scr_block_get(px, py - 1), 0) != id_air || array_get(scr_block_get(px, py), 0) != id_air;
		}
		
		if (b_right)
		{
			global.debug[6] = "left - single (interpolated)";
			b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air;
			b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air;
		}
	}
	else
	{//check single
		global.debug[6] = "left - single (defined)";
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air;
	}
}
else
{//right state
	if (floor(newX + 0.1876) == px)
	{//check double
		global.debug[6] = "right - double (defined)";
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air || array_get(scr_block_get(px, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air || array_get(scr_block_get(px, hdpy), 0) != id_air;
		
		if (m_down && b_down)
		{
			b_left = array_get(scr_block_get(px - 1, py + 1), 0) != id_air || array_get(scr_block_get(px - 1, py), 0) != id_air;
		}
		else
		{
			b_left = array_get(scr_block_get(px - 1, py - 1), 0) != id_air || array_get(scr_block_get(px - 1, py), 0) != id_air;
		}
		
		if (b_left)
		{
			global.debug[6] = "right - single (interpolated)";
			b_down = array_get(scr_block_get(px, py - 1), 0) != id_air;
			b_up = array_get(scr_block_get(px, hdpy), 0) != id_air;
		}
	}
	else
	{//check single
		global.debug[6] = "right - single (defined)";
		b_down = array_get(scr_block_get(px, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px, hdpy), 0) != id_air;
	}
}

//apply collisions

if ((m_down && b_down) || (m_up && b_up))
{
	if (m_right && b_right)
	{
		if ((!m_down || b_down) && !m_up)
			newY = round(newY);
		else if (!m_up || b_up)
			newY = floor(newY) + 0.375;
		
		newX = floor(newX) + 0.1875;
	}
	
	if (m_left && b_left)
	{
		if ((!m_down || b_down) && !m_up)
			newY = round(newY);
		else if (!m_up || b_up)
			newY = floor(newY) + 0.375;
		
		newX = ceil(newX) - 0.1875;
	}
	
	if ((!b_right || !m_right) && (!b_left || !m_left))
	{
		if (b_down)
			newY = floor(newY) + 1;
		else if (b_up)
			newY = floor(newY) + 0.375;
	}
}
else if (m_right && b_right)
	newX = floor(newX) + 0.1875;
else if (m_left && b_left)
	newX = ceil(newX) - 0.1875;

global.player_x = newX;
global.player_y = newY;
