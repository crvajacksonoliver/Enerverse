// x y
var array = array_create(2);
array[0] = global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2];
array[1] = global.active_world_blocks[((argument[1] * global.active_world_width) + argument[0]) * 2 + 1];
return array;