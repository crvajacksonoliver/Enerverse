/// @param {real} unlocalizedName
for (var i = 0; i < array_length_1d(global.block_registry); i++)
{
	if (array_get(global.block_registry[i], 0) == argument[0])
	{
		return real(array_get(global.block_registry[i], 4));
	}
}

return -1.0;