#include "CraftPoll.h"

#define GM_EXPORT extern "C" __declspec (dllexport)

GM_EXPORT void engine_block_registry_initialize()
{
	BlockRegistry::Initialize();
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