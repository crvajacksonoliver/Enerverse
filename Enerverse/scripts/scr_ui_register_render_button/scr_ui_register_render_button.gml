var buttonWidth = max(argument[0], 32);
var buttonHeight = max(argument[1], 32);

var bR = argument[2];
var bG = argument[3];
var bB = argument[4];

var buttonText = argument[5];
var buttonScale = argument[6];

var buttonSurface = surface_create(buttonWidth, buttonHeight);
var calSurface = surface_create(5, 4);

shader_set(sdr_ui_color);
shader_set_uniform_f(shader_get_uniform(sdr_ui_color, "u_R"), bR);
shader_set_uniform_f(shader_get_uniform(sdr_ui_color, "u_G"), bG);
shader_set_uniform_f(shader_get_uniform(sdr_ui_color, "u_B"), bB);
surface_set_target(calSurface);

with (ds_list_find_value(global.UI, 0))
{
	draw_sprite(sprite_index, 0, 0, 0);
}

surface_reset_target();
shader_reset();


surface_set_target(buttonSurface);

for (var i = 0; i < ceil((buttonWidth - 32) / 4); i++)
{
	draw_surface_general(calSurface, 4, 0, 1, 4, (i * 4) + 16, 0, 4, 4, 0, c_white, c_white, c_white, c_white, 1);
	draw_surface_general(calSurface, 4, 0, 1, 4, (i * 4) + 20, buttonHeight, 4, 4, 180, c_white, c_white, c_white, c_white, 1);
}

for (var i = 0; i < ceil((buttonHeight - 32) / 4); i++)
{
	draw_surface_general(calSurface, 4, 0, 1, 4, 0, (i * 4) + 20, 4, 4, 90, c_white, c_white, c_white, c_white, 1);
	draw_surface_general(calSurface, 4, 0, 1, 4, buttonWidth, (i * 4) + 16, 4, 4, 270, c_white, c_white, c_white, c_white, 1);
}

draw_set_color(make_color_rgb(bR * 255, bG * 255, bB * 255));
draw_rectangle(16, 16, buttonWidth - 16, buttonHeight - 16, false);

draw_surface_general(calSurface, 0, 0, 4, 4, 0, 0, 4, 4, 0, c_white, c_white, c_white, c_white, 1);
draw_surface_general(calSurface, 0, 0, 4, 4, buttonWidth, 0, 4, 4, 270, c_white, c_white, c_white, c_white, 1);
draw_surface_general(calSurface, 0, 0, 4, 4, 0, buttonHeight, 4, 4, 90, c_white, c_white, c_white, c_white, 1);
draw_surface_general(calSurface, 0, 0, 4, 4, buttonWidth, buttonHeight, 4, 4, 180, c_white, c_white, c_white, c_white, 1);

draw_set_color(c_black);
draw_text_transformed((buttonWidth / 2) - ((string_width(buttonText) * buttonScale) / 2), (buttonHeight / 2) - ((string_height(buttonText) * buttonScale) / 2), buttonText, buttonScale, buttonScale, 0);

surface_reset_target();

var buttonObj = instance_create_depth(0, 0, -1, obj_ui_element);;
var buttonSpr = sprite_create_from_surface(buttonSurface, 0, 0, buttonWidth, buttonHeight, false, false, 0, 0);

with (buttonObj)
{
	sprite_index = buttonSpr;
	visible = true;
}

surface_free(calSurface);
surface_free(buttonSurface);