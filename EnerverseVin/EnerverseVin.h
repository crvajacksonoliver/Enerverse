#pragma once

#include "CraftPoll.h"

class ModVin : public ModHandler
{
public:
	const char* GetModUnlocalizedName() override;

	bool InitializeAssets() override;
	bool InitializeModels() override;
	bool InitializeItems() override;
	bool InitializeVisuals() override;
};