#include <vector>
#include <string>
#include <memory>

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
	Block(std::string unlocalizedName, std::string displayName, Material mat, float hardness, Tool tool);

	// if true the engine will assume its and item and a block
	virtual bool IsItem();

	virtual Model* GetDiffuseModel();
	virtual Model* GetBloomModel();

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

	// engine call; on create
	static char* BlockCreate(char* unlocalizedName, char* arguments);
	static char* BlockUpdate(char* unlocalizedName, char* metaData);
	static char* BlockDestroy(char* unlocalizedName, char* metaData);
private:
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

	// register textures/guis
	virtual bool InitializeAssets();

	// register blocks/items
	virtual bool InitializeModels();

	// register mips/filters
	virtual bool InitializeVisuals();
};

extern ModHandler* modHandler;