#include <vector>
#include <string>

enum Status
{
	OK, FAILED
};

enum Material
{
	EARTH, ROCK, METAL
};

enum Tool
{
	HAND, SHOVEL
};

/*

unlocalizedName
displayName
material
hardness
tool

*/
class Block
{
public:
	Block(Material mat, float hardness, Tool tool);

	// if true the engine will assume its and item and a block
	virtual bool IsItem();
private:
	Material m_mat;
	float m_hardness;
	Tool m_tool;

	Material GetMaterial();
	float GetHardness();
	Tool GetTool();
};

class BlockRegistry
{
public:
	// registers a block into the registry
	static Status RegisterBlock(Block* block);

	// engine call; called before model initialization
	static void Initialize();

	// engine call; called after model initialization
	static bool CompileBlocks();
	
	// engine call; called after model initialization
	static char* PullData();
private:
	static std::vector<std::string>* m_blocks;
	static char* m_data;
};

class ModHandler
{
public:
	// engine call; for version
	static double GetVersion();

	// register textures/guis
	virtual bool InitializeAssets();

	// register blocks/items
	virtual bool InitializeModels();

	// register mips/filters
	virtual bool InitializeVisual();
};