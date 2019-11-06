global.player_x = 1.0;
global.player_y = 1.0;

global.player_grounded = true;
global.moving_right = false;
global.moving_left = false;
global.cplayer_x = 0;
global.cplayer_y = 0;
global.jump_dec = 0.0;
global.jumping = false;

global.zoom_factor = 1.0;

global.debug_menu = array_create(4);

global.settings = array_create(2);
global.settings[0] = true;//enable debug menu
global.settings[1] = true;//enable bloom
global.settings[2] = 60;  //bloom spread distance
global.settings[3] = 6.0; //bloom strength

global.in_world = false;
global.game_paused = false;
global.bloom_toggle_button = pointer_null;

global.button_down = false;
global.button_down_anti_mouse_left = false;

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

global.UI = ds_list_create();
global.active_ui_instances = ds_list_create();
global.UI_type = 0;

global.UI_active_anti_mouse_left = false;

instance_create_depth(0, 0, 0, obj_updates);
instance_create_depth(0, 0, 0, obj_keybinds);

var uiOutlineButtonObj = instance_create_depth(0, 0, -1, obj_ui_element);
var uiOutlineButtonSpr = sprite_add("workingset/button.png", 1, false, false, 0, 0);

with (uiOutlineButtonObj)
{
	sprite_index = uiOutlineButtonSpr;
	visible = false;
	elementType = 0;
}

ds_list_add(global.UI, uiOutlineButtonObj);

global.UI_type = 1;

var buttonPlay = scr_ui_register_render_button(room_width * 0.6, (room_width * 0.6) / 15, 0.0, 0.1, 0.4, "Play Game", 1.5, scr_button_mm_play);

with (buttonPlay)
{
	x = (room_width / 2) - ((room_width * 0.6) / 2);
	y = (room_height / 2) - (((room_height * 0.6) / 15));
}

var buttonQuit = scr_ui_register_render_button(room_width * 0.6, (room_width * 0.6) / 15, 0.0, 0.1, 0.4, "Quit Game", 1.5, scr_button_mm_quit);

with (buttonQuit)
{
	x = (room_width / 2) - ((room_width * 0.6) / 2);
	y = (room_height / 2) + (((room_height * 0.6) / 15));
}