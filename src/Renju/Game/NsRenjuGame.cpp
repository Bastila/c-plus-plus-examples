#include "NsRenjuGame.h"

NsRenjuGame::NsRenjuGame(NsGameMode gameMode)
{
	winner = None;
	activeColor = White;
	bGameIsFinished = true;
	this->gameMode = gameMode;
}

NsRenjuGame::~NsRenjuGame()
{
}

void NsRenjuGame::Start(NsGameMode newNsGameMode)
{
	NsConsole::Instance()->AddMessage("The new game was started");
	SetNsGameMode(newNsGameMode);
	winner = None;
}
void NsRenjuGame::SetNsGameMode(NsGameMode newNsGameMode)
{
	gameMode = newNsGameMode;

	switch(newNsGameMode)
	{
		case AI_Black:
			NsConsole::Instance()->AddMessage("Game Mode was set to Human (white) - AI (black)");
			renjuAI.SetBlack();
			activeColor = White;
		break;
		case AI_White:
			NsConsole::Instance()->AddMessage("Game Mode was set to Human (black)- AI (white)");
			renjuAI.SetWhite();
			activeColor = Black;
		break;
		case Human_Human:
			activeColor = Black;
			NsConsole::Instance()->AddMessage("Game Mode was set to Human - Human");
		break;
	}
}

NsGameMode NsRenjuGame::GetNsGameMode()
{
	return gameMode;
}

void NsRenjuGame::Write(NsCellValue board_debug[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS])
{
	char cBuffer[100];
	NsString sBoard, sCurrentRow;

	sBoard.push_back('\n');

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		sCurrentRow.clear();
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			if(board_debug[i][j] >= 0 && board_debug[i][j] <= 9)
			{
				sCurrentRow.push_back(' ');
			}
			sprintf_s(cBuffer, "%d", board_debug[i][j]);
			for(int k = 0; k < strlen(cBuffer); k++)
			{
				sCurrentRow.push_back(cBuffer[k]);
			}
			sCurrentRow.push_back(' ');
			sCurrentRow.push_back(' ');
		}
		sCurrentRow.push_back('\n');
		sBoard.append(sCurrentRow);
	}

	NsConsole::Instance()->AddMessage(sBoard);
}

void NsRenjuGame::Write(NsCellValue board_debug[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS], NsCellValue disc, int row, int column)
{
	NsString sBoard, sCurrentRow;

	if(disc == Black)
	{
		sBoard.append("The Black set the stone at (");
	}
	else
	{
		sBoard.append("The White set the stone at (");
	}
	sBoard.append(NsText::ToString(row));
	sBoard.append(";");
	sBoard.append(NsText::ToString(column));
	sBoard.append(")");

	sBoard.push_back('\n');

	for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
	{
		sCurrentRow.clear();
		for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
		{
			if(board_debug[i][j] >= 0 && board_debug[i][j] <= 9)
			{
				sCurrentRow.push_back(' ');
			}			
			sCurrentRow.append(NsText::ToString(board_debug[i][j]));
			sCurrentRow.append("  ");
		}
		sCurrentRow.push_back('\n');
		sBoard.append(sCurrentRow);
	}

	NsConsole::Instance()->AddMessage(sBoard);
}