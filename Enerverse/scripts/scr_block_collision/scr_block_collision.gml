var newX = argument[0];
var newY = argument[1];
var colX = argument[2];
var colY = argument[3];

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
		//global.debug[6] = "left - double (defined)";
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
			//global.debug[6] = "left - single (interpolated)";
			b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air;
			b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air;
		}
	}
	else
	{//check single
		//global.debug[6] = "left - single (defined)";
		b_down = array_get(scr_block_get(px - 1, py - 1), 0) != id_air;
		b_up = array_get(scr_block_get(px - 1, hdpy), 0) != id_air;
	}
}
else
{//right state
	if (floor(newX + 0.1876) == px)
	{//check double
		//global.debug[6] = "right - double (defined)";
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
			//global.debug[6] = "right - single (interpolated)";
			b_down = array_get(scr_block_get(px, py - 1), 0) != id_air;
			b_up = array_get(scr_block_get(px, hdpy), 0) != id_air;
		}
	}
	else
	{//check single
		//global.debug[6] = "right - single (defined)";
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
		{
			newY = round(newY);
			colY = true;
		}
		else if (!m_up || b_up)
		{
			newY = floor(newY) + 0.375;
			colY = true;
		}
		
		newX = floor(newX) + 0.1875;
		colX = true;
	}
	
	if (m_left && b_left)
	{
		if ((!m_down || b_down) && !m_up)
		{
			newY = round(newY);
			colY = true;
		}
		else if (!m_up || b_up)
		{
			newY = floor(newY) + 0.375;
			colY = true;
		}
		
		newX = ceil(newX) - 0.1875;
		colX = true;
	}
	
	if ((!b_right || !m_right) && (!b_left || !m_left))
	{
		if (b_down)
		{
			newY = floor(newY) + 1;
			colY = true;
		}
		else if (b_up)
		{
			newY = floor(newY) + 0.375;
			colY = true;
		}
	}
}
else if (m_right && b_right)
{
	newX = floor(newX) + 0.1875;
	colX = true;
}
else if (m_left && b_left)
{
	newX = ceil(newX) - 0.1875;
	colX = true;
}

var result = array_create(4);

result[0] = newX;
result[1] = newY;
result[2] = colX;
result[3] = colY;

return result;