#include "EnerverseVin.h"

ModHandler* modHandler = new ModVin();

class BlockDirt : public Block
{
public:
	BlockDirt()
		:Block("block_dirt", "Dirt", Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	BlockDirt(std::string unlocalizedName, std::string displayName, Material mat, float hardness, Tool tool)
		:Block(unlocalizedName, displayName, mat, hardness, tool)
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
			if (metaData[i] == '9')
			{
				metaData[i] = '0';
			}
			else
			{
				metaData[i]++;
				break;
			}
		}

		return metaData;
	}

	Model* GetModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/dirt", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

class BlockSod : public BlockDirt
{
public:
	BlockSod()
		:BlockDirt("block_sod", "Sod", Material::EARTH, 1.0f, Tool::SHOVEL)
	{
		
	}

	Model* GetModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/sod", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

bool ModVin::InitializeAssets()
{
	AssetRegistry::RegisterAsset("EnerverseVin/blocks/dirt", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseVin/blocks/sod", AssetType::BLOCK_DIFFUSE);

	return true;
}

bool ModVin::InitializeModels()
{
	BlockDirt* block_dirt = new BlockDirt();
	BlockSod* block_sod = new BlockSod();

	BlockRegistry::RegisterBlock((Block*)block_dirt);
	BlockRegistry::RegisterBlock((Block*)block_sod);

	return true;
}

bool ModVin::InitializeVisuals()
{
	return true;
}
