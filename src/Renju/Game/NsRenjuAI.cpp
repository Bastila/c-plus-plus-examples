#include "NsRenjuAI.h"

extern "C" void __stdcall export_execute_renju_ai_is_white_debug(prolog_int *, prolog_int **, int *, int *);
extern "C" void __stdcall export_execute_renju_ai_is_black_debug(prolog_int *, prolog_int **, int *, int *);

NsRenjuAI::NsRenjuAI()
{
	AIColor = Black;

	pipCurrentBoard = new prolog_int();
	pipNextBoard = new prolog_int();

	// выделяем память
	int i = NS_RENJU_NUM_ROWS * NS_RENJU_NUM_ROWS - 1;
	do
	{
		prolog_int *pIntProlog_TMP = new prolog_int();
		pIntProlog_TMP->next = pipCurrentBoard;
		pipCurrentBoard = pIntProlog_TMP;

		prolog_int *pIntProlog_TMP1 = new prolog_int();
		pIntProlog_TMP1->next = pipNextBoard;
		pipNextBoard = pIntProlog_TMP1;
		--i;
	}
	while (i >= 0);

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		ppCurrentBoard[i] = new int[NS_RENJU_NUM_ROWS];
		ppNextBoard[i] = new int[NS_RENJU_NUM_ROWS];
	}
}

NsRenjuAI::~NsRenjuAI()
{
	prolog_int * pNextPrologInt;
	for(int i = 0; i < NS_RENJU_NUM_ROWS * NS_RENJU_NUM_ROWS; ++i)
	{
		if(pipNextBoard->is_eolist != 1)
		{
			pNextPrologInt = pipNextBoard->next;
			delete pipNextBoard;
			pipNextBoard = pNextPrologInt;
		}

		if(pipCurrentBoard->is_eolist != 1)
		{
			pNextPrologInt = pipCurrentBoard->next;
			delete pipCurrentBoard;
			pipCurrentBoard = pNextPrologInt;
		}
	}

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		delete [] ppCurrentBoard[i];
		delete [] ppNextBoard[i];
	}
}

void NsRenjuAI::GetNextStep(NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], int &iRowIndex, int &iColumnIndex)
{
}

void NsRenjuAI::GetNextStep_Debug(NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], int &iRowIndex, int &iColumnIndex, NsCellValue board_DEBUG[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS])
{
	int iRowIndexTMP, iColumnIndexTMP;
	
	// установка "свой" - чужой
	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			if(AIColor == White)
		    {
				ppCurrentBoard[i][j] = board[i][j];
			}
			else
			{
				if(board[i][j] == Black)
				{
					ppCurrentBoard[i][j] = White;
				}
				else
				{
					if(board[i][j] == White)
					{
						ppCurrentBoard[i][j] = Black;
					}
					else
					{
						ppCurrentBoard[i][j] = board[i][j];
					}
				}
			}
		}
	}

	// конвертируем int** в prolog_int *
	Convert_ppInt_to_pIntProlog(ppCurrentBoard, pipCurrentBoard, NS_RENJU_NUM_ROWS, NS_RENJU_NUM_ROWS);

	switch(AIColor)
	{
		case(White):
			// вызываем предикат prolog-а
			export_execute_renju_ai_is_white_debug(pipCurrentBoard, &pipNextBoard, &iRowIndexTMP, &iColumnIndexTMP);
		break;
		case(Black):
			// вызываем предикат prolog-а
			export_execute_renju_ai_is_black_debug(pipCurrentBoard, &pipNextBoard, &iRowIndexTMP, &iColumnIndexTMP);
		break;
	}

	iRowIndex = iRowIndexTMP;
	iColumnIndex = iColumnIndexTMP;

	Convert_pIntProlog_to_ppInt(ppNextBoard, pipNextBoard, NS_RENJU_NUM_ROWS, NS_RENJU_NUM_ROWS);

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			board_DEBUG[i][j] = (NsCellValue)ppNextBoard[i][j];
		}
	}
}

void NsRenjuAI::SetBlack()
{
	AIColor = Black;
}

void NsRenjuAI::SetWhite()
{
	AIColor = White;
}

NsCellValue NsRenjuAI::GetColor()
{
	return AIColor;
}