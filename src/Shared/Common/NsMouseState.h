#pragma once

class NsMouseState
{
public:
	NsMouseState(void);
	~NsMouseState(void);
	
	bool bLeftButtonIsPressed;
	bool bRightButtonIsPressed;

	int X, Y;
	int dX, dY;

	NsMouseState & operator=(const NsMouseState & mouseState);
};

