#include "EnerverseVin.h"

void SetupCraftPoll()
{
	modHandler = (ModHandler*)malloc(sizeof(ModVin));
}

bool ModVin::InitializeAssets()
{
	return true;
}

class BlockDirt : public Block
{
public:
	BlockDirt()
		:Block("block_dirt", "Dirt", Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	bool IsItem() override
	{
		return true;
	}

	char* OnBlockCreate(char* arguments) override
	{
		unsigned char argumentCount = 0;
		unsigned short argumentsLength = strlen(arguments);
		
		for (unsigned short i = 0; i < argumentsLength; i++)
		{
			if (arguments[i] == ',')
				argumentCount++;
		}

		if (argumentCount != 1)
		{
			char* metaData = (char*)malloc(1);
			if (metaData == nullptr)
				return nullptr;

			metaData[0] = '\0';
			return metaData;
		}

		char* metaData = (char*)malloc(argumentsLength);
		if (metaData == nullptr)
			return nullptr;

		metaData[argumentsLength - 1] = '\0';

		for (unsigned short i = 0; i < argumentsLength - 1; i++)
		{
			metaData[i] = arguments[i];
		}

		return metaData;
	}

	char* OnBlockUpdate(char* metaData) override
	{
		unsigned short metaLength = strlen(metaData);

		for (signed short i = metaLength - 1; i > 0; i--)
		{
			if (metaData[i] == '9' && i != 0)
			{
				//HERE
				metaData[i] = '0';
				metaData[i - 1]++;
			}
		}

		return metaData;
	}
};

bool ModVin::InitializeModels()
{
	BlockDirt block = BlockDirt();
	

	BlockRegistry::RegisterBlock((Block*)&block);

	return true;
}

bool ModVin::InitializeVisuals()
{
	return true;
}
