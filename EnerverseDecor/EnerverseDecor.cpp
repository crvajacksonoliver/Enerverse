#include "EnerverseDecor.h"

ModHandler* modHandler = new ModDecor();

class BlockGrass : public Block
{
public:
	BlockGrass()
		:Block("block_grass", "Grass", Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	bool IsItem() override
	{
		return true;
	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseDecor/blocks/diffuse_grass", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
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
};

class BlockLantern : public Block
{
public:
	BlockLantern()
		:Block("block_lantern", "Lantern", Material::METAL, 1.0f, Tool::HAND)
	{

	}

	bool IsItem() override
	{
		return true;
	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseDecor/blocks/diffuse_lantern", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}

	Model* GetBloomModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseDecor/blocks/bloom_lantern", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

bool ModDecor::InitializeAssets()
{
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/diffuse_grass", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/diffuse_lantern", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/bloom_lantern", AssetType::BLOCK_BLOOM);

	return true;
}

bool ModDecor::InitializeModels()
{
	BlockGrass* block_grass = new BlockGrass();
	BlockLantern* block_lantern = new BlockLantern();

	BlockRegistry::RegisterBlock((Block*)block_grass);
	BlockRegistry::RegisterBlock((Block*)block_lantern);

	return true;
}

bool ModDecor::InitializeVisuals()
{
	return true;
}
