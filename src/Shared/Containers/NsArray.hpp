#pragma once
#include "NsAllocators.hpp"
#include "NsAllocationStrategy.hpp"

template <class ValueType, class AllocationStrategyType = NsAllocationStrategy<>, class AllocatorType = NsAllocator<ValueType > >
class NsArray
{
public:
	NsArray();
	NsArray(const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource);
	~NsArray();

	void Clear();
	int Size() const;

	int GetAllocatedMemorySize();

	NsArray<ValueType, AllocationStrategyType, AllocatorType> &	operator =(const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource);
	const ValueType & operator [] (int iIndex) const;
	ValueType & operator [] (int iIndex);

	bool operator == (const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource);
	bool operator != (const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource);
	
	void Append(const ValueType & crNewElement);
	void Append(const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource);
	bool Contains(const ValueType & crElement) const;
	void Insert(const ValueType & crNewElement, int iIndex);
	bool IsEmpty() const;
	int FindIndex(const ValueType & crElement) const;
	ValueType & Last();
	bool RemoveAt(int iIndex);
	bool RemoveValue(const ValueType & crElement);

protected:
	void Resize(int iNewSize);
	
	int _iCurrentSize;
	int _iTotalSize;
	ValueType * _pArray;

	AllocatorType _allocator;
	AllocationStrategyType _allocationStrategy;
};

template <class ValueType, class AllocationStrategyType, class AllocatorType>
NsArray<ValueType, AllocationStrategyType, AllocatorType>::NsArray()
{
	_pArray = NsNullPointer;
	_iCurrentSize = 0;
	_iTotalSize = 0;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
NsArray<ValueType, AllocationStrategyType, AllocatorType>::NsArray(const NsArray<ValueType, AllocationStrategyType, AllocatorType> &crSource)
{
	_pArray = NsNullPointer;
	_iCurrentSize = 0;
	_iTotalSize = 0;

	*this = crSource;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
NsArray<ValueType, AllocationStrategyType, AllocatorType>::~NsArray()
{
	Clear();
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
void NsArray<ValueType, AllocationStrategyType, AllocatorType>::Append(const ValueType & crNewElement)
{
	if(_pArray)
	{
		Resize(_allocationStrategy.CheckSizes(_iCurrentSize, _iTotalSize));
		_iCurrentSize++;
	}
	else
	{
		_pArray = _allocator.Allocate(1);
		_allocator.Construct(_pArray, ValueType());

		_iCurrentSize = 1;
		_iTotalSize = 1;
	}
	
	_pArray[_iCurrentSize - 1] = crNewElement;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
void NsArray<ValueType, AllocationStrategyType, AllocatorType>::Append(const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource)
{
	if(_pArray)
	{
		Resize(_iCurrentSize + crSource._iCurrentSize);
	}
	else
	{
		_pArray = _allocator.Allocate(crSource._iCurrentSize);
		for(int i = 0; i < crSource._iCurrentSize; _allocator.Construct(_pArray + i, ValueType()), ++i);
		_iTotalSize = crSource._iCurrentSize;
	}
		
	int iLimit = _iCurrentSize + crSource._iCurrentSize;
	for(int i = _iCurrentSize; i < iLimit; ++i)
	{
		_pArray[i] = crSource._pArray[i - _iCurrentSize];
	}

	_iCurrentSize = _iTotalSize;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
bool NsArray<ValueType, AllocationStrategyType, AllocatorType>::Contains(const ValueType & crElement) const
{
	if(FindIndex(crElement) == -1)
	{
		return false;
	}
	else
	{
		return true;
	}
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
void NsArray<ValueType, AllocationStrategyType, AllocatorType>::Clear()
{
	if(_iTotalSize != 0)
	{
		for(int i = 0; i < _iTotalSize; _allocator.Destroy(_pArray + i), ++i);
		_allocator.Deallocate(_pArray, _iTotalSize);
	}

	_iCurrentSize = 0;
	_iTotalSize = 0;
	_pArray = NsNullPointer;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
int NsArray<ValueType, AllocationStrategyType, AllocatorType>::FindIndex(const ValueType & crElement) const
{
	for(int i = 0; i < _iCurrentSize; ++i)
	{
		if(_pArray[i] == crElement)
		{
			return i;
		}
	}

	return -1;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
int NsArray<ValueType, AllocationStrategyType, AllocatorType>::GetAllocatedMemorySize()
{
	return sizeof(ValueType)*_iTotalSize + sizeof(NsArray<ValueType, AllocationStrategyType, AllocatorType>);
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
bool NsArray<ValueType, AllocationStrategyType, AllocatorType>::IsEmpty() const
{
	return Size() == 0;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
void NsArray<ValueType, AllocationStrategyType, AllocatorType>::Insert(const ValueType & crNewElement, int iIndex)
{
	if((iIndex < 0 || iIndex >= _iCurrentSize) && iIndex != 0)
	{
		return;
	}

	if(_pArray)
	{
		Resize(_allocationStrategy.CheckSizes(_iCurrentSize, _iTotalSize));

		for(int i = _iCurrentSize; i > iIndex; --i)
		{
			_pArray[i] = _pArray[i-1];
		}

		_pArray[iIndex] = crNewElement;

		_iCurrentSize++;
	}
	else
	{
		Append(crNewElement);
	}
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
ValueType & NsArray<ValueType, AllocationStrategyType, AllocatorType>::Last()
{
	return _pArray[_iCurrentSize - 1];
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
int NsArray<ValueType, AllocationStrategyType, AllocatorType>::Size() const
{
	return _iCurrentSize;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
bool NsArray<ValueType, AllocationStrategyType, AllocatorType>::RemoveAt(int iIndex)
{
	if(iIndex < 0 || iIndex >= _iCurrentSize)
	{
		return false;
	}

	if(!_pArray)
	{
		return false;
	}

	_iCurrentSize--;

	for(int i = iIndex; i < _iCurrentSize; ++i)
	{
		_pArray[i] = _pArray[i+1];
	}

	if(_iCurrentSize == 0)
	{
		_allocator.Destroy(_pArray);
		_allocator.Deallocate(_pArray, 1);

		_pArray = NsNullPointer;
	}

	return true;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
bool NsArray<ValueType, AllocationStrategyType, AllocatorType>::RemoveValue(const ValueType & crElement)
{
	int iIndexToRemove = FindIndex(crElement);

	return RemoveAt(iIndexToRemove);
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
void NsArray<ValueType, AllocationStrategyType, AllocatorType>::Resize(int iNewSize)
{
	if(_iTotalSize == iNewSize)
	{
		return;
	}
		
	if(_iTotalSize > iNewSize)
	{
		for(int i = iNewSize; i < _iCurrentSize; _allocator.Destroy(_pArray + i), ++i);
		_iCurrentSize = iNewSize;
	}
	else
	{
		ValueType * lTmpList = _pArray;
		int lTmpListLength = _iTotalSize;

		_pArray = _allocator.Allocate(iNewSize);
		for(int i = 0; i < iNewSize; _allocator.Construct(_pArray + i, ValueType()), ++i);

		_iTotalSize = iNewSize;

		for(int i = 0; i < _iCurrentSize; ++i)
		{
			_pArray[i] = lTmpList[i];
		}

		if(lTmpList)
		{
			for(int i = 0; i < lTmpListLength; _allocator.Destroy(lTmpList + i), ++i);
			_allocator.Deallocate(lTmpList, lTmpListLength);
		}
	}
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
NsArray<ValueType, AllocationStrategyType, AllocatorType> & NsArray<ValueType, AllocationStrategyType, AllocatorType>::operator =(const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource)
{
	Clear();

	_iCurrentSize = crSource._iCurrentSize;
	_iTotalSize = crSource._iCurrentSize;

	if(_iCurrentSize)
	{
		_pArray = _allocator.Allocate(_iCurrentSize);
		for(int i = 0; i < _iCurrentSize; _allocator.Construct(_pArray + i, ValueType()), ++i);
		for(int i = 0; i < _iCurrentSize; ++i)
		{
			_pArray[i] = crSource._pArray[i];
		}
	}

	return *this;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
bool NsArray<ValueType, AllocationStrategyType, AllocatorType>::operator == (const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource)
{
	if(_iCurrentSize != crSource._iCurrentSize)
	{
		return false;
	}

	for(int i = 0; i < _iCurrentSize; ++i)
	{
		if(_pArray[i] != crSource._pArray[i])
		{
			return false;
		}
	}

	return true;
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
bool NsArray<ValueType, AllocationStrategyType, AllocatorType>::operator != (const NsArray<ValueType, AllocationStrategyType, AllocatorType> & crSource)
{
	return !((*this) == crSource);
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
const ValueType & NsArray<ValueType, AllocationStrategyType, AllocatorType>::operator[](int iIndex) const
{
	return _pArray[iIndex];
}

template <class ValueType, class AllocationStrategyType, class AllocatorType>
ValueType & NsArray<ValueType, AllocationStrategyType, AllocatorType>::operator[](int iIndex)
{
	return _pArray[iIndex];
}