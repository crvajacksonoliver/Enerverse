#include "EnerverseDecor.h"

ModHandler* modHandler = new ModDecor();

class BlockLantern : public Block
{
public:
	BlockLantern()
		:Block("block_lantern", "Lantern", Material::METAL, 1.5f, Tool::HAND)
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

	char* OnBlockCreate(char* arguments) override
	{
		char* metaData = (char*)malloc(2);
		metaData[0] = '1';
		metaData[1] = 0;

		return metaData;
	}

	ItemStackList GetDrops()
	{
		ItemStackList list;

		list.AddItemStack(ItemStack("EnerverseDecor/block_lantern", 1));

		return list;
	}
};

const char* ModDecor::GetModUnlocalizedName()
{
	return "EnerverseDecor";
}

bool ModDecor::InitializeAssets()
{
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/diffuse_lantern", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/bloom_lantern", AssetType::BLOCK_BLOOM);

	return true;
}

bool ModDecor::InitializeModels()
{
	BlockLantern* block_lantern = new BlockLantern();

	BlockRegistry::RegisterBlock((Block*)block_lantern);

	return true;
}

bool ModDecor::InitializeItems()
{
	return true;
}

bool ModDecor::InitializeVisuals()
{
	return true;
}
