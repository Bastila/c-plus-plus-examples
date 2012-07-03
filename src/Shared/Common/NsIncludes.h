#pragma once

// Windows includes
#include <windows.h>
#include <windowsx.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include <shlwapi.h>
#pragma comment(lib, "shlwapi.lib")

// ThereIsNoNsoon defines
#define NsInline inline 
#define NsForceInline __forceinline
#define NsNullPointer 0
#define NsShared __declspec(dllexport)

#define NsAlignedMalloc _aligned_malloc
#define NsAlignedFree _aligned_free
#define NsMalloc malloc
#define NsFree free
#define NsMemcpy memcpy