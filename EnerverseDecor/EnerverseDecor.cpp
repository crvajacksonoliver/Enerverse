#include "EnerverseDecor.h"

ModHandler* modHandler = new ModDecor();

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
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/diffuse_lantern", AssetType::BLOCK_DIFFUSE);
	AssetRegistry::RegisterAsset("EnerverseDecor/blocks/bloom_lantern", AssetType::BLOCK_BLOOM);

	return true;
}

bool ModDecor::InitializeModels()
{
	BlockLantern* block_lantern = new BlockLantern();

	BlockRegistry::RegisterBlock(std::shared_ptr<Block>(block_lantern));

	return true;
}

bool ModDecor::InitializeVisuals()
{
	return true;
}
