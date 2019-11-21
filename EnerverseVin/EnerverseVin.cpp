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
		//GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), "EnerverseVin/block_sod", cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 2));

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
		char* metaData = (char*)malloc(3);
		metaData[0] = '2';
		metaData[1] = '2';
		metaData[2] = 0;
		//GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), "EnerverseDecor/block_lantern", cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 1));
		GetSystemCommands()->RunBlockUpdate(GetBlockPosition(), 1000);

		return metaData;
	}

	char* OnBlockUpdate(char* metaData) override
	{
		GetSystemCommands()->CallbackGetBlockMetaData(GetUnlocalizedName().c_str(), GetBlockPosition(), 3, cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y - 1));
		GetSystemCommands()->CallbackGetBlock(GetUnlocalizedName().c_str(), GetBlockPosition(), 3, cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y - 1));
		
		if (metaData[0] == '1' && metaData[1] == '1')
		{
			GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), "EnerverseVin/block_grass", cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 2));
		}
		else
		{
			GetSystemCommands()->RunSetBlock(GetUnlocalizedName().c_str(), "EnerverseVin/block_dirt", cpm::Vector2<unsigned int>(GetBlockPosition().X, GetBlockPosition().Y + 2));
		}
		
		GetSystemCommands()->RunBlockUpdate(GetBlockPosition(), 1000);

		return metaData;
	}

	void CallbackGetBlock(const char* unlocalizedName, int id) override
	{
		if (id == 3 && strcmp(unlocalizedName, "EnerverseDecor/block_lantern") == 0)
			GetSystemCommands()->RunSetBlockMetaDataChar(GetUnlocalizedName().c_str(), '1', 0, GetBlockPosition());
		else
			GetSystemCommands()->RunSetBlockMetaDataChar(GetUnlocalizedName().c_str(), '0', 0, GetBlockPosition());
	}

	void CallbackGetBlockMeta(const char* metaData, int id) override
	{
		if (id == 3 && strcmp(metaData, "1") == 0)
			GetSystemCommands()->RunSetBlockMetaDataChar(GetUnlocalizedName().c_str(), '1', 1, GetBlockPosition());
		else
			GetSystemCommands()->RunSetBlockMetaDataChar(GetUnlocalizedName().c_str(), '0', 1, GetBlockPosition());
	}
};

class BlockAir : public Block
{
public:
	BlockAir()
		:Block("block_air", "Air", Material::EARTH, -1.0f, Tool::HAND)
	{

	}

	Model* GetDiffuseModel() override
	{
		Model* model = new Model();
		model->AddElement(new ModelElement("EnerverseVin/blocks/diffuse_air", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

		return model;
	}
};

class ItemTest : public Item
{
public:
	ItemTest()
		:Item("item_test", "Test Item")
	{

	}

	const char* GetDiffuseTexture()
	{
		return "EnerverseVin/items/diffuse_test";
	}
};

const char* ModVin::GetModUnlocalizedName()
{
	return "EnerverseVin";
}

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
