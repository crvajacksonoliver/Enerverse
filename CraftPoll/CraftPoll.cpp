#include "CraftPoll.h"

Block::Block(std::string unlocalizedName, std::string displayName, Material mat, float hardness, Tool tool)
	:m_unlocalizedName(unlocalizedName), m_displayName(displayName), m_mat(mat), m_hardness(hardness), m_tool(tool)
{

}

unsigned int BlockRegistry::MaterialConvert(Material mat)
{
	switch (mat)
	{
	case Material::EARTH: return 0;
	case Material::METAL: return 1;
	case Material::ROCK: return 2;
	}
}

unsigned int BlockRegistry::ToolConvert(Tool tool)
{
	switch (tool)
	{
	case Tool::HAND: return 0;
	case Tool::SHOVEL: return 1;
	}
}

bool Block::IsItem()
{
	return true;
}

Model* Block::GetDiffuseModel()
{
	Model* model = new Model();
	model->AddElement(new ModelElement("@NULL", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

	return model;
}

Model* Block::GetBloomModel()
{
	Model* model = new Model();
	model->AddElement(new ModelElement("@NULL", cpm::RectangleBox(0, 0, 32, 32), cpm::RectangleBox(0, 0, 32, 32)));

	return model;
}

char* Block::OnBlockCreate(char* arguments)
{
	char* metaData = (char*)malloc(2);
	metaData[0] = '1';
	metaData[1] = 0;

	return metaData;
}

char* Block::OnBlockUpdate(char* metaData)
{
	return metaData;
}

void Block::OnBlockDestroy(char* metaData)
{

}

void Block::CallbackGetBlock(Block* block, int id)
{

}

void Block::CallbackGetBlockMeta(char* metaData, int id)
{

}

const std::string& Block::GetUnlocalizedName()
{
	return m_unlocalizedName;
}

const std::string& Block::GetDisplayName()
{
	return m_displayName;
}

Material Block::GetMaterial()
{
	return m_mat;
}

float Block::GetHardness()
{
	return m_hardness;
}

Tool Block::GetTool()
{
	return m_tool;
}

SystemCommands* Block::GetSystemCommands()
{
	return &m_sysCommands;
}

std::vector<Block*>* BlockRegistry::m_blocks;
std::vector<std::string>* BlockRegistry::m_blockText;
char* BlockRegistry::m_data;

Status BlockRegistry::RegisterBlock(Block* block)
{
	m_blocks->push_back(block);

	std::string* blockText = new std::string("");
	*blockText += block->GetUnlocalizedName();
	*blockText += ",";
	*blockText += block->GetDisplayName();
	*blockText += ",";
	*blockText += std::to_string(MaterialConvert(block->GetMaterial()));
	*blockText += ",";
	*blockText += std::to_string(ToolConvert(block->GetTool()));
	*blockText += ",";
	*blockText += std::to_string(block->GetHardness());
	*blockText += ",";
	*blockText += std::to_string(block->IsItem() ? 1 : 0);
	*blockText += ",";

	// add model

	Model* blockDiffuseModel = block->GetDiffuseModel();
	std::vector<ModelElement*>* blockDiffuseModelElements = blockDiffuseModel->GetElements();

	Model* blockBloomModel = block->GetBloomModel();
	std::vector<ModelElement*>* blockBloomkModelElements = blockBloomModel->GetElements();

	for (unsigned int i = 0; i < blockDiffuseModelElements->size(); i++)
	{
		cpm::RectangleBox source = (*blockDiffuseModelElements)[i]->GetSource();
		cpm::RectangleBox destination = (*blockDiffuseModelElements)[i]->GetDestination();

		*blockText += (*blockDiffuseModelElements)[i]->GetTexturePath();
		*blockText += ",";
		*blockText += std::to_string(source.GetPosition().X);
		*blockText += ",";
		*blockText += std::to_string(source.GetPosition().Y);
		*blockText += ",";
		*blockText += std::to_string(source.GetSize().X);
		*blockText += ",";
		*blockText += std::to_string(source.GetSize().Y);
		*blockText += ",";
		*blockText += std::to_string(destination.GetPosition().X);
		*blockText += ",";
		*blockText += std::to_string(destination.GetPosition().Y);
		*blockText += ",";
		*blockText += std::to_string(destination.GetSize().X);
		*blockText += ",";
		*blockText += std::to_string(destination.GetSize().Y);
		*blockText += ",";

		if (i == blockDiffuseModelElements->size() - 1)
			*blockText += ";";
	}

	for (unsigned int i = 0; i < blockBloomkModelElements->size(); i++)
	{
		cpm::RectangleBox source = (*blockBloomkModelElements)[i]->GetSource();
		cpm::RectangleBox destination = (*blockBloomkModelElements)[i]->GetDestination();

		*blockText += (*blockBloomkModelElements)[i]->GetTexturePath();
		*blockText += ",";
		*blockText += std::to_string(source.GetPosition().X);
		*blockText += ",";
		*blockText += std::to_string(source.GetPosition().Y);
		*blockText += ",";
		*blockText += std::to_string(source.GetSize().X);
		*blockText += ",";
		*blockText += std::to_string(source.GetSize().Y);
		*blockText += ",";
		*blockText += std::to_string(destination.GetPosition().X);
		*blockText += ",";
		*blockText += std::to_string(destination.GetPosition().Y);
		*blockText += ",";
		*blockText += std::to_string(destination.GetSize().X);
		*blockText += ",";
		*blockText += std::to_string(destination.GetSize().Y);
		*blockText += ",";

		if (i == blockBloomkModelElements->size() - 1)
			*blockText += ";";
	}

	m_blockText->push_back(*blockText);

	delete blockText;
	
	delete blockDiffuseModel;
	delete blockBloomModel;

	return Status::OK;
}

void BlockRegistry::Allocate()
{
	m_blockText = new std::vector<std::string>();
	m_blocks = new std::vector<Block*>();
}

void BlockRegistry::Deallocate()
{
	delete m_blockText;
	delete m_blocks;

	m_blockText = nullptr;
	m_blocks = nullptr;
}

bool BlockRegistry::CompileBlocks()
{
	unsigned long long totalLength = 0;

	for (unsigned int i = 0; i < m_blockText->size(); i++)
	{
		totalLength += (*m_blockText)[i].length();
	}

	m_data = (char*)malloc(totalLength + 1);
	if (m_data == nullptr)
		return false;

	m_data[totalLength] = '\0';

	unsigned int currentLine = 0;
	unsigned short currentChar = 0;

	for (unsigned long long i = 0; i < totalLength; i++)
	{
		if (currentChar == (*m_blockText)[currentLine].length())
		{
			currentChar = 0;
			currentLine++;
		}

		m_data[i] = (*m_blockText)[currentLine][currentChar];

		currentChar++;
	}

	return true;
}

char* BlockRegistry::PullData()
{
	return m_data;
}

char* BlockRegistry::BlockCreate(char* unlocalizedName, char* arguments)
{
	for (unsigned int i = 0; i < m_blocks->size(); i++)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), unlocalizedName) == 0)
		{
			std::string meta = SystemCommands::TreatString(std::string((*m_blocks)[i]->OnBlockCreate(arguments)));
			std::string commands = CompileCommands();

			std::string result = std::string();

			result += "0;";
			result += commands;
			result += std::string(meta);
			result += ";";

			char* shouldntSegfault = (char*)malloc(result.size());
			strcpy(shouldntSegfault, result.c_str());
			return shouldntSegfault;
		}
	}

	return nullptr;
}

char* BlockRegistry::BlockUpdate(char* unlocalizedName, char* metaData)
{
	for (unsigned int i = 0; i < m_blocks->size(); i++)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), unlocalizedName) == 0)
		{
			std::string meta = SystemCommands::TreatString(std::string((*m_blocks)[i]->OnBlockUpdate(metaData)));
			std::string commands = CompileCommands();

			std::string result = std::string();

			result += "0;";
			result += commands;
			result += std::string(meta);
			result += ";";

			char* shouldntSegfault = (char*)malloc(result.size());
			strcpy(shouldntSegfault, result.c_str());
			return shouldntSegfault;
		}
	}

	return nullptr;
}

char* BlockRegistry::BlockDestroy(char* unlocalizedName, char* metaData)
{
	for (unsigned int i = 0; i < m_blocks->size(); i++)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), unlocalizedName) == 0)
		{
			(*m_blocks)[i]->OnBlockDestroy(metaData);
			std::string commands = CompileCommands();

			std::string result = std::string();
			result += "1;";
			result += commands;

			char* shouldntSegfault = (char*)malloc(result.size());
			strcpy(shouldntSegfault, result.c_str());
			return shouldntSegfault;
		}
	}

	return nullptr;
}

char* BlockRegistry::BlockCallbackGetBlock(char* callerUnlocalizedName, char* unlocalizedName, int id)
{
	for (unsigned int i = 0; i < m_blocks->size(); i++)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), callerUnlocalizedName) == 0)
		{
			Block* block = new Block();
			*block = *((*m_blocks)[i]);

			(*m_blocks)[i]->CallbackGetBlock(block, id);
			std::string commands = CompileCommands();

			std::string result = std::string();
			result += "1;";
			result += commands;

			char* shouldntSegfault = (char*)malloc(result.size());
			strcpy(shouldntSegfault, result.c_str());
			return shouldntSegfault;
		}
	}

	return nullptr;
}

char* BlockRegistry::BlockCallbackGetBlockMetaData(char* callerUnlocalizedName,  char* metaData, int id)
{
	for (unsigned int i = 0; i < m_blocks->size(); i++)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), callerUnlocalizedName) == 0)
		{
			(*m_blocks)[i]->CallbackGetBlockMeta(metaData, id);
			std::string commands = CompileCommands();

			std::string result = std::string();
			result += "1;";
			result += commands;

			char* shouldntSegfault = (char*)malloc(result.size());
			strcpy(shouldntSegfault, result.c_str());
			return shouldntSegfault;
		}
	}

	return nullptr;
}

std::string BlockRegistry::CompileCommands()
{
	unsigned int fullLength = 0;
	std::vector<std::string>* allSysCommands = new std::vector<std::string>();
	for (unsigned int i = 0; i < m_blocks->size(); i++)
	{
		std::string command = (*m_blocks)[i]->GetSystemCommands()->PullCommand();
		allSysCommands->push_back(command);
		(*m_blocks)[i]->GetSystemCommands()->ClearCommand();
		fullLength += command.length();
	}

	std::string full = std::string();
	unsigned int count = 0;

	for (unsigned int i = 0; i < allSysCommands->size(); i++)
	{
		full += (*allSysCommands)[i];
		count += (*allSysCommands)[i].length();
	}

	//if (full.length() == 0)
	//	return std::string(";");

	return full;
}

double ModHandler::GetVersion()
{
	return 1.0;
}

bool ModHandler::InitializeAssets()
{
	return true;
}

bool ModHandler::InitializeModels()
{
	return true;
}

bool ModHandler::InitializeVisuals()
{
	return true;
}

unsigned int AssetRegistry::AssetConvert(AssetType assetType)
{
	switch (assetType)
	{
	case AssetType::BLOCK_DIFFUSE: return 0;
	case AssetType::BLOCK_BLOOM: return 1;
	case AssetType::GUI_DIFFUSE: return 2;
	}
}

Status AssetRegistry::RegisterAsset(const char* path, AssetType assetType)
{
	Asset* asset = new Asset(std::string(path), assetType);
	m_assets->push_back(asset);

	std::string* assetText = new std::string("");
	*assetText += path;
	*assetText += ",";
	*assetText += std::to_string(AssetConvert(assetType));
	*assetText += ",";

	m_assetText->push_back(*assetText);
	delete assetText;

	return Status::OK;
}

void AssetRegistry::Allocate()
{
	m_assets = new std::vector<Asset*>();
	m_assetText = new std::vector<std::string>();
}

void AssetRegistry::Deallocate()
{
	delete m_assets;
	delete m_assetText;
}

bool AssetRegistry::CompileAssets()
{
	unsigned long long totalLength = 0;

	for (unsigned int i = 0; i < m_assetText->size(); i++)
	{
		totalLength += (*m_assetText)[i].length();
	}

	m_data = (char*)malloc(totalLength + 1);
	if (m_data == nullptr)
		return false;

	m_data[totalLength] = '\0';

	unsigned int currentLine = 0;
	unsigned short currentChar = 0;

	for (unsigned long long i = 0; i < totalLength; i++)
	{
		if (currentChar == (*m_assetText)[currentLine].length())
		{
			currentChar = 0;
			currentLine++;
		}

		m_data[i] = (*m_assetText)[currentLine][currentChar];

		currentChar++;
	}

	return true;
}

char* AssetRegistry::PullData()
{
	return m_data;
}

std::vector<Asset*>* AssetRegistry::m_assets;

std::vector<std::string>* AssetRegistry::m_assetText;

char* AssetRegistry::m_data;

Model::Model()
{
	m_Elements = new std::vector<ModelElement*>();
}

Model::~Model()
{
	delete m_Elements;
}

void Model::AddElement(ModelElement* element)
{
	m_Elements->push_back(element);
}

std::vector<ModelElement*>* Model::GetElements()
{
	return m_Elements;
}

std::string SystemCommands::PullCommand()
{
	return m_command;
}

void SystemCommands::ClearCommand()
{
	m_command.clear();
}

void SystemCommands::RunSetBlock(const char* callerUnlocalizedName, const char* blockUnlocalizedName, cpm::Vector2<unsigned int> blockPos, const char* parameters)
{
	m_command += "0;";
	m_command += TreatString(std::to_string(blockPos.X));
	m_command += ";";
	m_command += TreatString(std::to_string(blockPos.Y));
	m_command += ";";
	m_command += TreatString(blockUnlocalizedName);
	m_command += ";";
	m_command += TreatString(parameters);
	m_command += ";";
}

void SystemCommands::CallbackGetBlock(const char* callerUnlocalizedName, int id, cpm::Vector2<unsigned int> blockPos)
{
	m_command += "1;";
	m_command += TreatString(std::to_string(blockPos.X));
	m_command += ";";
	m_command += TreatString(std::to_string(blockPos.Y));
	m_command += ";";
	m_command += TreatString(std::to_string(id));
	m_command += ";";
}

void SystemCommands::CallbackGetBlockMetaData(const char* callerUnlocalizedName, int id, cpm::Vector2<unsigned int> blockPos)
{
	m_command += "2;";
	m_command += TreatString(std::to_string(blockPos.X));
	m_command += ";";
	m_command += TreatString(std::to_string(blockPos.Y));
	m_command += ";";
	m_command += TreatString(std::to_string(id));
	m_command += ";";
}

std::string SystemCommands::TreatString(std::string untreated)
{
	std::string treated = std::string();

	for (unsigned int i = 0; i < untreated.length(); i++)
	{
		if (untreated[i] == '\\')
			treated += "\\\\";
		else if (untreated[i] == ';')
			treated += "\\;";
		else
			treated += untreated[i];
	}

	return treated;
}
