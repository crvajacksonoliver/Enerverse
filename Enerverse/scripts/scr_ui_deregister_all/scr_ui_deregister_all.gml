for (var i = 0; i < ds_list_size(global.active_ui_instances); i++)
	with (ds_list_find_value(global.active_ui_instances, i))
		instance_destroy(id, true);

ds_list_clear(global.active_ui_instances);
global.UI_active_anti_mouse_left = true;
global.UI_type = 0;