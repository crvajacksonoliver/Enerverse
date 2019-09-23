#include "CraftPoll.h"

#define GM_EXPORT extern "C" __declspec (dllexport)

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

GM_EXPORT double engine_block_registry_compile()
{
	return BlockRegistry::CompileBlocks() ? 1 : 0;
}

GM_EXPORT char* engine_block_registry_pull()
{
	return BlockRegistry::PullData();
}

GM_EXPORT double engine_version()
{
	return ModHandler::GetVersion();
}