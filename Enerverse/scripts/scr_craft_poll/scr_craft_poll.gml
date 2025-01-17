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
	global.external_calls[i] = array_create(7 + /*how many callbacks*/2, 0);
	
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
	
	array_set(global.external_calls[i], 0, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_assets", dll_cdecl, ty_string, 0));
	array_set(global.external_calls[i], 1, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_models", dll_cdecl, ty_string, 0));
	array_set(global.external_calls[i], 2, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_visuals", dll_cdecl, ty_string, 0));
	
	//blocks
	
	array_set(global.external_calls[i], 3, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_create", dll_stdcall, ty_string, 4, ty_string, ty_string, ty_real, ty_real));
	array_set(global.external_calls[i], 4, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_update", dll_stdcall, ty_string, 4, ty_string, ty_string, ty_real, ty_real));
	array_set(global.external_calls[i], 5, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_destroy", dll_stdcall, ty_string, 4, ty_string, ty_string, ty_real, ty_real));
	
	//callbacks
	
	array_set(global.external_calls[i], 6, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_sys0", dll_stdcall, ty_string, 3, ty_string, ty_string, ty_string));
	array_set(global.external_calls[i], 7, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_block_sys1", dll_stdcall, ty_string, 3, ty_string, ty_string, ty_string));
	
	//item; dont want to change all indices
	array_set(global.external_calls[i], 8, external_define("mods/" + ds_list_find_value(global.modlist, i) + ".dll", "engine_pull_items", dll_cdecl, ty_string, 0));
	
	//load information
	
	var errorsPresent = false;
	
	{
		var result = external_call(array_get(global.external_calls[i], 0));
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
		var result = external_call(array_get(global.external_calls[i], 1));
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
		/*
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
		*/
		
		
	}
	
	{
		var result = external_call(array_get(global.external_calls[i], 8));
		if (result == "0")
		{
			ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> An error has occurred in mod \"" + ds_list_find_value(global.modlist, i) + ".dll\" during engine_pull_items");
			errorsPresent = true;
		}
		else if (result == "")
			global.item_registry[i] = "@NONE";
		else
			global.item_registry[i] = result;
	}
	
	if (errorsPresent)
	{
		ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Compile Mod> An error has been detected in mod \"" + ds_list_find_value(global.modlist, i) + ".dll\", and will not be loaded into the game");
		ds_list_set(global.modlist, i, "<FAILED> #" + string(i));
		
		continue;
	}
}

//blocks

var blocks = ds_list_create();

for (var i = 0; i < ds_list_size(global.modlist); i++)
{
	if (global.block_registry[i] == "@NONE")
		continue;
	
	var inc = 0;
	while (inc < string_length(global.block_registry[i]))
	{
		var block = array_create(9);
		
		{//unlocalizedName
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc + 1);
				inc++;
			}
		
			block[0] = ds_list_find_value(global.modlist, i) + "/" + attrib;
			inc++;
		}
		{//displayName
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc + 1);
				inc++;
			}
		
			block[1] = attrib;
			inc++;
		}
		{//material
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc + 1);
				inc++;
			}
		
			block[2] = attrib;
			inc++;
		}
		{//tool
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc + 1);
				inc++;
			}
		
			block[3] = attrib;
			inc++;
		}
		{//hardness
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc + 1);
				inc++;
			}
		
			block[4] = attrib;
			inc++;
		}
		{//isItem
			var attrib = "";
			while (string_char_at(global.block_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.block_registry[i], inc + 1);
				inc++;
			}
		
			block[5] = attrib;
			inc++;
		}
		{//drops
			var drops = ds_list_create();
			
			while (string_char_at(global.block_registry[i], inc + 1) != ";")
			{
				var attrib = array_create(2);
				var dropUnlocalizedName = "";
				var dropAmount = "";
				
				while (string_char_at(global.block_registry[i], inc + 1) != ",")
				{
					dropUnlocalizedName += string_char_at(global.block_registry[i], inc + 1);
					inc++;
				}
				
				inc++;
				
				while (string_char_at(global.block_registry[i], inc + 1) != ",")
				{
					dropAmount += string_char_at(global.block_registry[i], inc + 1);
					inc++;
				}
				
				inc++;
				
				attrib[0] = dropUnlocalizedName;
				attrib[1] = dropAmount;
				
				ds_list_add(drops, attrib);
			}
			
			var drop_array = array_create(ds_list_size(drops));
			for (var a = 0; a < ds_list_size(drops); a++)
			{
				drop_array[a] = ds_list_find_value(drops, a);
			}
			
			block[6] = drop_array;
			inc++;
		}
		{//DIFFUSE model
			var model = ds_list_create();
			
			while (true)
			{
				var modelPart = array_create(9);
				{//path
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[0] = attrib;
					inc++;
				}
				{//o_x
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[1] = attrib;
					inc++;
				}
				{//o_y
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[2] = attrib;
					inc++;
				}
				{//o_width
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[3] = attrib;
					inc++;
				}
				{//o_height
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[4] = attrib;
					inc++;
				}
				{//n_x
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[5] = attrib;
					inc++;
				}
				{//n_y
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[6] = attrib;
					inc++;
				}
				{//n_width
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[7] = attrib;
					inc++;
				}
				{//n_height
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[8] = attrib;
					inc++;
				}
				
				ds_list_add(model, modelPart);
				
				if (string_char_at(global.block_registry[i], inc + 1) == ";")
				{
					inc++;
					break;
				}
			}
			
			block[7] = model;
		}
		{//BLOOM model
			var model = ds_list_create();
			
			while (true)
			{
				var modelPart = array_create(9);
				{//path
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[0] = attrib;
					inc++;
				}
				{//o_x
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[1] = attrib;
					inc++;
				}
				{//o_y
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[2] = attrib;
					inc++;
				}
				{//o_width
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[3] = attrib;
					inc++;
				}
				{//o_height
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[4] = attrib;
					inc++;
				}
				{//n_x
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[5] = attrib;
					inc++;
				}
				{//n_y
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[6] = attrib;
					inc++;
				}
				{//n_width
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[7] = attrib;
					inc++;
				}
				{//n_height
					var attrib = "";
					while (string_char_at(global.block_registry[i], inc + 1) != ",")
					{
						attrib += string_char_at(global.block_registry[i], inc + 1);
						inc++;
					}
		
					modelPart[8] = attrib;
					inc++;
				}
				
				ds_list_add(model, modelPart);
				
				if (string_char_at(global.block_registry[i], inc + 1) == ";")
				{
					inc++;
					break;
				}
			}
			
			block[8] = model;
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

//items

/*
	*itemText += item->GetUnlocalizedName();
	*itemText += ",";
	*itemText += item->GetDisplayName();
	*itemText += ",";
	*itemText += std::to_string(item->IsTool() ? 1 : 0);
	*itemText += ",";
	*itemText += std::to_string(item->GetToolReduction());
	*itemText += ",";
	*itemText += item->GetDiffuseTexture();
	*itemText += ",";
*/

var items = ds_list_create();

for (var i = 0; i < ds_list_size(global.modlist); i++)
{
	if (global.item_registry[i] == "@NONE")
		continue;
	
	var inc = 0;
	while (inc < string_length(global.item_registry[i]))
	{
		var item = array_create(5);
		
		{//unlocalizedName
			var attrib = "";
			while (string_char_at(global.item_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.item_registry[i], inc + 1);
				inc++;
			}
		
			item[0] = ds_list_find_value(global.modlist, i) + "/" + attrib;
			inc++;
		}
		{//displayName
			var attrib = "";
			while (string_char_at(global.item_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.item_registry[i], inc + 1);
				inc++;
			}
		
			item[1] = attrib;
			inc++;
		}
		{//isTool
			var attrib = "";
			while (string_char_at(global.item_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.item_registry[i], inc + 1);
				inc++;
			}
		
			item[2] = attrib;
			inc++;
		}
		{//toolReduction
			var attrib = "";
			while (string_char_at(global.item_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.item_registry[i], inc + 1);
				inc++;
			}
		
			item[3] = attrib;
			inc++;
		}
		{//texture
			var attrib = "";
			while (string_char_at(global.item_registry[i], inc + 1) != ",")
			{
				attrib += string_char_at(global.item_registry[i], inc + 1);
				inc++;
			}
		
			item[4] = attrib;
			inc++;
		}
		
		ds_list_add(items, item);
	}
}

global.item_registry = array_create(ds_list_size(items));

for (var i = 0; i < ds_list_size(items); i++)
{
	global.item_registry[i] = ds_list_find_value(items, i);
}

ds_list_destroy(items);

//setup sprites and objects

{
	var assets = ds_list_create();
	
	for (var i = 0; i < ds_list_size(global.modlist); i++)
	{
		var inc = 0;
		
		while (inc < string_length(global.asset_registry[i]))
		{
			var assetPath = "";
			while (string_char_at(global.asset_registry[i], inc + 1) != ",")
			{
				assetPath += string_char_at(global.asset_registry[i], inc + 1);
				inc++;
			}
			
			inc++;
			
			var assetType = "";
			while (string_char_at(global.asset_registry[i], inc + 1) != ",")
			{
				assetType += string_char_at(global.asset_registry[i], inc + 1);
				inc++;
			}
			
			var asset = array_create(2);
			asset[0] = assetPath;
			asset[1] = assetType;
			
			ds_list_add(assets, asset);
			
			inc++;
		}
	}
	
	var assetsObject = instance_create_depth(0, 100, 0, obj_assets);
	with (assetsObject)
	{
		var loadableAsset = sprite_add("workingset/diffuse_null.png", 1, false, false, 0, 0);
		
		for (var i = 0; i < ds_list_size(assets); i++)
		{
			loadableAsset = scr_merge_sprite(loadableAsset, "workingset/" + array_get(ds_list_find_value(assets, i), 0) + ".png");
		}
		
		sprite_assign(sprite_index, loadableAsset);
		
		var blockDiffuseObject = instance_create_depth(0, 0, 0, obj_block_diffuse);
		var blockDiffuseSprite = sprite_add("workingset/diffuse_null.png", 1, false, false, 0, 0);
		
		var blockBloomObject = instance_create_depth(0, 0, 0, obj_block_bloom);
		var blockBloomSprite = sprite_add("workingset/bloom_null.png", 1, false, false, 0, 0);
		
		var itemDiffuseObject = instance_create_depth(0, 0, -10, obj_item_diffuse);
		var itemDiffuseSprite = sprite_add("workingset/diffuse_null.png", 1, false, false, 0, 0);
		
		ds_list_add(global.block_ids, "block_null");
		ds_list_add(global.item_ids, "item_null");
		
		for (var i = 0; i < array_length_1d(global.block_registry); i++)
		{
			{//DIFFUSE
				var assetDiffuseSurface = surface_create(32, 32);
				surface_set_target(assetDiffuseSurface);
			
				var revertToNull = false;
				
				for (var a = 0; a < ds_list_size(array_get(global.block_registry[i], 7)); a++)
				{
					var frameDetails = ds_list_find_value(array_get(global.block_registry[i], 7), a);
				
					var found = -1;
					var foundType = -1;
				
					for (var b = 0; b < ds_list_size(assets); b++)
					{
						if (array_get(ds_list_find_value(assets, b), 0) == frameDetails[0])
						{
							found = b + 1;
							foundType = array_get(ds_list_find_value(assets, b), 1);
							break;
						}
					}
				
					if (found == -1 || foundType != 0)
					{
						ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Load Asset> DIFFUSE texture \"" + frameDetails[0] + "\", has not been registered. Block\"" + array_get(global.block_registry[i], 0) + "\" will have a null texture");
						revertToNull = true;
						break;
					}
				
					draw_sprite_part_ext(sprite_index, found, frameDetails[1], frameDetails[2], frameDetails[3], frameDetails[4], frameDetails[5], frameDetails[6], frameDetails[7] / frameDetails[3], frameDetails[8] / frameDetails[4], c_white, 1);
				}
		
				if (revertToNull)
				{
					draw_sprite(sprite_index, 0, 0, 0);
				}
				
				sprite_add_from_surface(blockDiffuseSprite, assetDiffuseSurface, 0, 0, 32, 32, false, false);
				
				if (array_get(global.block_registry[i], 5) == "1")
				{
					sprite_add_from_surface(itemDiffuseSprite, assetDiffuseSurface, 0, 0, 32, 32, false, false);
					ds_list_add(global.item_ids, array_get(global.block_registry[i], 0));
				}
				
				surface_reset_target();
				surface_free(assetDiffuseSurface);
			}
			{//BLOOM
				var assetBloomSurface = surface_create(32, 32);
				surface_set_target(assetBloomSurface);
				
				var revertToNull = false;
				
				for (var a = 0; a < ds_list_size(array_get(global.block_registry[i], 8)); a++)
				{
					var frameDetails = ds_list_find_value(array_get(global.block_registry[i], 8), a);
				
					var found = -1;
					var foundType = -1;
				
					for (var b = 0; b < ds_list_size(assets); b++)
					{
						if (array_get(ds_list_find_value(assets, b), 0) == frameDetails[0])
						{
							found = b + 1;
							foundType = array_get(ds_list_find_value(assets, b), 1);
							break;
						}
					}
					
					if (found == -1 || foundType != 1)
					{
						//not having a bloom texture is fine, it will just be nothing
						//ds_list_add(compileMessages, " [Error] [ModHandler] <Failed to Load Asset> texture \"" + frameDetails[0] + "\", has not been registered. Block\"" + array_get(global.block_registry[i], 0) + "\" will have a null texture");
						revertToNull = true;
						break;
					}
				
					draw_sprite_part_ext(sprite_index, found, frameDetails[1], frameDetails[2], frameDetails[3], frameDetails[4], frameDetails[5], frameDetails[6], frameDetails[7] / frameDetails[3], frameDetails[8] / frameDetails[4], c_white, 1);
				}
				
				if (revertToNull)
				{
					draw_set_color(c_black);
					draw_rectangle(0, 0, 31, 31, false);
				}
				
				
				sprite_add_from_surface(blockBloomSprite, assetBloomSurface, 0, 0, 32, 32, false, false);
			
				surface_reset_target();
				surface_free(assetBloomSurface);
			}
			
			ds_list_add(global.block_ids, array_get(global.block_registry[i], 0));
		}
		
		for (var i = 0; i < array_length_1d(global.item_registry); i++)
		{
			itemDiffuseSprite = scr_merge_sprite(itemDiffuseSprite, "workingset/" + array_get(global.item_registry[i], 4) + ".png");
			ds_list_add(global.item_ids, array_get(global.item_registry[i], 0));
		}
		
		with (blockDiffuseObject)
		{
			sprite_assign(sprite_index, blockDiffuseSprite);
			
			bloomTextures = blockBloomObject;
		}
		
		with (blockBloomObject)
		{
			sprite_assign(sprite_index, blockBloomSprite);
		}
		
		with (itemDiffuseObject)
		{
			sprite_assign(sprite_index, itemDiffuseSprite);
		}
	}
	
	instance_destroy(assetsObject, false);
}

for (var i = 0; i < ds_list_size(compileMessages); i++)
{
	show_message(ds_list_find_value(compileMessages, i));
}
