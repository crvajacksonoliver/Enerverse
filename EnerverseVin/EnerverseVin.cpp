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

bool ModVin::InitializeVisuals()
{
	return true;
}
