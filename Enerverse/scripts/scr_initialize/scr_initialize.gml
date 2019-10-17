global.player_x = 1.0;
global.player_y = 1.0;

global.zoom_factor = 1.0;
global.debug = 0.0;

global.debug_menu = array_create(1);

global.settings = array_create(2);
global.settings[0] = true;//enable debug menu
global.settings[1] = true;//enable bloom
global.settings[2] = 50;  //bloom spread distance
global.settings[3] = 3.0; //bloom strength

global.active_world_width = 100;
global.active_world_height = 30;

//list of mods as text (file names)
global.modlist = ds_list_create();

//default state as text inline with the modlist
global.asset_registry = [];
global.block_registry = [];
global.visual_registry = [];

global.block_ids = ds_list_create();

//2d array inline with the modlist
global.external_calls = [];

random_set_seed(randomize());

scr_craft_poll();

var player_image = sprite_add("workingset/player.png", 1, false, false, 0, 0);
global.current_player = player_image;

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