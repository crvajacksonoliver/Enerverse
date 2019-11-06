// x y name parameters
//ex par:    "5,2,19,"

var blockMod = scr_block_get_mod(argument[2]);
var modIndex = -1;

for (var i = 0; i < array_length_1d(global.modlist); i++)
{
	if (global.modlist[i] == blockMod)
	{
		modIndex = i;
		break;
	}
}

if (modIndex == -1)
{
	return;
}

external_call(global.external_calls[modIndex, 3], argument[2], argument[3]);

global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2] = scr_get_block_id(argument[2]);
global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2 + 1] = scr_get_block_id(argument[3]);