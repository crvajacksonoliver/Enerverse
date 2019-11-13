/// @param {real} x
/// @param {real} y

if (argument[0] < 0 || argument[0] >= global.active_world_width || argument[1] < 0 || argument[1] >= global.active_world_height)
{
	return pointer_null;
}

var array = array_create(2);
array[0] = global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2];
array[1] = global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2 + 1];
return array;