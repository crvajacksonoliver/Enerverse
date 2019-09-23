#pragma once

#include "CraftPoll.h"

class ModVin : public ModHandler
{
public:
	bool InitializeAssets() override;
	bool InitializeModels() override;
	bool InitializeVisual() override;
};