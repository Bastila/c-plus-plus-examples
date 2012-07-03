#pragma once
#include "../Common/NsIncludes.h"
#include <string>
#include <sstream>

typedef std::string NsString;
typedef char NsChar;

class NsText
{
public:
	static bool IsNumber(NsChar value);

	static int ToInt32(const NsString & value);
	static float ToFloat(const NsString & value);
	static bool ToBool(const NsString & value);

	static NsString ToString(int value);
	static NsString ToString(float value);
	static NsString ToString(bool value);
	
	static std::string ToNarrowString(std::wstring wString);
	static std::wstring ToWideString(std::string nString);
};