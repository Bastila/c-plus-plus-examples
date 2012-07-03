#pragma once

#define NS_RENJU_NUM_ROWS 15

enum NsCellValue
{
    None = 0,
    White = -1,
    Black = -2,
	Next_Step = -3,
	Restricted_Next_Step = -4
};

enum NsRelationship
{
	Friend = -1,
	Enemy = -2
};

enum NsGameMode
{
	Human_Human,
	AI_Black,
	AI_White
};