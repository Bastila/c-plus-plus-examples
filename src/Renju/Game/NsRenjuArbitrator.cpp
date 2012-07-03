#include "NsRenjuArbitrator.h"
#include "NsPrologInt.h"

extern "C" void __stdcall export_execute_renju_human_is_black(prolog_int *, prolog_int **);
extern "C" void __stdcall export_execute_renju_check_the_game_end(prolog_int *, int *);

NsRenjuArbitrator::NsRenjuArbitrator(void)
{
}

NsRenjuArbitrator::~NsRenjuArbitrator(void)
{
}

int NsRenjuArbitrator::CheckGameOver(NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], NsCellValue AIColor)
{
	int iResult;
	int *ppBoard[NS_RENJU_NUM_ROWS];
	prolog_int *pIntProlog = new prolog_int();

	// выделяем память
	int i = NS_RENJU_NUM_ROWS*NS_RENJU_NUM_ROWS-1;
	do
	{
		prolog_int *pIntProlog_TMP = new prolog_int();
		pIntProlog_TMP->next = pIntProlog;
		pIntProlog = pIntProlog_TMP;
		--i;
	}
	while (i >= 0);

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		ppBoard[i] = new int[NS_RENJU_NUM_ROWS];
	}

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			ppBoard[i][j] = board[i][j];
		}
	}

	// конвертируем int** в prolog_int *
	Convert_ppInt_to_pIntProlog(ppBoard, pIntProlog, NS_RENJU_NUM_ROWS, NS_RENJU_NUM_ROWS);
	
	// вызываем предикат prolog-а
	export_execute_renju_check_the_game_end(pIntProlog, &iResult);

	// установка "свой" - чужой
	/*if(iResult != None)
	{
		if(AIColor == Black)
		{
			if(iResult == Friend)
			{
				return Black;
			}
			else
			{
				return White;
			}
		}
	}*/

	return iResult;	
}

bool NsRenjuArbitrator::CheckLegalBlackMove(NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], NsCellValue board_DEBUG[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], int iRowIndex, int iColumnIndex)
{
	int *ppCurrentBoard[NS_RENJU_NUM_ROWS];
	int *ppRestrictedBoard[NS_RENJU_NUM_ROWS];
	prolog_int *pipCurrentBoard = new prolog_int();
	prolog_int *pipRestrictedBoard = new prolog_int();

	// выделяем память
	int i = NS_RENJU_NUM_ROWS*NS_RENJU_NUM_ROWS-1;
	do
	{
		prolog_int *pIntProlog_TMP = new prolog_int();
		pIntProlog_TMP->next = pipCurrentBoard;
		pipCurrentBoard = pIntProlog_TMP;

		prolog_int *pIntProlog_TMP1 = new prolog_int();
		pIntProlog_TMP1->next = pipRestrictedBoard;
		pipRestrictedBoard = pIntProlog_TMP1;
		--i;
	}
	while (i >= 0);

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		ppCurrentBoard[i] = new int[NS_RENJU_NUM_ROWS];
		ppRestrictedBoard[i] = new int[NS_RENJU_NUM_ROWS];
	}

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			ppCurrentBoard[i][j] = board[i][j];
		}
	}

	// конвертируем int** в prolog_int *
	Convert_ppInt_to_pIntProlog(ppCurrentBoard, pipCurrentBoard, NS_RENJU_NUM_ROWS, NS_RENJU_NUM_ROWS);

	// вызываем предикат prolog-а
	export_execute_renju_human_is_black(pipCurrentBoard, &pipRestrictedBoard);

	// конвертируем prolog_int * в int**
	Convert_pIntProlog_to_ppInt(ppRestrictedBoard, pipRestrictedBoard, NS_RENJU_NUM_ROWS, NS_RENJU_NUM_ROWS);

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			board_DEBUG[i][j] = (NsCellValue)ppRestrictedBoard[i][j];
		}
	}

	if(board_DEBUG[iRowIndex][iColumnIndex] == Restricted_Next_Step)
	{
		return false;
	}
	else
	{
		return true;
	}

}
