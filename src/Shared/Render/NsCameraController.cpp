#include "NsCameraController.h"

NsCameraController::NsCameraController(void)
{
	_fMoveSpeed = 1.f;
	_fRotateSpeed = 0.005f;

	_iMousePreviousDX = 0;
	_iMousePreviousDY = 0;
}

NsCameraController::~NsCameraController(void)
{
}

NsCameraController & NsCameraController::operator= (const NsCameraController & value)
{
	this->_fMoveSpeed = value._fMoveSpeed;
	this->_fRotateSpeed = value._fRotateSpeed;

	return *this;
}

void NsCameraController::Update(NsCamera * pCamera, const std::list<WPARAM> pressedKeys, const NsMouseState & mouseState)
{
	std::list<WPARAM>::const_iterator it = pressedKeys.begin();
	for(; it != pressedKeys.end(); ++it)
	{
		switch(*it)
		{
			case MOVE_FORWARD:
			{
				pCamera->Walk(+_fMoveSpeed);
			}
			break;
			case MOVE_BACKWARD:
			{
				pCamera->Walk(-_fMoveSpeed);
			}
			break;
			case STRAFE_LEFT:
			{
				pCamera->Strafe(-_fMoveSpeed);
			}
			break;
			case STRAFE_RIGHT:
			{
				pCamera->Strafe(+_fMoveSpeed);
			}
			break;
			case JUMP_UP:
			{
				pCamera->Fly(+_fMoveSpeed);
			}
			break;
			case DUCK:
			{
				pCamera->Fly(-_fMoveSpeed);
			}
			break;
		}
	}

	pCamera->RepairNormals();
		
	if(!mouseState.bRightButtonIsPressed)
	{
		pCamera->Yaw(0.f);
		pCamera->Pitch(0.f);
	}
	else
	{
		/*if(_iMousePreviousDX == mouseState.dX && _iMousePreviousDY == mouseState.dY)
		{
		pCamera->Yaw(0.f);
		pCamera->Pitch(0.f);
		}
		else
		{
		pCamera->Yaw((float)mouseState.dX * _fRotateSpeed);
		pCamera->Pitch((float)mouseState.dY * _fRotateSpeed);

		_iMousePreviousDX = mouseState.dX;
		_iMousePreviousDY = mouseState.dY;
		}*/
	}
}