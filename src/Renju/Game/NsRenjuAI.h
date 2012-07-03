#pragma once
#include "NsRenjuIncludes.h"
#include "NsPrologInt.h"

class NsRenjuAI
{
private 
	:NsCellValue AIColor;

public:
	NsRenjuAI(void);
	~NsRenjuAI(void);

	// получить координаты следующего хода противника
	void GetNextStep
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] текущее состояние доски
		int &iRowIndex,                      // [OUT] индекс строки хода AI
		int &iColumnInde                     // [OUT] индекс колонки хода AI
	);

	// получить координаты следующего хода противника (отладочная версия)
	void GetNextStep_Debug
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] текущее состояние доски
		int &iRowIndex,                      // [OUT] индекс строки хода AI
		int &iColumnInde,                    // [OUT] индекс колонки хода AI
		NsCellValue board_DEBUG[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS]  // [OUT] текущее состояние доски
	);

	// установить AI играть за чёрных
	void SetBlack();

	// установить AI играть за белых
	void SetWhite();

	// получить цвет AI
	NsCellValue GetColor();

protected:
	int *ppCurrentBoard[NS_RENJU_NUM_ROWS];
	int *ppNextBoard[NS_RENJU_NUM_ROWS];
	prolog_int *pipCurrentBoard;
	prolog_int *pipNextBoard;
};
