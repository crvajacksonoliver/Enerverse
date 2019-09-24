#pragma once

#include "CraftPoll.h"

class ModDecor : public ModHandler
{
public:
	bool InitializeAssets() override;
	bool InitializeModels() override;
	bool InitializeVisuals() override;
};