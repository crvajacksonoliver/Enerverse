if (global.UI_active_anti_mouse_left && !mouse_check_button(mb_left))
{
	global.UI_active_anti_mouse_left = false;
	global.UI_active = false;
}

if (global.button_down_anti_mouse_left && !mouse_check_button(mb_left))
{
	global.button_down = false;
	global.button_down_anti_mouse_left = false;
}

var completedUpdates = ds_list_create();
var updates = ds_list_create();
ds_list_copy(updates, global.block_updates);

for (var i = 0; i < ds_list_size(updates); i++)
{
	var update = ds_list_find_value(updates, i);
	array_set(update, 2, array_get(update, 2) - (delta_time / 1000));
	
	ds_list_set(updates, i, update);
	
	if (array_get(update, 2) < 0)
	{
		var bx = array_get(ds_list_find_value(updates, i), 0);
		var by = array_get(ds_list_find_value(updates, i), 1);
		
		var blockUnlocalizedName = scr_block_get_unlocalized_name_from_full(scr_block_get_unlocalized_name_from_id(array_get(scr_block_get(bx, by), 0)));
		var blockMeta = array_get(scr_block_get(bx, by), 1);
		
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

		var call = array_get(global.external_calls[modIndex], 4);
		
		//block update
		var unparsed = external_call(call, blockUnlocalizedName, blockMeta, bx, by);
		
		var result = scr_run_result(unparsed);
		
		global.active_world_blocks[(by * global.active_world_width) + bx * 2 + 1] = result;
		
		ds_list_add(completedUpdates, i);
	}
}

for (var i = 0; i < ds_list_size(completedUpdates); i++)
{
	ds_list_set(global.block_updates, ds_list_find_value(completedUpdates, i), pointer_null);
}

var i = 0;

while (i < ds_list_size(global.block_updates))
{
	if (ds_list_find_value(global.block_updates, i) == pointer_null)
		ds_list_delete(global.block_updates, i);
	else
		i++;
}

ds_list_destroy(updates);
ds_list_destroy(completedUpdates);
