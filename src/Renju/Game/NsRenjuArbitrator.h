#pragma once
#include "NsRenjuIncludes.h"

class NsRenjuArbitrator
{
public:
	NsRenjuArbitrator(void);
	~NsRenjuArbitrator(void);

	// проверить, закончена ли игра
	// RETURNS: цвет победителя - завершение игры, либо None - продолжение игры
	int CheckGameOver
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] текущее состояние доски
		NsCellValue AIColor
	);

	// проверить, можно ли чёрным пойти по клетке
	// RETURNS: true - ход разрешен, false - ход запрещен (фол)
	bool CheckLegalBlackMove
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS],       // [IN] текущее состояние доски
		NsCellValue board_DEBUG[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] доска, проверенная арбитром
		int iRowIndex,                             // [IN] индекс строки хода черного
		int iColumnIndex                           // [IN] индекс колонки черного
	);
};
