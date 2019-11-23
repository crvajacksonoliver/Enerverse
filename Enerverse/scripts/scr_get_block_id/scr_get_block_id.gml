/// @param {string} unlocalizedName

for (var i = 0; i < ds_list_size(global.block_ids); i++)
{
	if (ds_list_find_value(global.block_ids, i) == argument[0])
	{
		return i;
	}
}

return 0;