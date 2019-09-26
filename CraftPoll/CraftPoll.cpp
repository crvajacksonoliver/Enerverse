#include "CraftPoll.h"

Block::Block(std::string unlocalizedName, std::string displayName, Material mat, float hardness, Tool tool)
	:m_unlocalizedName(unlocalizedName), m_displayName(displayName), m_mat(mat), m_hardness(hardness), m_tool(tool)
{

}

bool Block::IsItem()
{
	return true;
}

char* Block::OnBlockCreate(char* arguments)
{
	char* metaData = (char*)malloc(1);
	if (metaData == nullptr)
		return nullptr;

	metaData[0] = '\0';
	return metaData;
}

char* Block::OnBlockUpdate(char* metaData)
{
	return metaData;
}

char* Block::OnBlockDestroy(char* metaData)
{
	return metaData;
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
	*blockText += block->GetMaterial();
	*blockText += ",";
	*blockText += block->GetTool();
	*blockText += ",";
	*blockText += block->GetHardness();
	*blockText += ",";
	*blockText += block->IsItem();
	*blockText += ",";

	m_blockText->push_back(*blockText);
	delete blockText;

	return Status::OK;
}

void BlockRegistry::Initialize()
{
	m_blockText = new std::vector<std::string>();
	m_blocks = new std::vector<Block*>();
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
	for (signed int i = m_blocks->size() - 1; i > 0; i--)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), unlocalizedName) == 0)
		{
			return (*m_blocks)[i]->OnBlockCreate(arguments);
		}
	}

	return nullptr;
}

char* BlockRegistry::BlockUpdate(char* unlocalizedName, char* metaData)
{
	for (signed int i = m_blocks->size() - 1; i > 0; i--)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), unlocalizedName) == 0)
		{
			return (*m_blocks)[i]->OnBlockUpdate(metaData);
		}
	}

	return nullptr;
}

char* BlockRegistry::BlockDestroy(char* unlocalizedName, char* metaData)
{
	for (signed int i = m_blocks->size() - 1; i > 0; i--)
	{
		if (strcmp((*m_blocks)[i]->GetUnlocalizedName().c_str(), unlocalizedName) == 0)
		{
			return (*m_blocks)[i]->OnBlockDestroy(metaData);
		}
	}

	return nullptr;
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