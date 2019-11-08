/// @param {real} x
/// @param {real} y
/// @param {real} milliseconds

var block_x = argument[0];
var block_y = argument[1];
var milliseconds = argument[2];

var blockMod = scr_block_get_mod(scr_block_get_unlocalized_name_from_id(array_get(scr_block_get(block_x, block_y), 0)));
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

var call = array_get(global.external_calls[modIndex], 4);

var block_data = array_create(4);
block_data[0] = block_x;
block_data[1] = block_y;
block_data[2] = milliseconds;
block_data[3] = call;

ds_list_add(global.block_updates, block_data);