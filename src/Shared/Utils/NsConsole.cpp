#include "NsConsole.h"

NsConsole::NsConsole()
{
	_bShowing = false;
		
	if(NsResourceManager().UseLog())
	{
		_hLog = CreateFile(L"NsTestbed.log", GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, 0, NULL);
		_bUseLog = !(_hLog == INVALID_HANDLE_VALUE);
	}
	else
	{
		_bUseLog = false;
	}
}

NsConsole::~NsConsole(void)
{
	if(_bShowing)
	{
		FreeConsole();
	}
}

void NsConsole::Show()
{
	AllocConsole();
	AttachConsole(GetCurrentProcessId());
	freopen("CON", "w", stdout);
	SetConsoleTitle(L"There Is No Spoon Console");
	_bShowing = true;

	for(int i = 0; i < _messages.Size(); ++i)
	{
		printf("%s\n", _messages[i].c_str());
	}
}

void NsConsole::Hide()
{
	FreeConsole();

	_bShowing = false;
}

void NsConsole::AddMessage(const char* cpMessage)
{
	if(_bShowing)
	{
		printf("%s\n", cpMessage);
	}
	if(_bUseLog)
	{
		DWORD dwBytesWritten;

		char cpMessageText[1000];
		*cpMessageText = '\n';
		strcpy(cpMessageText + 1, cpMessage);

		WriteFile(_hLog, (void*)&cpMessageText, sizeof(char)*(strlen(cpMessageText)), &dwBytesWritten, NULL);
	}
	_messages.Append(cpMessage);
}

void NsConsole::AddMessage(const NsString & sMessage)
{
	AddMessage(sMessage.c_str());
}

void NsConsole::Toogle()
{
	if(_bShowing)
	{
		Hide();
	}
	else
	{
		Show();
	}
}