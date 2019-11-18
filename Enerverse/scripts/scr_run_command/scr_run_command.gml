/// @param {ds_list} system
/// @param {real} index
/// @param {string} modUnlocalizedName

var system = argument[0];
var a = argument[1];
var modUnlocalizedName = argument[2];

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
	var gx = real(ds_list_find_value(system, a + 1));
	var gy = real(ds_list_find_value(system, a + 2));
	
	var blockUnlocalizedName = scr_block_get_unlocalized_name_from_id(array_get(scr_block_get(gx, gy), 0));
	
	var modIndex = -1;

	for (var i = 0; i < ds_list_size(global.modlist); i++)
	{
		if (ds_list_find_value(global.modlist, i) == modUnlocalizedName)
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
	var otherArgs = ds_list_find_value(system, a + 6) + ";" + string(real(ds_list_find_value(system, a + 4))) + ";" + string(real(ds_list_find_value(system, a + 5))) + ";";
	
	//block update
	var unparsed = external_call(call, ds_list_find_value(system, a + 3), blockUnlocalizedName, otherArgs);
	scr_run_result(unparsed);
	
	a += 6;
}

return a;