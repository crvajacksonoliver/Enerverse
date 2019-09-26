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
	Block(std::string unlocalizedName, std::string displayName, Material mat, float hardness, Tool tool);

	// if true the engine will assume its and item and a block
	virtual bool IsItem();

	virtual char* OnBlockCreate(char* arguments);
	virtual char* OnBlockUpdate(char* metaData);
	virtual char* OnBlockDestroy(char* metaData);

	const std::string& GetUnlocalizedName();
	const std::string& GetDisplayName();

	Material GetMaterial();
	float GetHardness();
	Tool GetTool();
private:
	std::string m_unlocalizedName;
	std::string m_displayName;

	Material m_mat;
	float m_hardness;
	Tool m_tool;
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

	// engine call; on create
	static char* BlockCreate(char* unlocalizedName, char* arguments);
	static char* BlockUpdate(char* unlocalizedName, char* metaData);
	static char* BlockDestroy(char* unlocalizedName, char* metaData);
private:
	static std::vector<Block*>* m_blocks;
	static std::vector<std::string>* m_blockText;
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
	virtual bool InitializeVisuals();
};

extern ModHandler* modHandler;
extern void SetupCraftPoll();