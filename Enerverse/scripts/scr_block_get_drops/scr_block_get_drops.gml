/// @param unlocalizedName

for (var i = 0; i < array_length_1d(global.block_registry); i++)
{
	if (array_get(global.block_registry[i], 0) == argument[0])
	{
		return array_get(global.block_registry[i], 6);
	}
}

var dummy0 = array_create(1);
var dummy1 = array_create(2);
dummy1[0] = "block_null";
dummy1[1] = 0;
dummy0[0] = dummy1;

return dummy0;