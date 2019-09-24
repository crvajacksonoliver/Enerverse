#include "CraftPoll.h"

#define GM_EXPORT extern "C" __declspec (dllexport)

//	Mod

GM_EXPORT double engine_version()
{
	return ModHandler::GetVersion();
}

GM_EXPORT char* engine_init()
{
	if (SetupCraftPoll == nullptr)
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '1';
		result[1] = '\0';

		SetupCraftPoll();

		return result;
	}
}

GM_EXPORT char* engine_init_assets()
{
	if (modHandler->InitializeAssets())
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '1';
		result[1] = '\0';

		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		return result;
	}
}

GM_EXPORT char* engine_init_models()
{
	if (modHandler->InitializeModels())
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '1';
		result[1] = '\0';

		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		return result;
	}
}

GM_EXPORT char* engine_init_visuals()
{
	if (modHandler->InitializeVisuals())
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '1';
		result[1] = '\0';

		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		return result;
	}
}

//	Blocks

GM_EXPORT char* engine_block_create(char* unlocalizedName, char* arguments)
{
	return BlockRegistry::BlockCreate(unlocalizedName, arguments);
}

GM_EXPORT char* engine_block_update(char* unlocalizedName, char* metaData)
{
	return BlockRegistry::BlockUpdate(unlocalizedName, metaData);
}

GM_EXPORT char* engine_block_destroy(char* unlocalizedName, char* metaData)
{
	return BlockRegistry::BlockDestroy(unlocalizedName, metaData);
}

GM_EXPORT char* engine_block_registry_initialize()
{
	try
	{
		BlockRegistry::Initialize();
	}
	catch (std::exception ex)
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		return result;
	}

	char* result = (char*)malloc(2);
	if (result == nullptr)
		return nullptr;

	result[0] = '1';
	result[1] = '\0';

	return result;
}

GM_EXPORT char* engine_block_registry_compile()
{
	if (BlockRegistry::CompileBlocks())
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '1';
		result[1] = '\0';

		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		return result;
	}
}

GM_EXPORT char* engine_block_registry_pull()
{
	return BlockRegistry::PullData();
}