#pragma once
#include <windows.h>
#include "../Math/NsMath.hpp"
#include "../Common/NsMouseState.h"
#include "../Render/NsCamera.h"
#include "../Common/NsInputSettings.h"
#include <list>

class NsSceneObject
{
friend class NsScene;

public:
	NsSceneObject();
	~NsSceneObject();

	NsMatrix4 GetWorldTransform() const;

//protected:
	NsVector3 _position;
	NsMatrix3 _rotation;
	NsVector3 _scale;

protected:
	int _ID;
};

class NsQuad3D : public NsSceneObject
{
friend class NsScene;

public:
	NsQuad3D();
	~NsQuad3D();

	NsQuad3D & operator=(const NsQuad3D & value);

	float fWidth;
	float fHeight;
	NsVector3 v3Normal;

	unsigned int textureID;
	unsigned int shaderID;
	bool bUseASCIIShader;
};

class NsScene
{
public:
	NsScene();
	~NsScene();

	void CreateQuad3D(NsVector3 position, float fWidth, float fHeight, unsigned int textureID, unsigned int shaderID, bool bIsWebView, bool bIsWebCameraView);	
	void Update(NsCamera * pCamera, const std::list<WPARAM> pressedKeys, const NsMouseState & mouseState);

	std::list<NsQuad3D> _quads;

protected:
	int _IDCounter;
	NsVector3 _editAxis;
};