scr_block_update();
scr_debug_update();

if (global.chat_open)
{
	if (keyboard_check_pressed(vk_escape))
	{
		global.chat_open = false;
		global.chat_text = "";
		global.chat_marker = 0;
	}
	else if (keyboard_check_pressed(vk_enter))
	{
		if (string_length(global.chat_text) > 0)
		{
			if (string_char_at(global.chat_text, 0) == ">")
			{
				if (!scr_run_internal_command(global.chat_text))
					ds_list_add(global.chat, "command failed to run");
			}
			else
			{
				ds_list_add(global.chat, global.chat_text);
			}
		}
		
		global.chat_open = false;
		global.chat_text = "";
		global.chat_marker = 0;
	}
	else if (keyboard_check_pressed(vk_right))
	{
		global.chat_marker++;
		
		if (global.chat_marker >= string_length(global.chat_text))
			global.chat_marker = string_length(global.chat_text);
	}
	else if (keyboard_check_pressed(vk_left))
	{
		global.chat_marker--;
		
		if (global.chat_marker < 0)
			global.chat_marker = 0;
	}
	else if (keyboard_check_pressed(vk_backspace) && string_length(global.chat_text) > 0)
	{
		global.chat_text = string_delete(global.chat_text, global.chat_marker, 1);
		global.chat_marker--;
		
		if (global.chat_marker < 0)
			global.chat_marker = 0;
	}
	else if (keyboard_check_pressed(vk_delete) && global.chat_marker < string_length(global.chat_text))
	{
		global.chat_text = string_delete(global.chat_text, global.chat_marker + 1, 1);
	}
	else if (keyboard_check_pressed(vk_anykey) && !keyboard_check_pressed(vk_shift) && !keyboard_check_pressed(vk_backspace) && !keyboard_check_pressed(vk_delete))
	{
		global.chat_text = string_insert(keyboard_lastchar, global.chat_text, global.chat_marker + 1);
		global.chat_marker++;
	}
}
else
{
	if (keyboard_check(190))
	{
		if (keyboard_check(vk_shift))
		{
			global.chat_open = true;
			global.chat_text = ">";
			global.chat_marker = 1;
		}
		else
		{
			global.chat_open = true;
			global.chat_text = "";
			global.chat_marker = 0;
		}
	}
	
	if (keyboard_check(ord("1")))
		global.active_slot = 0;
	if (keyboard_check(ord("2")))
		global.active_slot = 1;
	if (keyboard_check(ord("3")))
		global.active_slot = 2;
	if (keyboard_check(ord("4")))
		global.active_slot = 3;
	if (keyboard_check(ord("5")))
		global.active_slot = 4;
	if (keyboard_check(ord("6")))
		global.active_slot = 5;
	if (keyboard_check(ord("7")))
		global.active_slot = 6;
	if (keyboard_check(ord("8")))
		global.active_slot = 7;
	if (keyboard_check(ord("9")))
		global.active_slot = 8;
	if (keyboard_check(ord("0")))
		global.active_slot = 9;
}
