global.lplayer_x = 0;
global.lplayer_y = 0;

global.player_x = -800;
global.player_y = -800;

global.using_debug_menu = true;
global.debug_menu = array_create(1);

global.debug = 0;

global.active_world_width = 50;
global.active_world_height = 50;

global.active_world_blocks = array_create(global.active_world_width * global.active_world_height * 2, 0);

for (var i = 0; i < global.active_world_width * global.active_world_height; i++)
{
	global.active_world_blocks[i * 2] = random_range(1, 4);
	
	global.active_world_blocks[i * 2 + 1] = "";
}

global.block_registry = [];

var loadable_blocks_length = 0;
var loadable_blocks = [];

loadable_blocks[loadable_blocks_length] = "vin/dirt"; loadable_blocks_length++;
loadable_blocks[loadable_blocks_length] = "vin/grass"; loadable_blocks_length++;
loadable_blocks[loadable_blocks_length] = "vin/wooden_frame"; loadable_blocks_length++;

var blocks = instance_create_depth(0, 0, 10, obj_blocks);
with (blocks)
{
	var some_function = external_define("EnerverseVin.dll", "engine_block_registry_initialize", dll_cdecl, ty_string, 0);
	var some_value = external_call(some_function);
	
	var block = sprite_add("workingset/vin/null.png", 1, false, false, 0, 0);
	
	global.block_registry[0, 0] = "vin/null";
	global.block_registry[0, 1] = 0;
	
	for (var i = 0; i < loadable_blocks_length; i++)
	{
		block = script_execute(scr_merge_sprite, block, "workingset/" + loadable_blocks[i] + ".png");
		global.block_registry[i + 1, 0] = loadable_blocks[i];
		global.block_registry[i + 1, 1] = i + 1;
	}
	
	sprite_assign(sprite_index, block);
}

var player_image = sprite_add("workingset/player.png", 1, true, false, 0, 0);
global.current_player = player_image;
