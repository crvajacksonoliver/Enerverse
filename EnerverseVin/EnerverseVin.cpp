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

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/diffuse_dirt", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

class BlockGrass : public BlockDirt
{
public:
	BlockGrass()
		:BlockDirt("block_grass", "Grass", Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/diffuse_grass", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

class BlockSod : public Block// : public BlockDirt
{
public:
	BlockSod()
		:Block("block_sod", "Sod", Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/diffuse_sod", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}

	char* OnBlockCreate(char* arguments) override
	{
		char* metaData = (char*)malloc(2);
		metaData[0] = '5';
		metaData[1] = 0;

		return metaData;
	}

	char* OnBlockUpdate(char* metaData) override
	{
		unsigned short metaLength = strlen(metaData);

		for (unsigned short i = 0; i < metaLength; i++)
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

class BlockAir : public Block
{
public:
	BlockAir()
		:Block("block_air", "Air", Material::EARTH, 0.0f, Tool::HAND)
	{

	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/diffuse_air", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

bool ModVin::InitializeAssets()
{
	AssetRegistry::RegisterAsset("EnerverseVin/blocks/diffuse_dirt", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseVin/blocks/diffuse_grass", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseVin/blocks/diffuse_sod", AssetType::BLOCK_DIFFUSE);

	AssetRegistry::RegisterAsset("EnerverseVin/blocks/diffuse_air", AssetType::BLOCK_DIFFUSE);

	return true;
}

bool ModVin::InitializeModels()
{
	BlockDirt* block_dirt = new BlockDirt();
	BlockGrass* block_grass = new BlockGrass();
	BlockSod* block_sod = new BlockSod();

	BlockAir* block_air = new BlockAir();

	BlockRegistry::RegisterBlock((Block*)block_dirt);
	BlockRegistry::RegisterBlock((Block*)block_grass);
	BlockRegistry::RegisterBlock((Block*)block_sod);

	BlockRegistry::RegisterBlock((Block*)block_air);

	return true;
}

bool ModVin::InitializeVisuals()
{
	return true;
}
