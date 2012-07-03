#include "NsRendererOGL3.h"

NsRendererOGL3::NsRendererOGL3()
{
}

NsRendererOGL3::~NsRendererOGL3()
{
}

void NsRendererOGL3::BeginDraw(NsCamera * pCamera)
{
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT );

	glClearDepth(1);

	glColorMask( GL_TRUE, GL_TRUE, GL_TRUE, GL_TRUE );

	glEnable( GL_DEPTH_TEST );
	glDepthMask( GL_TRUE );
	glDepthFunc( GL_LESS );

	glFrontFace( GL_CCW );
	glEnable( GL_CULL_FACE );
	glCullFace( GL_BACK );

	glPolygonMode( GL_FRONT, GL_FILL );

	ResetMatrices();

	NsMatrix4  projectionMatrix;
	projectionMatrix.BuildPerspectiveLH(
		pCamera->fovY,
		pCamera->aspect,
		pCamera->nearZ,
		pCamera->farZ
	);
	SetProjectionMatrix( projectionMatrix );

	NsMatrix4  viewMatrix(
		BuildLookAtMatrixLH(
			pCamera->viewOrigin,
			pCamera->GetLookDirection(),
			pCamera->GetUp()
	));

	SetViewMatrix( viewMatrix );
}

void NsRendererOGL3::Clear()
{
	glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
}

void NsRendererOGL3::Draw(const NsScene & scene)
{
	std::list<NsQuad3D>::const_iterator citQuads = scene._quads.begin();

	for(; citQuads != scene._quads.end(); ++citQuads)
	{
		Draw(*citQuads);
	}
}

void NsRendererOGL3::Draw(const NsQuad3D & quad)
{
	SetDrawColor(0.4f, 0.12f, 1.f);
	SetWorldMatrix(quad.GetWorldTransform());
		
	if(quad.bUseASCIIShader && !quad.shaderID < 1)
	{
		GLuint fontID = NsOGLResourceManager::Instance()->GetResourceID("/Textures/ASCII/ascii.png");
	
		glUseProgram(quad.shaderID);
		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);

		glActiveTexture(GL_TEXTURE0);
		glBindTexture (GL_TEXTURE_2D, quad.textureID);
		GLint iTextureUniform = glGetUniformLocation(quad.shaderID, "colorMap");
		glUniform1i(iTextureUniform, 0);

		glActiveTexture(GL_TEXTURE1);
		glBindTexture (GL_TEXTURE_2D, fontID);
		GLint iASCIIUniform = glGetUniformLocation(quad.shaderID, "asciiMap");
		glUniform1i(iASCIIUniform, 1);
	
		glBegin (GL_QUADS);
		{
			glTexCoord2f (0.0, 0.0);
			glVertex3f (0.0, 0.0, 0.0);

			glTexCoord2f (1.0, 0.0);
			glVertex3f (quad.fWidth, 0.0, 0.0);

			glTexCoord2f (1.0, 1.0);
			glVertex3f (quad.fWidth, quad.fHeight, 0.0);

			glTexCoord2f (0.0, 1.0);
			glVertex3f (0.0, quad.fHeight, 0.0);
		}
		glEnd ();

		glUseProgram(0);
		glDisable(GL_TEXTURE_2D);

	}
	else
	{
		glEnable(GL_TEXTURE_2D);
		glEnable(GL_BLEND);
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);

		glActiveTexture(GL_TEXTURE0);
		glBindTexture (GL_TEXTURE_2D, quad.textureID);

		glBegin (GL_QUADS);
		{
			glTexCoord2f (0.0, 0.0);
			glVertex3f (0.0, 0.0, 0.0);

			glTexCoord2f (1.0, 0.0);
			glVertex3f (quad.fWidth, 0.0, 0.0);

			glTexCoord2f (1.0, 1.0);
			glVertex3f (quad.fWidth, quad.fHeight, 0.0);

			glTexCoord2f (0.0, 1.0);
			glVertex3f (0.0, quad.fHeight, 0.0);
		}
		glEnd ();
		glDisable(GL_TEXTURE_2D);
	}
}

void NsRendererOGL3::Draw(const NsVector3 & leftBottomPoint, float fWidth, float fHeight)
{
	glPushMatrix();
	glBegin(GL_POLYGON);
	//glRotatef(g_fRotationAngle, 1.f, 1.f, 0.f);
	//glScalef(g_fScale, 1.f, 1.f);
	//glTranslatef(-0.5f, 0.f, 0.f);
	
	glVertex3f(leftBottomPoint.x, leftBottomPoint.y, leftBottomPoint.z);
	glVertex3f(leftBottomPoint.x + fWidth, leftBottomPoint.y, leftBottomPoint.z);
	glVertex3f(leftBottomPoint.x + fWidth, leftBottomPoint.y + fHeight, leftBottomPoint.z);
	glVertex3f(leftBottomPoint.x, leftBottomPoint.y + fHeight, leftBottomPoint.z);

	glEnd();
	glPopMatrix();
}

void NsRendererOGL3::EndDraw()
{
	SwapBuffers(hDC);
}

void NsRendererOGL3::Finish(NsApplicationData * applicationData)
{
	wglMakeCurrent(NULL, NULL);
	wglDeleteContext(hRC);
	ReleaseDC(applicationData->hWnd, applicationData->hDC);
}

void NsRendererOGL3::Initialize(NsApplicationData * applicationData)
{
	int format;
	
	applicationData->hDC = GetDC(applicationData->hWnd);
	
	PIXELFORMATDESCRIPTOR pfd = 
	{ 
		sizeof(PIXELFORMATDESCRIPTOR),   // size of this pfd 
		1,                     // version number 
		PFD_DRAW_TO_WINDOW |   // support window 
		PFD_SUPPORT_OPENGL |   // support OpenGL 
		PFD_DOUBLEBUFFER,      // double buffered 
		PFD_TYPE_RGBA,         // RGBA type 
		32,                    // 32-bit color depth 
		0, 0, 0, 0, 0, 0,      // color bits ignored 
		8,                     // no alpha buffer 
		0,                     // shift bit ignored 
		0,                     // no accumulation buffer 
		0, 0, 0, 0,            // accum bits ignored 
		24,                    // 24-bit z-buffer
		8,                     // stencil buffer
		0,                     // no auxiliary buffer
		PFD_MAIN_PLANE,        // main layer 
		0,                     // reserved 
		0, 0, 0                // layer masks ignored 
	};

	format = ::ChoosePixelFormat( applicationData->hDC, &pfd );

	SetPixelFormat(applicationData->hDC, format, &pfd);

	DescribePixelFormat( applicationData->hDC, format, sizeof(PIXELFORMATDESCRIPTOR), &pfd );
	
	hRC = wglCreateContext(applicationData->hDC);
	wglMakeCurrent(applicationData->hDC, hRC);

	this->hDC = applicationData->hDC;

	//glFrontFace(GL_CW);
}

void NsRendererOGL3::Resize(int screenWidth, int screenHeight)
{
	/*if(screenHeight == 0)
	{
		screenHeight = 1;
	}

	glViewport(0, 0, screenWidth, screenHeight);

	// Reset coordinate system
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();

	// Produce the perspective projection
	double dFOV = 45;
	double dNear = 0.1;
	double dFar = 100;
	double dAspectRatio = (double)screenWidth/(double)screenHeight;

	double dTop = tan(dFOV*3.14159/360.0) * dNear;
	double dBottom = -dTop;
	double dLeft = dAspectRatio * dBottom;
	double dRight = dAspectRatio * dTop;

	glFrustum(dLeft, dRight, dBottom, dTop, dNear, dFar);
	//gluPerspective(45.0f,(GLfloat)screenWidth/(GLfloat)screenHeight,0.1f,100.0f);

	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();*/
}

void NsRendererOGL3::SetClearColor(float R, float G, float B, float A)
{
	glClearColor(R, G, B, A);
}

void NsRendererOGL3::SetDrawColor(float R, float G, float B)
{
	glColor3f(R, G, B);
}

void NsRendererOGL3::SetWorldMatrix( const NsMatrix4& matrix )
{
	mWorldMatrix = matrix;
	glMatrixMode( GL_MODELVIEW );
	
	GLfloat glmat[16];
	NsMath::mul_mat4_mat4( mViewMatrix.ToFloatPtr(), mWorldMatrix.ToFloatPtr(), glmat );
	glLoadMatrixf( glmat );
}

void NsRendererOGL3::SetViewMatrix( const NsMatrix4& matrix )
{
	mViewMatrix = matrix;
	glMatrixMode( GL_MODELVIEW );
	
	GLfloat glmat[16];
	NsMath::mul_mat4_mat4( mViewMatrix.ToFloatPtr(), mWorldMatrix.ToFloatPtr(), glmat );
	glLoadMatrixf( glmat );
}

void NsRendererOGL3::SetProjectionMatrix( const NsMatrix4& matrix )
{
	mProjMatrix = matrix;

	GLfloat glmat[16];
	NsMemory::Copy(glmat, matrix.ToFloatPtr(), sizeof(glmat));
	// Flip Z axis because OpenGL uses a right-hand coordinate system.
	glmat[12] *= -1.0f;
	glMatrixMode( GL_PROJECTION );
	glLoadMatrixf( glmat );
}

void NsRendererOGL3::ResetMatrices()
{
	mWorldMatrix = NsMatrix4::Identity();
	mViewMatrix = NsMatrix4::Identity();
	mProjMatrix = NsMatrix4::Identity();
	
	SetWorldMatrix(NsMatrix4::Identity());
	SetViewMatrix(NsMatrix4::Identity());
	SetProjectionMatrix(NsMatrix4::Identity());
}