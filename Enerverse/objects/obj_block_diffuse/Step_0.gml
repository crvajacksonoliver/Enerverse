scr_block_update();
scr_debug_update();

if (global.chat_open)
{
	if (keyboard_check(vk_enter))
	{
		if (!scr_run_internal_command(global.chat_text))
			ds_list_add(global.chat, "command failed to run");
		
		global.chat_open = false;
		global.chat_text = "";
		global.char_marker = 0;
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
if (keyboard_check(ord(".")))
{
	if (keyboard_check(vk_shift))
	{
		global.chat_open = true;
		global.chat_text = ">";
		global.char_marker = 1;
	}
	else
	{
		global.chat_open = true;
		global.chat_text = "";
		global.char_marker = 0;
	}
}