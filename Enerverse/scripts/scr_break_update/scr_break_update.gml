if (global.breaking)
{
	global.breaking_progress += (1 / global.breaking_hardness) * (delta_time / 1000000);
	if (global.breaking_progress > 1.0)
	{
		global.breaking = false;
		scr_block_set(global.breaking_x, global.breaking_y, "EnerverseVin/block_air", "0,");
	}
}