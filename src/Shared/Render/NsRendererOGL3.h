#pragma once
#pragma comment(lib, "opengl32.lib")
#pragma comment(lib, "glu32.lib")
#include <windows.h>
#define GLEW_STATIC
#include "../../3rd party/GLEW/GL/glew.h"
#include <gl/gl.h>
#include <gl/glu.h>
#include "../Common/NsApplicationData.h"
#include "../Render/NsCamera.h"
#include "../Render/NsScene.h"
#include "../ResourceManagement/NsOGLResourceManager.h"

class NsRendererOGL3
{
public:
	NsRendererOGL3();
	~NsRendererOGL3();

	void BeginDraw(NsCamera * pCamera);
	void EndDraw();

	void Clear();
	
	void Draw(const NsScene & scene);

	void Draw(const NsQuad3D & quad);
	void Draw(const NsVector3 & leftBottomPoint, float fWidth, float fHeight);

	void Initialize(NsApplicationData * applicationData);
	void Finish(NsApplicationData * applicationData);
	void Resize(int screenWidth, int screenHeight);
	void SetClearColor(float R, float G, float B, float A);
	void SetDrawColor(float R, float G, float B);

	void ResetMatrices();
	void SetWorldMatrix(const NsMatrix4& matrix);
	void SetViewMatrix(const NsMatrix4& matrix);
	void SetProjectionMatrix(const NsMatrix4& matrix);

	NsMatrix4 mWorldMatrix;
	NsMatrix4 mViewMatrix;
	NsMatrix4 mProjMatrix;

protected:
	HDC hDC;
	HGLRC hRC;
};