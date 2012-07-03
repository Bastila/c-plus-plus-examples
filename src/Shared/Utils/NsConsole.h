#pragma once
#include "../Common/NsIncludes.h"
#include "../Common/NsSingleton.hpp"
#include "../Containers/NsArray.hpp"
#include "../ResourceManagement/NsResourceManager.hpp"
#include "../Text/NsString.h"

class NsConsole : public NsSingleton<NsConsole>
{
	friend class NsSingleton<NsConsole>;

public:
	NsConsole(void);
	~NsConsole(void);

	void AddMessage(const char* cpMessage);
	void AddMessage(const NsString & sMessage);

	void Hide();
	void Show();
	void Toogle();

protected:
	bool _bShowing;
	NsArray<NsString> _messages;

	HANDLE _hLog;
	bool _bUseLog;
};