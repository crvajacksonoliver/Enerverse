// x y name parameters
//ex par:    "5,2,19,"

var blockMod = scr_block_get_mod(argument[2]);
var modIndex = -1;

for (var i = 0; i < ds_list_size(global.modlist); i++)
{
	if (ds_list_find_value(global.modlist, i) == blockMod)
	{
		modIndex = i;
		break;
	}
}

if (modIndex == -1)
{
	return;
}

var meta = external_call(array_get(global.external_calls[modIndex], 3), scr_block_get_unlocalized_name_from_full(argument[2]), argument[3]);

global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2] = scr_get_block_id(argument[2]);
global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2 + 1] = meta;

if (meta == "5")
{
	scr_register_block_update(argument[0], argument[1], 3000);
	global.dx = argument[0];
	global.dy = argument[1];
}