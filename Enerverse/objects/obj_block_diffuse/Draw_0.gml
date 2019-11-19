scr_block_render();

var scaledSize = global.gui_scale * /*width of slot*/16 * 2;
var offset = 10;

for (var i = 0; i < /*how many slots*/15; i++)
{
	if (i == global.active_slot)
		draw_sprite_stretched(spr_hotbar, 1, offset + (i * scaledSize), (room_height - scaledSize - offset), scaledSize, scaledSize);
	else
		draw_sprite_stretched(spr_hotbar, 0, offset + (i * scaledSize), (room_height - scaledSize - offset), scaledSize, scaledSize);
}

scr_debug_render();