#include "EnerverseVin.h"

bool ModVin::InitializeAssets()
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

bool ModVin::InitializeModels()
{
	BlockTest block = BlockTest();
	

	BlockRegistry::RegisterBlock((Block*)&block);

	return true;
}

bool ModVin::InitializeVisual()
{
	return true;
}
