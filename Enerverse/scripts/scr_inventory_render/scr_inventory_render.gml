draw_set_alpha(0.3);
draw_set_color(make_color_rgb(30, 30, 30));
draw_rectangle(0, 0, 300, room_height - 85, false);
draw_set_alpha(1.0);

var tileHeight = 16;
var amountPerPage = (room_height - 100) / (tileHeight * global.gui_scale);

for (var i = 0; i < amountPerPage; i++)
{
	if (i + global.inventory_marker >= ds_list_size(global.player_inventory))
		break;
	
	var item = array_get(ds_list_find_value(global.player_inventory, i + global.inventory_marker), 0);
	var amount = array_get(ds_list_find_value(global.player_inventory, i + global.inventory_marker), 1);
	
	draw_set_color(c_white);
	draw_text(tileHeight + 10, 5 + (i * (tileHeight * global.gui_scale)), "x" + string(amount));
	draw_text(tileHeight + 50, 5 + (i * (tileHeight * global.gui_scale)), item);
	draw_sprite_stretched(sprite_index, scr_get_item_id(item), 5, 5 + (i * (tileHeight * global.gui_scale)), tileHeight, tileHeight);
}