/// @param {real} x
/// @param {real} y
/// @param {real} milliseconds

var block_x = argument[0];
var block_y = argument[1];
var milliseconds = argument[2];

var block_data = array_create(3);
block_data[0] = block_x;
block_data[1] = block_y;
block_data[2] = milliseconds;

ds_list_add(global.block_updates, block_data);