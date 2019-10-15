global.player_x = 1.0;
global.player_y = 1.0;

global.zoom_factor = 1.0;

global.debug_menu = array_create(1);
global.settings = array_create(2);

global.settings[0] = true;//enable debug menu
global.settings[1] = true; //enable bloom

global.active_world_width = 10;
global.active_world_height = 10;

//list of mods as text (file names)
global.modlist = ds_list_create();

//default state as text inline with the modlist
global.asset_registry = [];
global.block_registry = [];
global.visual_registry = [];

global.block_ids = ds_list_create();

//2d array inline with the modlist
global.external_calls = [];

scr_craft_poll();

var player_image = sprite_add("workingset/player.png", 1, false, false, 0, 0);
global.current_player = player_image;

//setup world

global.active_world_blocks = array_create(global.active_world_width * global.active_world_height * 2, 0);

for (var i = 0; i < global.active_world_width * global.active_world_height; i++)
{
	if (round(random(1)) == 0)
	{
		global.active_world_blocks[i * 2] = scr_get_block_id("EnerverseVin/block_sod");
	}
	else
	{
		global.active_world_blocks[i * 2] = scr_get_block_id("EnerverseDecor/block_lantern");
	}
	
	global.active_world_blocks[i * 2 + 1] = "";
}