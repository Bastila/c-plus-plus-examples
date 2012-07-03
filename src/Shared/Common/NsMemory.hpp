#pragma once
#include <tchar.h>
#include <string.h>

class NsMemory
{
public:
	static int Compare(const void* __restrict pMem1, const void* __restrict pMem2, size_t numBytes)
	{
		return ::memcmp(pMem1, pMem2, numBytes);
	}

	static void Copy(void* __restrict pDestAddress, const void* __restrict pSrcAddress, size_t numBytes)
	{
		::memcpy(pDestAddress, pSrcAddress, numBytes);
	}

	static void Move(void* __restrict pDestAddress, const void* __restrict pSrcAddress, size_t numBytes)
	{
		::memmove(pDestAddress, pSrcAddress, numBytes);
	}

	static void Set(void* pAddress, int value, size_t numBytes)
	{
		::memset(pAddress, value, numBytes);
	}

	static void Zero(void* pAddress, size_t numBytes)
	{
		::memset(pAddress, 0, numBytes);
	}
};