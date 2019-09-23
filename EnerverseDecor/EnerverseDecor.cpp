#include "EnerverseDecor.h"

bool ModDecor::InitializeAssets()
{
	return true;
}

class BlockTest : public Block
{
public:
	BlockTest()
		:Block(Material::EARTH, 1.0f, Tool::SHOVEL)
	{

	}

	bool IsItem() override
	{
		return true;
	}
};

bool ModDecor::InitializeModels()
{
	BlockTest block = BlockTest();


	BlockRegistry::RegisterBlock((Block*)& block);

	return true;
}

bool ModDecor::InitializeVisual()
{
	return true;
}
