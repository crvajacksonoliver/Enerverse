#include "CraftPoll.h"

#include <functional>

#define GM_EXPORT extern "C" __declspec (dllexport)

//	Mod

GM_EXPORT double engine_version()
{
	return ModHandler::GetVersion();
}

GM_EXPORT char* engine_pull_assets()
{
	char* result = (char*)malloc(2);
	if (result == nullptr)
		return nullptr;

	result[0] = '1';
	result[1] = '\0';

	return result;
}

GM_EXPORT char* engine_pull_models()
{
	std::function<void()>* F_CLOSE = new std::function<void()>();
	*F_CLOSE = []()
	{
		BlockRegistry::Deallocate();
	};

	BlockRegistry::Allocate();

	if (modHandler->InitializeModels())
	{
		if (!BlockRegistry::CompileBlocks())
		{
			char* result = (char*)malloc(2);
			if (result == nullptr)
				return nullptr;

			result[0] = '0';
			result[1] = '\0';

			(*F_CLOSE)();
			return result;
		}

		char* result = BlockRegistry::PullData();

		(*F_CLOSE)();
		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
			return nullptr;

		result[0] = '0';
		result[1] = '\0';

		(*F_CLOSE)();
		return result;
	}
}

GM_EXPORT char* engine_pull_visuals()
{
	char* result = (char*)malloc(2);
	if (result == nullptr)
		return nullptr;

	result[0] = '1';
	result[1] = '\0';

	return result;
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