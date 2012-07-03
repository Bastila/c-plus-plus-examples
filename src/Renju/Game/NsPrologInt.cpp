#include "NsPrologInt.h"

void Convert_pInt_to_pIntProlog(int *pInt, prolog_int *pIntProlog, int iArrayISize)
{
	prolog_int *pIntProlog_TMP = pIntProlog;
	int i = 0;
	do
	{
		pIntProlog_TMP->data = pInt[i];
		pIntProlog_TMP->is_eolist = NOT_END_OF_LIST;
		pIntProlog_TMP = pIntProlog_TMP->next;
		++i;
	}
	while(i < iArrayISize);

	pIntProlog_TMP->is_eolist = END_OF_LIST;
	pIntProlog_TMP->next = NsNullPointer;
}

void Convert_ppInt_to_pIntProlog(int **ppInt, prolog_int *pIntProlog, int iArrayISize, int iArrayJSize)
{
	int *pInt = new int[iArrayISize*iArrayJSize];

	for(int i = 0; i < iArrayISize*iArrayJSize; ++i)
	{
		pInt[i] = ppInt[i/iArrayISize][i%iArrayISize];
	}

	Convert_pInt_to_pIntProlog(pInt, pIntProlog, iArrayISize*iArrayJSize);
}

void Convert_pIntProlog_to_pInt(int *pInt, prolog_int *pIntProlog, int iArrayISize)
{
	int i = 0;
	prolog_int *pIntProlog_TMP = pIntProlog;
	while(pIntProlog_TMP->is_eolist == NOT_END_OF_LIST)
	{
		pInt[i] = pIntProlog_TMP->data;
		pIntProlog_TMP = pIntProlog_TMP->next;
		++i;
	}
}
void Convert_pIntProlog_to_ppInt(int **ppInt, prolog_int *pIntProlog, int iArrayISize, int iArrayJSize)
{
	int i = 0;
	prolog_int *pIntProlog_TMP = pIntProlog;
	while(pIntProlog_TMP->is_eolist == NOT_END_OF_LIST)
	{
		ppInt[i/iArrayISize][i%iArrayISize] = pIntProlog_TMP->data;
		pIntProlog_TMP = pIntProlog_TMP->next;
		++i;
	}
}
int Get_pIntProlog_Size(prolog_int *pIntProlog)
{
	int iSize = 0;
	prolog_int *pIntProlog_TMP = pIntProlog;

	while(pIntProlog_TMP->is_eolist == NOT_END_OF_LIST)
	{
		++iSize;
		pIntProlog_TMP = pIntProlog_TMP->next;
	}

	return iSize;
}
