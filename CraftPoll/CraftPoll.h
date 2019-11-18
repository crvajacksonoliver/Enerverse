#include <vector>
#include <string>
#include <memory>
#include <functional>

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

enum AssetType
{
	BLOCK_DIFFUSE, BLOCK_BLOOM, GUI_DIFFUSE
};

namespace cpm
{
	template<typename T>
	class Vector2
	{
	public:
		Vector2<T>(T v1, T v2)
			:X(v1), Y(v2), U(v1), V(v2)
		{

		}

		Vector2<T>()
			: X(0), Y(0), U(0), V(0)
		{

		}

		T X, Y, U, V;
	};

	class RectangleBox
	{
	public:
		RectangleBox(unsigned int x, unsigned int y, unsigned int width, unsigned int height)
			:m_X(x), m_Y(y), m_Width(width), m_Height(height)
		{

		}

		Vector2<unsigned int> GetPosition()
		{
			return Vector2<unsigned int>(m_X, m_Y);
		}

		Vector2<unsigned int> GetSize()
		{
			return Vector2<unsigned int>(m_Width, m_Height);
		}
	private:
		unsigned int m_X, m_Y, m_Width, m_Height;
	};
};

class SystemCommands
{
public:
	std::string PullCommand();
	void ClearCommand();
	static std::string TreatString(std::string untreated);
	
	void RunSetBlock(const char* callerUnlocalizedName, const char* blockUnlocalizedName, cpm::Vector2<unsigned int> blockPos, const char* parameters = "0,");
	void RunBlockUpdate(cpm::Vector2<unsigned int> blockPos, unsigned int milliseconds);

	void CallbackGetBlock(const char* callerUnlocalizedName, cpm::Vector2<unsigned int> callerBlockPos, int id, cpm::Vector2<unsigned int> blockPos);
	void CallbackGetBlockMetaData(const char* callerUnlocalizedName, int id, cpm::Vector2<unsigned int> blockPos);
private:
	std::string m_command;
};

class ModelElement
{
public:
	ModelElement(const char* texturePath, cpm::RectangleBox source, cpm::RectangleBox destination)
		:m_TexturePath(texturePath), m_Source(source), m_Destination(destination)
	{

	}

	const char* GetTexturePath()
	{
		return m_TexturePath;
	}
	
	cpm::RectangleBox GetSource()
	{
		return m_Source;
	}

	cpm::RectangleBox GetDestination()
	{
		return m_Destination;
	}
private:
	const char* m_TexturePath;
	cpm::RectangleBox m_Source;
	cpm::RectangleBox m_Destination;
};

// how textures are baked into a block/item
class Model
{
public:
	Model();
	~Model();
	
	void AddElement(ModelElement* element);

	std::vector<ModelElement*>* GetElements();
private:
	std::vector<ModelElement*>* m_Elements;
};

class Block
{
public:
	// dont use this constructor
	Block() { }

	Block(std::string unlocalizedName, std::string displayName, Material mat, float hardness, Tool tool);

	// if true the engine will assume its and item and a block
	virtual bool IsItem();

	virtual Model* GetDiffuseModel();
	virtual Model* GetBloomModel();

	virtual char* OnBlockCreate(char* arguments);
	virtual char* OnBlockUpdate(char* metaData);
	virtual void OnBlockDestroy(char* metaData);
	virtual void CallbackGetBlock(const char*, int id);
	virtual void CallbackGetBlockMeta(const char* metaData, int id);

	const std::string& GetUnlocalizedName();
	const std::string& GetDisplayName();

	Material GetMaterial();
	float GetHardness();
	Tool GetTool();
	cpm::Vector2<unsigned int> GetBlockPosition();

	//dont use this
	void SetBlockPosition(cpm::Vector2<unsigned int> position);

	SystemCommands* GetSystemCommands();
private:
	std::string m_unlocalizedName;
	std::string m_displayName;

	Material m_mat;
	float m_hardness;
	Tool m_tool;

	cpm::Vector2<unsigned int> m_position;
	SystemCommands m_sysCommands;
};

class BlockRegistry
{
public:
	static unsigned int MaterialConvert(Material mat);
	static unsigned int ToolConvert(Tool tool);

	// registers a block into the registry
	static Status RegisterBlock(Block* block);

	// engine internal call;
	static void Allocate();

	// engine internal call;
	static void Deallocate();

	// engine call; called after model initialization
	static bool CompileBlocks();
	
	// engine call; called after model initialization
	static char* PullData();

	// engine calls; basic block processing
	static char* BlockCreate(char* unlocalizedName, char* arguments, unsigned int blockX, unsigned int blockY);
	static char* BlockUpdate(char* unlocalizedName, char* metaData, unsigned int blockX, unsigned int blockY);
	static char* BlockDestroy(char* unlocalizedName, char* metaData, unsigned int blockX, unsigned int blockY);

	// engine calls; callbacks
	static char* BlockCallbackGetBlock(char* callerUnlocalizedName, char* unlocalizedName, int id, unsigned int blockX, unsigned int blockY);
	static char* BlockCallbackGetBlockMetaData(char* callerUnlocalizedName, char* metaData, int id, unsigned int blockX, unsigned int blockY);
private:
	static std::string CompileCommands();

	static std::vector<Block*>* m_blocks;
	static std::vector<std::string>* m_blockText;
	static char* m_data;
};

//only internal engine uses this class
class Asset
{
public:
	Asset(std::string path, AssetType assetType)
		:Path(path), Type(assetType) { }

	std::string Path;
	AssetType Type;
};

class AssetRegistry
{
public:
	static unsigned int AssetConvert(AssetType assetType);

	//registers asset details into the registry
	static Status RegisterAsset(const char* path, AssetType assetType);

	// engine internal call;
	static void Allocate();

	// engine internal call;
	static void Deallocate();

	// engine call; called after model initialization
	static bool CompileAssets();

	// engine call; called after model initialization
	static char* PullData();
private:
	static std::vector<Asset*>* m_assets;
	static std::vector<std::string>* m_assetText;
	static char* m_data;
};

extern class ModHandler
{
public:
	// engine call; for version
	static double GetVersion();

	// engine call; for name
	virtual const char* GetModUnlocalizedName();

	// register textures/guis
	virtual bool InitializeAssets();

	// register blocks/items
	virtual bool InitializeModels();

	// register mips/filters
	virtual bool InitializeVisuals();
};

extern ModHandler* modHandler;