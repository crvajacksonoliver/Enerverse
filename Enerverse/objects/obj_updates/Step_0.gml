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
	var milli = array_get(ds_list_find_value(updates, i), 2);
	milli -= delta_time;
	if (milli < 0)
	{
		//block update
		var meta = external_call(array_get(ds_list_find_value(updates, i), 3), scr_block_get_unlocalized_name_from_id(scr_get_block_id(array_get(ds_list_find_value(updates, i), 0), array_get(ds_list_find_value(updates, i), 1))), global.active_world_blocks[((array_get(ds_list_find_value(updates, i), 1) * global.active_world_width) + array_get(ds_list_find_value(updates, i), 0)) * 2 + 1]);
		global.active_world_blocks[((array_get(ds_list_find_value(updates, i), 1) * global.active_world_width) + array_get(ds_list_find_value(updates, i), 0)) * 2 + 1] = meta;
		
		ds_list_add(completedUpdates, i);
	}
}

for (var i = 0; i < ds_list_size(completedUpdates); i++)
{
	ds_list_delete(updates, ds_list_find_value(completedUpdates, i));
}

ds_list_destroy(completedUpdates);

if (global.dx != 0 && global.dy != 0)
	global.debug_menu[4] = array_get(scr_block_get(global.dx, global.dy), 1);
else
	global.debug_menu[4] = "not yet";