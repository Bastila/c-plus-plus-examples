#pragma once
#include "NsRenjuIncludes.h"
#include "NsRenjuAI.h"
#include "NsRenjuArbitrator.h"
#include "../../Shared/Utils/NsConsole.h"

class NsRenjuGame
{
private:
	NsGameMode gameMode;

public:
	NsCellValue winner;
    bool bGameIsFinished;
    NsCellValue activeColor;

public:
	NsRenjuGame(NsGameMode gameMode);
	~NsRenjuGame();

	NsRenjuAI renjuAI;
	NsRenjuArbitrator renjuArbitrator;

	void Start(NsGameMode gameMode);

	void SetNsGameMode(NsGameMode newNsGameMode);
	NsGameMode GetNsGameMode();

	void Write(NsCellValue board_debug[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS]);
	void Write(NsCellValue board_debug[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], NsCellValue disc, int row, int column);
};
