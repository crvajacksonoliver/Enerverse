/// @param {ds_list} system
/// @param {real} index

var system = argument[0];
var a = argument[1];

if (ds_list_find_value(system, a) == "0.0")
{// set block
	scr_block_set(real(ds_list_find_value(system, a + 1)), real(ds_list_find_value(system, a + 2)), ds_list_find_value(system, a + 3), ds_list_find_value(system, a + 4));
	a += 4;
}
else if (ds_list_find_value(system, a) == "0.1")
{// register block update
	scr_register_block_update(real(ds_list_find_value(system, a + 1)), real(ds_list_find_value(system, a + 2)), real(ds_list_find_value(system, a + 3)))
	a += 3;
}
else if (ds_list_find_value(system, a) == "1.0")
{// get block
	var bx = real(ds_list_find_value(system, a + 1));
	var by = real(ds_list_find_value(system, a + 2));
			
	var blockUnlocalizedName = scr_block_get_unlocalized_name_from_id(array_get(scr_block_get(bx, by), 0));
			
	var blockMod = scr_block_get_mod(scr_block_get_unlocalized_name_from_id(array_get(scr_block_get(bx, by), 0)));
		
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

	var call = array_get(global.external_calls[modIndex], 6);
	var otherArgs = ds_list_find_value(system, a + 4) + ";" + string(bx) + ";" + string(by) + ";";
			
	//block update
	var unparsed = external_call(call, ds_list_find_value(system, a + 3), blockUnlocalizedName, otherArgs);
	scr_run_result(unparsed);
	
	a += 4;
}

return a;