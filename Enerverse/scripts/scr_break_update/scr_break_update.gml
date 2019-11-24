if (global.breaking)
{
	global.breaking_progress += (1 / global.breaking_hardness) * (delta_time / 1000000);
	if (global.breaking_progress > 1.0)
	{
		global.breaking = false;
		var drops = scr_block_get_drops(scr_block_get_unlocalized_name_from_id(array_get(scr_block_get(global.breaking_x, global.breaking_y), 0)));
		scr_block_set(global.breaking_x, global.breaking_y, "EnerverseVin/block_air", "0,");
		
		for (var i = 0; i < array_length_1d(drops); i++)
		{
			scr_inventory_add(array_get(drops[i], 0), real(array_get(drops[i], 1)));
		}
	}
}