var fileModList = file_text_open_read("mods/modlist.txt");
var i = 0;
while (!file_text_eof(fileModList))
{
	var line = file_text_read_string(fileModList);
	file_text_readln(fileModList);
	global.modlist[i] = line;
	i++;
}

file_text_close(fileModList);

var compileMessages = [];

global.external_calls = array_create(array_length_1d(global.modlist), 0);
global.block_registry = array_create(array_length_1d(global.modlist), 0);

for (var i = 0; i < array_length_1d(global.modlist); i++)
{
	global.external_calls[i] = array_create(10, 0);
	show_message(global.modlist[i]);
	var functionEngineVersion = external_define("mods/" + global.modlist[i] + ".dll", "engine_version", dll_cdecl, ty_real, 0);
	
	var currentEngineVersion = 1.0;
	var pulledEngineVersion = external_call(functionEngineVersion);
	
	if (pulledEngineVersion != currentEngineVersion)
	{
		compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> Mod \"" + global.modlist[i] + ".dll\" has engine version \"" + pulledEngineVersion + "\", the required version is \"" + currentEngineVersion + "\"";
		global.modlist[i] = "<FAILED> #" + i;
		continue;
	}
	
	/*
	CHANGE GUIDE
	
	change the array_create amount for the global.external_calls[i] line
	*/
	
	//mod
	
	global.external_calls[i, 0] = external_define("mods/" + global.modlist[i] + ".dll", "engine_init", dll_cdecl, ty_string, 0);
	global.external_calls[i, 1] = external_define("mods/" + global.modlist[i] + ".dll", "engine_init_assets", dll_cdecl, ty_string, 0);
	global.external_calls[i, 2] = external_define("mods/" + global.modlist[i] + ".dll", "engine_init_models", dll_cdecl, ty_string, 0);
	global.external_calls[i, 3] = external_define("mods/" + global.modlist[i] + ".dll", "engine_init_visuals", dll_cdecl, ty_string, 0);
	
	//blocks
	
	global.external_calls[i, 4] = external_define("mods/" + global.modlist[i] + ".dll", "engine_block_create", dll_cdecl, ty_string, 2, ty_string, ty_string);
	global.external_calls[i, 5] = external_define("mods/" + global.modlist[i] + ".dll", "engine_block_update", dll_cdecl, ty_string, 2, ty_string, ty_string);
	global.external_calls[i, 6] = external_define("mods/" + global.modlist[i] + ".dll", "engine_block_destroy", dll_cdecl, ty_string, 2, ty_string, ty_string);
	
	global.external_calls[i, 7] = external_define("mods/" + global.modlist[i] + ".dll", "engine_block_registry_initialize", dll_cdecl, ty_string, 0);
	global.external_calls[i, 8] = external_define("mods/" + global.modlist[i] + ".dll", "engine_block_registry_compile", dll_cdecl, ty_string, 0);
	global.external_calls[i, 9] = external_define("mods/" + global.modlist[i] + ".dll", "engine_block_registry_pull", dll_cdecl, ty_string, 0);
	
	//initialize mod
	
	{
		var result = external_call(global.external_calls[i, 0]);
		if (result != "1")
		{
			compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + global.modlist[i] + ".dll\" during engine_init";
			global.modlist[i] = "<FAILED> #" + i;
			continue;
		}
	}
	
	{
		var result = external_call(global.external_calls[i, 7]);
		if (result != "1")
		{
			compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + global.modlist[i] + ".dll\" during engine_block_registry_initialization";
			global.modlist[i] = "<FAILED> #" + i;
			continue;
		}
	}
	
	//load information
	
	{
		var result = external_call(global.external_calls[i, 1]);
		show_message("result: " + result);
		if (result != "1")
		{
			compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + global.modlist[i] + ".dll\" during engine_init_assets";
			global.modlist[i] = "<FAILED> #" + i;
			continue;
		}
	}
	show_message("test");
	{
		var result = external_call(global.external_calls[i, 2]);
		show_message(result);
		if (result != "1")
		{
			compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + global.modlist[i] + ".dll\" during engine_init_models";
			global.modlist[i] = "<FAILED> #" + i;
			continue;
		}
	}
	
	{
		var result = external_call(global.external_calls[i, 3]);
		if (result != "1")
		{
			compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + global.modlist[i] + ".dll\" during engine_init_visuals";
			global.modlist[i] = "<FAILED> #" + i;
			continue;
		}
	}
	
	//compile and pull
	
	{
		var result = external_call(global.external_calls[i, 8]);
		if (result != "1")
		{
			compileMessages[array_length_1d(compileMessages) - 1] = " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + global.modlist[i] + ".dll\" during engine_block_registry_compile";
			global.modlist[i] = "<FAILED> #" + i;
			continue;
		}
	}
	
	{
		var result = external_call(global.external_calls[i, 9]);
		if (result == "")
			global.block_registry[i] = "@NONE";
		else
			global.block_registry[i] = result;
	}
}

for (var i = 0; i < array_length_1d(compileMessages); i++)
{
	show_message(compileMessages[i]);
}

//
//	RETURN DEBUG
//

return;

var loadable_blocks_length = 0;
var loadable_blocks = [];

loadable_blocks[loadable_blocks_length] = "vin/dirt"; loadable_blocks_length++;
loadable_blocks[loadable_blocks_length] = "vin/grass"; loadable_blocks_length++;
loadable_blocks[loadable_blocks_length] = "vin/wooden_frame"; loadable_blocks_length++;

var blocks = instance_create_depth(0, 0, 10, obj_blocks);
with (blocks)
{
	var some_function = external_define("EnerverseVin.dll", "engine_block_registry_initialize", dll_cdecl, ty_string, 0);
	var some_value = external_call(some_function);
	
	var block = sprite_add("workingset/vin/null.png", 1, false, false, 0, 0);
	
	global.block_registry[0, 0] = "vin/null";
	global.block_registry[0, 1] = 0;
	
	for (var i = 0; i < loadable_blocks_length; i++)
	{
		block = script_execute(scr_merge_sprite, block, "workingset/" + loadable_blocks[i] + ".png");
		global.block_registry[i + 1, 0] = loadable_blocks[i];
		global.block_registry[i + 1, 1] = i + 1;
	}
	
	sprite_assign(sprite_index, block);
}