#include "NsString.h"

int NsText::ToInt32(const NsString & value)
{
	return atoi(value.c_str());
}

NsString NsText::ToString(int value)
{
	char lBuffer[32];

	return std::string(itoa(value, lBuffer, 10));
}

bool NsText::IsNumber(NsChar value)
{
	return (value == '0' || value == '1' || value == '2' || value == '3' ||
		value == '4' || value == '5' || value == '6' ||
		value == '7' || value == '8' || value == '9');
}

float NsText::ToFloat(const NsString & value)
{
	return atof(value.c_str());
}

bool NsText::ToBool(const NsString & value)
{
	return value == "true";
}

NsString NsText::ToString(float value)
{
	std::ostringstream os;
	os << value;
	return os.str();
}

NsString NsText::ToString(bool value)
{
	if(value)
	{
		return "true";
	}
	else
	{
		return "false";
	}
}

std::string NsText::ToNarrowString(std::wstring wString)
{
	char pCharArray[528];
	WideCharToMultiByte(CP_ACP, 0, wString.c_str(), -1, pCharArray, wString.size(), NULL, NULL);
	pCharArray[wString.size()] = '\0';

	return std::string(pCharArray);
}

std::wstring NsText::ToWideString(std::string nString)
{
	WCHAR pWCharArray[528];
	MultiByteToWideChar(CP_ACP, 0, nString.c_str(), -1, pWCharArray, 528);
	return std::wstring(pWCharArray);
}