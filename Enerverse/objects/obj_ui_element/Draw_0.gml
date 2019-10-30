if (elementType == 1)
{
	shader_set(sdr_ui_color);
	
	shader_set_uniform_f(shader_get_uniform(sdr_ui_color, "u_R"), elementButtonFade);
	shader_set_uniform_f(shader_get_uniform(sdr_ui_color, "u_G"), elementButtonFade);
	shader_set_uniform_f(shader_get_uniform(sdr_ui_color, "u_B"), elementButtonFade);
	
	draw_sprite(sprite_index, image_index, x, y);
	
	shader_reset();
}