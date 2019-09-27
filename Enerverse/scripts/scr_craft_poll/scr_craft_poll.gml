var fileModList = file_text_open_read("mods/modlist.txt");
var i = 0;
while (!file_text_eof(fileModList))
{
	var line = file_text_read_string(fileModList);
	file_text_readln(fileModList);
	ds_list_add(global.modlist, line);
	i++;
}

file_text_close(fileModList);

var compileMessages = ds_list_create();

global.external_calls = array_create(ds_list_size(global.modlist), 0);

global.asset_registry = array_create(ds_list_size(global.modlist), 0);
global.block_registry = array_create(ds_list_size(global.modlist), 0);
global.visual_registry = array_create(ds_list_size(global.modlist), 0);

for (var i = 0; i < ds_list_size(global.modlist); i++)
{
	global.external_calls[i] = array_create(6, 0);
	
	var functionEngineVersion = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_version", dll_cdecl, ty_real, 0);
	
	var currentEngineVersion = 1.0;
	var pulledEngineVersion = external_call(functionEngineVersion);
	
	if (pulledEngineVersion != currentEngineVersion)
	{
		ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> Mod \"" + ds_list_find_value(global.modlist, i) + ".dll\" has engine version \"" + pulledEngineVersion + "\", the required version is \"" + currentEngineVersion + "\"");
		ds_list_set(global.modlist, i, "<FAILED> #" + string(i));
		continue;
	}
	
	/*
	CHANGE GUIDE
	
	change the array_create amount for the global.external_calls[i] line
	*/
	
	//mod
	
	global.external_calls[i, 0] = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_assets", dll_cdecl, ty_string, 0);
	global.external_calls[i, 1] = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_models", dll_cdecl, ty_string, 0);
	global.external_calls[i, 2] = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_visuals", dll_cdecl, ty_string, 0);
	
	//blocks
	
	global.external_calls[i, 3] = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_create", dll_cdecl, ty_string, 2, ty_string, ty_string);
	global.external_calls[i, 4] = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_update", dll_cdecl, ty_string, 2, ty_string, ty_string);
	global.external_calls[i, 5] = external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_destroy", dll_cdecl, ty_string, 2, ty_string, ty_string);
	
	//load information
	
	var errorsPresent = false;
	
	{
		var result = external_call(global.external_calls[i, 0]);
		if (result == "0")
		{
			ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + ds_list_find_value(global.modlist, i) + ".dll\" during engine_pull_assets");
			errorsPresent = true;
		}
		else if (result == "")
			global.asset_registry[i] = "@NONE";
		else
			global.asset_registry[i] = result;
	}
	
	{
		var result = external_call(global.external_calls[i, 1]);
		if (result == "0")
		{
			ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + ds_list_find_value(global.modlist, i) + ".dll\" during engine_pull_models");
			errorsPresent = true;
		}
		else if (result == "")
			global.block_registry[i] = "@NONE";
		else
			global.block_registry[i] = result;
	}
	
	{
		var result = external_call(global.external_calls[i, 2]);
		if (result == "0")
		{
			ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + ds_list_find_value(global.modlist, i) + ".dll\" during engine_pull_visuals");
			errorsPresent = true;
		}
		else if (result == "")
			global.visual_registry[i] = "@NONE";
		else
			global.visual_registry[i] = result;
	}
	
	if (errorsPresent)
	{
		ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> An error has been detected in mod \"" + ds_list_find_value(global.modlist, i) + ".dll\", and will not be loaded into the game");
		ds_list_set(global.modlist, i, "<FAILED> #" + string(i));
		
		continue;
	}
}

for (var i = 0; i < ds_list_size(compileMessages); i++)
{
	show_message(ds_list_find_value(compileMessages, i));
}

//split attributes

var blocks = ds_list_create();

for (var i = 0; i < ds_list_size(global.modlist); i++)
{
	var inc = 0;
	while (inc < string_length(global.block_registry[i]))
	{
		var block = array_create(6);
		
		{//unlocalizedName
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc);
				inc++;
			}
		
			block[0] = attrib;
			inc++;
		}
		{//displayName
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc);
				inc++;
			}
		
			block[1] = attrib;
			inc++;
		}
		{//material
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc);
				inc++;
			}
		
			block[2] = attrib;
			inc++;
		}
		{//tool
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc);
				inc++;
			}
		
			block[3] = attrib;
			inc++;
		}
		{//hardness
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc);
				inc++;
			}
		
			block[4] = attrib;
			inc++;
		}
		{//isItem
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc);
				inc++;
			}
		
			block[5] = attrib;
			inc++;
		}
		
		ds_list_add(blocks, block);
	}
}

global.block_registry = array_create(ds_list_size(blocks));

for (var i = 0; i < ds_list_size(blocks); i++)
{
	global.block_registry[i] = ds_list_find_value(blocks, i);
}

ds_list_destroy(blocks);

//setup sprites and objects

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