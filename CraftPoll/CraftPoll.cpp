#include "CraftPoll.h"

Block::Block(Material mat, float hardness, Tool tool)
	:m_mat(mat), m_hardness(hardness), m_tool(tool)
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

std::vector<std::string>* BlockRegistry::m_blocks;
char* BlockRegistry::m_data;

Status BlockRegistry::RegisterBlock(Block* block)
{
	m_blocks->push_back(std::string(""));
	return Status::OK;
}

void BlockRegistry::Initialize()
{
	m_blocks = new std::vector<std::string>();
}

bool BlockRegistry::CompileBlocks()
{
	const char* blocks = "dirt,Dirt,0,1.0,1,grass,Grass,0,1.0,1;";//temporary
	unsigned int blocksLength = 38;//dose not include null byte

	m_data = (char*)malloc((unsigned long long)blocksLength + unsigned char(1));
	m_data = (char*)blocks;//temporary
	m_data[blocksLength] = '\0';

	return true;
}

char* BlockRegistry::PullData()
{
	return m_data;
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