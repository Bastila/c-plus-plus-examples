#pragma once
#include "../Render/NsCamera.h"
#include "../Common/NsMouseState.h"
#include "../Utils/NsConsole.h"
#include "../Common/NsInputSettings.h"
#include <windows.h>
#include <list>

class NsCameraController
{
friend class NsCamera;

public:
	NsCameraController();
	~NsCameraController();

	NsCameraController & operator= (const NsCameraController & value);
	
	void Update(NsCamera * pCamera, const std::list<WPARAM> pressedKeys, const NsMouseState & mouseState);

protected:
	float _fMoveSpeed;
	float _fRotateSpeed;

	int _iMousePreviousDX, _iMousePreviousDY;
};