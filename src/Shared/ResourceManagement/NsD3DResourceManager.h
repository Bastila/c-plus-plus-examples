#pragma once
#include "../Common/NsSingleton.hpp"
#include "../Utils/NsConsole.h"
#include "NsResourceManager.hpp"

class NsD3DResourceManager : public NsResourceManager, public NsSingleton<NsD3DResourceManager>
{
	friend class NsSingleton<NsD3DResourceManager>;

protected:
	NsD3DResourceManager();
	virtual ~NsD3DResourceManager();
};