#include "CraftPoll.h"

#include <functional>
#include <vector>
#include <string>

#define GM_EXPORT extern "C" __declspec (dllexport)

std::vector<double> SplitStringToDoubles(char* message)
{
	std::string inter = std::string();
	std::vector<double> values = std::vector<double>();

	for (unsigned int i = 0; i < strlen(message); i++)
	{
		if (message[i] == ';')
		{
			values.push_back(std::stod(inter));
			inter = "";
		}
		else
			inter += message[i];
	}

	return values;
}

//	Mod

GM_EXPORT double engine_version()
{
	return ModHandler::GetVersion();
}

GM_EXPORT char* engine_pull_assets()
{
	std::function<void()>* F_CLOSE = new std::function<void()>();
	*F_CLOSE = []()
	{
		AssetRegistry::Deallocate();
	};

	AssetRegistry::Allocate();

	if (modHandler->InitializeAssets())
	{
		if (!AssetRegistry::CompileAssets())
		{
			char* result = (char*)malloc(2);
			if (result == nullptr)
			{
				(*F_CLOSE)();
				delete F_CLOSE;
				return nullptr;
			}

			result[0] = '0';
			result[1] = '\0';

			(*F_CLOSE)();
			delete F_CLOSE;
			return result;
		}

		char* result = AssetRegistry::PullData();

		(*F_CLOSE)();
		delete F_CLOSE;
		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
		{
			(*F_CLOSE)();
			delete F_CLOSE;
			return nullptr;
		}

		result[0] = '0';
		result[1] = '\0';

		(*F_CLOSE)();
		delete F_CLOSE;
		return result;
	}
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
			{
				(*F_CLOSE)();
				delete F_CLOSE;
				return nullptr;
			}

			result[0] = '0';
			result[1] = '\0';

			(*F_CLOSE)();
			delete F_CLOSE;
			return result;
		}

		char* result = BlockRegistry::PullData();

		(*F_CLOSE)();
		delete F_CLOSE;
		return result;
	}
	else
	{
		char* result = (char*)malloc(2);
		if (result == nullptr)
		{
			(*F_CLOSE)();
			delete F_CLOSE;
			return nullptr;
		}

		result[0] = '0';
		result[1] = '\0';

		(*F_CLOSE)();
		delete F_CLOSE;
		return result;
	}
}

GM_EXPORT char* engine_pull_visuals()
{
	char* result = (char*)malloc(2);
	if (result == nullptr)
		return nullptr;

	result[0] = '0';
	result[1] = '\0';

	return result;
}

//	Blocks

GM_EXPORT char* engine_block_create(char* unlocalizedName, char* arguments, double blockX, double blockY)
{
	BlockRegistry::Allocate();
	modHandler->InitializeModels();
	BlockRegistry::CompileBlocks();
	return BlockRegistry::BlockCreate(unlocalizedName, arguments, (unsigned int)blockX, (unsigned int)blockY);
}

GM_EXPORT char* engine_block_update(char* unlocalizedName, char* metaData, double blockX, double blockY)
{
	BlockRegistry::Allocate();
	modHandler->InitializeModels();
	BlockRegistry::CompileBlocks();
	return BlockRegistry::BlockUpdate(unlocalizedName, metaData, (unsigned int)blockX, (unsigned int)blockY);
}

GM_EXPORT char* engine_block_destroy(char* unlocalizedName, char* metaData, double blockX, double blockY)
{
	BlockRegistry::Allocate();
	modHandler->InitializeModels();
	BlockRegistry::CompileBlocks();
	return BlockRegistry::BlockDestroy(unlocalizedName, metaData, (unsigned int)blockX, (unsigned int)blockY);
}

// Enerverse Calls

GM_EXPORT char* engine_block_sys0(char* callerUnlocalizedName, char* unlocalizedName, char* other)
{
	BlockRegistry::Allocate();
	modHandler->InitializeModels();
	BlockRegistry::CompileBlocks();

	std::vector<double> values = SplitStringToDoubles(other);
	/*
	id
	blockX
	blockY
	*/
	return BlockRegistry::BlockCallbackGetBlock(callerUnlocalizedName, unlocalizedName, (int)values[0], (unsigned int)values[1], (unsigned int)values[2]);
}

GM_EXPORT char* engine_block_sys1(char* callerUnlocalizedName, char* metaData, char* other)
{
	BlockRegistry::Allocate();
	modHandler->InitializeModels();
	BlockRegistry::CompileBlocks();

	std::vector<double> values = SplitStringToDoubles(other);
	/*
	id
	blockX
	blockY
	*/
	return BlockRegistry::BlockCallbackGetBlockMetaData(callerUnlocalizedName, metaData, (int)values[0], (unsigned int)values[1], (unsigned int)values[2]);
}