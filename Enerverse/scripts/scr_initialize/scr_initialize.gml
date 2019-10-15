global.player_x = 1.0;
global.player_y = 1.0;

global.zoom_factor = 1.0;

global.debug_menu = array_create(1);

global.settings = array_create(2);
global.settings[0] = true;//enable debug menu
global.settings[1] = true;//enable bloom
global.settings[2] = 30;   //bloom spread distance
global.settings[3] = 2;   //bloom strength

global.active_world_width = 20;
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

scr_world_gen();