/// @param {real} id

if (argument[0] == 0)
	return "null";

var b_id = argument[0];
return array_get(global.block_registry[b_id - 1], 0);