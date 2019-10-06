global.player_x = 1.0;
global.player_y = 1.0;

global.zoom_factor = 1.0;

global.using_debug_menu = true;
global.debug_menu = array_create(1);

global.debug = 0;

global.active_world_width = 10;
global.active_world_height = 10;

global.active_world_blocks = array_create(global.active_world_width * global.active_world_height * 2, 0);

for (var i = 0; i < global.active_world_width * global.active_world_height; i++)
{
	if (i < 5)
	{
		global.active_world_blocks[i * 2] = 1;
	}
	else
	{
		global.active_world_blocks[i * 2] = 3;
	}
	
	//global.active_world_blocks[i * 2] = floor(random_range(1, 4));
	
	global.active_world_blocks[i * 2 + 1] = "";
}

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
