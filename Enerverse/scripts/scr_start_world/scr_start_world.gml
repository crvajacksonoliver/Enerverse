//setup world
scr_world_gen();

//set player
for (var i = 1; i < global.active_world_height - 1; i++)
{
	if (array_get(scr_block_get(floor(global.active_world_width / 2) - 1, i), 0) == scr_get_block_id("EnerverseVin/block_air") && array_get(scr_block_get(floor(global.active_world_width / 2) - 1, i + 1), 0) == scr_get_block_id("EnerverseVin/block_air"))
	{
		global.player_x = floor(global.active_world_width / 2);
		global.player_y = i + 1;
		break;
	}
}

global.in_world = true;