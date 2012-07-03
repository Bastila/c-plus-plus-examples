#pragma once
#include "../../3rd party/TinyXML/tinyxml.h"
#include "../Text/NsString.h"

class NsResourceManager
{
public:
	NsResourceManager() {}
	virtual ~NsResourceManager() {}

	std::string GetRelativeContentFolderPath()
	{	
		if(_sRelativeContentFolderPath.size() == 0)
		{
			TiXmlDocument configDocument("NsTestbed.config");

			if(configDocument.LoadFile())
			{
				TiXmlElement * pRootNode = configDocument.RootElement();
				_sRelativeContentFolderPath = std::string(pRootNode->FirstChild("ContentFolderPath")->FirstChild()->Value());
			}
		}

		return _sRelativeContentFolderPath;
	}

	std::wstring GetAbsoluteContentFolderPath()
	{
		if(_wsAbsoluteContentFolderPath.size() == 0)
		{
			DWORD nCurrentDirectoryBufferLength = 512;
			WCHAR lpAbsoluteContentFolderPath[512];
			WCHAR lpCurrentDirectoryBuffer[512];
			std::wstring wsRelativeContentFolderPath;

			GetCurrentDirectory(nCurrentDirectoryBufferLength, lpCurrentDirectoryBuffer);
			wsRelativeContentFolderPath = NsText::ToWideString(GetRelativeContentFolderPath());
			PathCombine(lpAbsoluteContentFolderPath, lpCurrentDirectoryBuffer, wsRelativeContentFolderPath.c_str());
			
			_wsAbsoluteContentFolderPath = std::wstring(lpAbsoluteContentFolderPath);
			for(int i = 0; i < _wsAbsoluteContentFolderPath.size(); ++i)
			{
				if(_wsAbsoluteContentFolderPath[i] == '\\')
				{
					_wsAbsoluteContentFolderPath[i] = '/';
				}
			}
		}

		return _wsAbsoluteContentFolderPath;
	}

	bool UseLog()
	{
		TiXmlDocument configDocument("NsTestbed.config");

		if(configDocument.LoadFile())
		{
			TiXmlElement * pRootNode = configDocument.RootElement();
			if(std::string(pRootNode->FirstChild("UseLog")->FirstChild()->Value()) == "true")
			{
				return true;
			}
			else
			{
				return false;
			}
		}

		return true;
	}

protected:
	std::string _sRelativeContentFolderPath;
	std::wstring _wsAbsoluteContentFolderPath;
};