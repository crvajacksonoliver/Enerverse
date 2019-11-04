/// @param {real} obj
var obj = argument[0];

for (var i = 0; i < ds_list_size(global.active_ui_instances); i++)
{
	with (ds_list_find_value(global.active_ui_instances, i))
	{
		if (id == obj)
		{
			instance_destroy(id, true);
			ds_list_delete(global.active_ui_instances, i);
			return;
		}
	}
}