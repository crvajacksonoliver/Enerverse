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
var updates = global.block_updates;
for (var i = 0; i < ds_list_size(updates); i++)
{
	var update = ds_list_find_value(updates, i);
	array_set(update, 2, array_get(update, 2) - (delta_time / 1000));
	
	ds_list_set(updates, i, update);
	
	if (array_get(update, 2) < 0)
	{
		var blockUnlocalizedName = scr_block_get_unlocalized_name_from_id(scr_get_block_id(array_get(ds_list_find_value(updates, i), 0), array_get(ds_list_find_value(updates, i), 1)));
		
		var bx = array_get(ds_list_find_value(updates, i), 0);
		var by = array_get(ds_list_find_value(updates, i), 1);
		
		var blockMeta = array_get(scr_block_get(bx, by), 1);
		
		//block update
		var call = array_get(update, 3);
		var result = external_call(array_get(update, 3), "block_sod", blockMeta);
		
		var meta = scr_run_result(result);
		
		global.active_world_blocks[(by * global.active_world_width) + bx * 2 + 1] = meta;
		global.debug_menu[4] = meta;
		
		ds_list_add(completedUpdates, i);
	}
}

for (var i = 0; i < ds_list_size(completedUpdates); i++)
{
	ds_list_delete(updates, ds_list_find_value(completedUpdates, i));
}

ds_list_destroy(completedUpdates);
