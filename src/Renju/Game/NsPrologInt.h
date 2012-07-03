#pragma once
#include "../../Shared/Common/NsIncludes.h"

///////////////////////////////////////////////////////////////////
//			Конвертация C++ int в Prolog integer
//Внимание!
//Перед использованием функций 
//необходимо выделить память:
//prolog_int *pIntProlog = new prolog_int();
//int i = iSize-1;
//do
//{
//	prolog_int *pIntProlog_TMP = new prolog_int();
//	pIntProlog_TMP->next = pIntProlog;
//	pIntProlog = pIntProlog_TMP;
//	--i;
//}
//while (i >= 0);
///////////////////////////////////////////////////////////////////

#define END_OF_LIST 2
#define NOT_END_OF_LIST 1

struct prolog_int
{
	unsigned int is_eolist;
	int data;
	struct prolog_int *next;
};

void Convert_pInt_to_pIntProlog(int *pInt, prolog_int *pIntProlog, int iArrayISize);
void Convert_ppInt_to_pIntProlog(int **ppInt, prolog_int *pIntProlog, int iArrayISize, int iArrayJSize);
void Convert_pIntProlog_to_pInt(int *pInt, prolog_int *pIntProlog, int iArrayISize);
void Convert_pIntProlog_to_ppInt(int **ppInt, prolog_int *pIntProlog, int iArrayISize, int iArrayJSize);
int Get_pIntProlog_Size(prolog_int *pIntProlog);