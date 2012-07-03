#include "NsMouseState.h"


NsMouseState::NsMouseState(void)
{
	this->bLeftButtonIsPressed = false;
	this->bRightButtonIsPressed = false;
	this->X = 0;
	this->Y = 0;
	this->dX = 0;
	this->dY = 0;
}

NsMouseState::~NsMouseState(void)
{
}

NsMouseState & NsMouseState::operator=(const NsMouseState & mouseState)
{
	this->bLeftButtonIsPressed = mouseState.bLeftButtonIsPressed;
	this->bRightButtonIsPressed = mouseState.bRightButtonIsPressed;
	this->X = mouseState.X;
	this->Y = mouseState.Y;
	this->dX = mouseState.dX;
	this->dY = mouseState.dY;

	return *this;
}