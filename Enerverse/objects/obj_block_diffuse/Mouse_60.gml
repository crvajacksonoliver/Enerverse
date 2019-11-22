if (mouse_x < 300 && mouse_y < room_height - 50)
{
	if (global.inventory_open && global.inventory_marker > 0)
	{
		global.inventory_marker--;
	}
}
else
{
	global.active_slot = (global.active_slot + 1) % 15;
}