/// @param {real} x
/// @param {real} y
/// @param {string} metaData

var location = ((argument[1] * global.active_world_width) + argument[0]) * 2;

global.active_world_blocks[location + 1] = argument[2];
