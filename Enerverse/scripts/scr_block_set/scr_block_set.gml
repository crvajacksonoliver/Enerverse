/// @param {real} x
/// @param {real} y
/// @param {string} unlocalizedName
/// @param {string} parameters

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

var unparsed = external_call(array_get(global.external_calls[modIndex], 3), scr_block_get_unlocalized_name_from_full(argument[2]), argument[3]);
var metaData = scr_run_result(unparsed);

var location = ((argument[1] * global.active_world_width) + argument[0]) * 2;

global.active_world_blocks[location] = scr_get_block_id(argument[2]);
global.active_world_blocks[location + 1] = metaData;
