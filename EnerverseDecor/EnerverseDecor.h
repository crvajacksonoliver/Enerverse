#pragma once

#include "CraftPoll.h"

class ModDecor : public ModHandler
{
public:
	const char* GetModUnlocalizedName() override;

	bool InitializeAssets() override;
	bool InitializeModels() override;
	bool InitializeItems() override;
	bool InitializeVisuals() override;
};