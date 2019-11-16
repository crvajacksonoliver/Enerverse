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

class BlockGrass : public Block
{
public:
	BlockGrass()
		:Block("block_grass", "Grass", Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/diffuse_grass", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}

	char* OnBlockCreate(char* arguments) override
	{
		GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), "EnerverseVin/block_sod", cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 2));

		char* metaData = (char*)malloc(2);
		metaData[0] = '2';
		metaData[1] = 0;

		return metaData;
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
		GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), "EnerverseDecor/block_lantern", cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 1));
		//GetSystemCommands()->RunBlockUpdate(GetBlockPosition(), 3000);

		return metaData;
	}

	char* OnBlockUpdate(char* metaData) override
	{
		//GetSystemCommands()->CallbackGetBlock(GetUnlocalizedName().c_str(), 3, cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y - 1));

		return metaData;
	}

	void CallbackGetBlock(Block* block, int id) override
	{
		//GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), block->GetUnlocalizedName().c_str(), cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 1));
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
