global.active_world_blocks = array_create(global.active_world_width * global.active_world_height * 2, 0);

for (var i = 0; i < global.active_world_width * global.active_world_height; i++)
{
	if (i < global.active_world_width * 3)
		global.active_world_blocks[i * 2] = scr_get_block_id("EnerverseVin/block_sod");
	else
		if (round(random(1)) == 0 && i < global.active_world_width * 4)
		{
			global.active_world_blocks[i * 2] = scr_get_block_id("EnerverseDecor/block_lantern");
		}
		else
		{
			global.active_world_blocks[i * 2] = scr_get_block_id("EnerverseVin/block_air");
		}
	
	global.active_world_blocks[i * 2 + 1] = "";
}