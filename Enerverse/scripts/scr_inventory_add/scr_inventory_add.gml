/// @param {string} unlocalizedName
/// @param {real} amount

for (var i = 0; i < ds_list_size(global.player_inventory); i++)
{
	var arr = ds_list_find_value(global.player_inventory, i);
	
	if (arr[0] == argument[0])
	{
		arr[1] += argument[1];
		ds_list_set(global.player_inventory, i, arr);
		return;
	}
}

var arr = array_create(2);
arr[0] = argument[0];
arr[1] = argument[1];
ds_list_add(global.player_inventory, arr);