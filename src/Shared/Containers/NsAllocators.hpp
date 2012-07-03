#pragma once
#include "../Common/NsIncludes.h"

template <typename ValueType>
class NsAllocator
{
public:
	NsInline NsAllocator() throw () {}
	NsInline NsAllocator(const NsAllocator &) throw () {}
	NsInline ~NsAllocator() throw () {}
		
	NsInline ValueType * Address(ValueType & rValue) const { return &rValue; }
	NsInline const ValueType * Address(const ValueType & crValue) const { return &crValue; }
	NsInline ValueType * Allocate(int iCount) { return (ValueType *)NsMalloc(iCount*sizeof(ValueType)); }
	NsInline void Construct(ValueType * pValue, const ValueType & crValue) { new(pValue) ValueType(crValue); }
	NsInline void Destroy(ValueType * pValue) { pValue->~ValueType(); }
	NsInline void Deallocate(ValueType * pValue, int iCount) { NsFree(pValue); }
};
	
template <class ValueType, int iAlign = 16>
class NsAllignedAllocator
{
public:
	NsInline NsAllignedAllocator() throw () {}
	NsInline NsAllignedAllocator(const NsAllignedAllocator &) throw () {}
	NsInline ~NsAllignedAllocator() throw () {}
		
	NsInline ValueType * Address(ValueType & rValue) const { return &rValue; }
	NsInline const ValueType * Address(const ValueType & crValue) const { return &crValue; }
	NsInline ValueType * Allocate(int iCount) { return (ValueType *)NsAlignedMalloc(iCount*sizeof(ValueType), iAlign); }
	NsInline void Construct(ValueType * pValue, const ValueType & crValue) { new(pValue) ValueType(crValue); }
	NsInline void Destroy(ValueType * pValue) { pValue->~ValueType(); }
	NsInline void Deallocate(ValueType * pValue, int iCount) { NsAlignedFree(pValue); }
};