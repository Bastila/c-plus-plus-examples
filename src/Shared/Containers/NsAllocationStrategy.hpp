#pragma once

template <int iIncreasePercentage = 100>
class NsAllocationStrategy
{
public:
	NsInline NsAllocationStrategy() throw () {}
	NsInline NsAllocationStrategy(const NsAllocationStrategy &) throw () {}
	NsInline ~NsAllocationStrategy() throw () {}
		
	NsInline int CheckSizes(int iCurrentSize, int iTotalSize)
	{
		int iFilledPercentage = 100;
		return 100 * (float)iCurrentSize / (float)iTotalSize >= iFilledPercentage ? (float)iTotalSize * ((float)(iIncreasePercentage + 100) / 100.f) : iTotalSize;
	}
};