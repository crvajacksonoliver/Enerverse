if (mouse_x < 300 && mouse_y < room_height - 50)
{
	if (global.inventory_open && global.inventory_marker < ds_map_size(global.player_inventory) - 1 && ds_map_size(global.player_inventory) > 0)
	{
		global.inventory_marker++;
	}
}
else
{
	global.active_slot = (global.active_slot - 1) % 15;
	if (global.active_slot < 0)
		global.active_slot = 14;	
}