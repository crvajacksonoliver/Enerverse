/// @param {real} x
/// @param {real} y
/// @param {string} metaDataChar
/// @param {real} index

var location = ((argument[1] * global.active_world_width) + argument[0]) * 2;

var meta = global.active_world_blocks[location + 1];
var newMeta = "";

for (var i = 0; i < real(argument[3]); i++)
	newMeta += string_char_at(meta, i + 1);

newMeta += argument[2];

for (var i = real(argument[3]) + 1; i < string_length(meta); i++)
	newMeta += string_char_at(meta, i + 1);

global.active_world_blocks[location + 1] = newMeta;
global.debug_menu[4] = newMeta;