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

	// �������� ���������� ���������� ���� ����������
	void GetNextStep
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] ������� ��������� �����
		int &iRowIndex,                      // [OUT] ������ ������ ���� AI
		int &iColumnInde                     // [OUT] ������ ������� ���� AI
	);

	// �������� ���������� ���������� ���� ���������� (���������� ������)
	void GetNextStep_Debug
	(
		NsCellValue board[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], // [IN] ������� ��������� �����
		int &iRowIndex,                      // [OUT] ������ ������ ���� AI
		int &iColumnInde,                    // [OUT] ������ ������� ���� AI
		NsCellValue board_DEBUG[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS]  // [OUT] ������� ��������� �����
	);

	// ���������� AI ������ �� ������
	void SetBlack();

	// ���������� AI ������ �� �����
	void SetWhite();

	// �������� ���� AI
	NsCellValue GetColor();

protected:
	int *ppCurrentBoard[NS_RENJU_NUM_ROWS];
	int *ppNextBoard[NS_RENJU_NUM_ROWS];
	prolog_int *pipCurrentBoard;
	prolog_int *pipNextBoard;
};
