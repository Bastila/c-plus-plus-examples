#pragma once
#include "NsRenjuIncludes.h"

class NsRenjuArbitrator
{
public:
	NsRenjuArbitrator(void);
	~NsRenjuArbitrator(void);

	// ���������, ��������� �� ����
	// RETURNS: ���� ���������� - ���������� ����, ���� None - ����������� ����
	int CheckGameOver
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] ������� ��������� �����
		NsCellValue AIColor
	);

	// ���������, ����� �� ������ ����� �� ������
	// RETURNS: true - ��� ��������, false - ��� �������� (���)
	bool CheckLegalBlackMove
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS],       // [IN] ������� ��������� �����
		NsCellValue board_DEBUG[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] �����, ����������� ��������
		int iRowIndex,                             // [IN] ������ ������ ���� �������
		int iColumnIndex                           // [IN] ������ ������� �������
	);
};
