#include <windows.h>
#include <windowsx.h>
#include <list>
#include <string>
#include "../../Shared/Common/NsApplicationData.h"
#include "../../Shared/Render/NsRendererOGL3.h"
#include "../../Shared/Render/NsCamera.h"
#include "../../Shared/Render/NsCameraController.h"
#include "../../Shared/Utils/NsConsole.h"
#include "../../Shared/Common/NsMouseState.h"
#include "../../Shared/Render/NsScene.h"
#include "../../Shared/ResourceManagement/NsOGLResourceManager.h"

NsScene g_scene;
NsMouseState g_MouseState;
std::list<WPARAM> g_pressedKeys;
NsRendererOGL3 * g_pRendererOGL3 = 0;
NsCamera * g_pCamera = 0;
NsCameraController * g_pCameraController;
NsApplicationData * g_pApplicationData = 0;
bool g_bMainLoop = true;

#define WINDOW_WIDTH	1024
#define WINDOW_HEIGHT	768
bool g_bFly = false;

void Initialize()
{
	////NsConsole::Instance()->Show();
	NsConsole::Instance()->AddMessage("NsConsole is initiated");

	if(glewInit() == GLEW_OK)
	{
		NsConsole::Instance()->AddMessage("GLEW is initiated");
	}

	g_pRendererOGL3->SetClearColor(1, 1, 1, 1);
	g_pRendererOGL3->SetDrawColor(0, 0, 0);

	int testImageWidth, testImageHeight;
	int asciiImageWidth, asciiImageHeight;
	GLuint textureID = NsOGLResourceManager::Instance()->LoadContentTexture2D(NsOGLResourceManager::Instance()->colorMapName.c_str(), &testImageWidth, &testImageHeight);
	GLuint fontID = NsOGLResourceManager::Instance()->LoadContentTexture2D("/Textures/ASCII/ascii.png", &asciiImageWidth, &asciiImageHeight);

	int quadWidth = 40;
	int quadHeight = 24;

	if(textureID > 0)
	{
		GLuint shaderID = NsOGLResourceManager::Instance()->LoadASCIIFragmentAndVertexShader("/Shaders/ASCII/texture_quad_vertex.glsl", "/Shaders/ASCII/texture_quad_fragment.glsl");

		if(shaderID > 0)
		{
			quadHeight = int(float(testImageHeight) / float(testImageWidth) * float(quadWidth));

			g_scene.CreateQuad3D(NsVector3(0.f, 0.f, 0.f), quadWidth, quadHeight, textureID, shaderID, false, false);
		}
	}

	g_pCamera = new NsCamera();
	g_pCameraController = new NsCameraController();

	NsVector3 initialPos(quadWidth/2, quadHeight/2, -40);
	NsVector3 target(quadWidth/2, quadHeight/2, 0);
	g_pCamera->SetView( initialPos, (target-initialPos).GetNormalized() );
	g_pCamera->SetLens( ONEFOURTH_PI, 4.0f/3.0f, 1.0f, 1000.0f );
}

void Frame()
{
	g_scene.Update(g_pCamera, g_pressedKeys, g_MouseState);
	g_pCameraController->Update(g_pCamera, g_pressedKeys, g_MouseState);

	g_pRendererOGL3->BeginDraw(g_pCamera);

	g_pRendererOGL3->Draw(g_scene);
			
	g_pRendererOGL3->EndDraw();
}

LRESULT CALLBACK WndProc(HWND hWnd, UINT uMessage, WPARAM wParam, LPARAM lParam)
{
	switch (uMessage)
	{
		case WM_LBUTTONDOWN:
		{
			g_MouseState.bLeftButtonIsPressed = true;
			return 0;
		}

		case WM_LBUTTONUP:
		{
			g_MouseState.bLeftButtonIsPressed = false;
			return 0;
		}

		case WM_RBUTTONDOWN:
		{
			g_MouseState.bRightButtonIsPressed = true;
			return 0;
		}

		case WM_RBUTTONUP:
		{
			g_MouseState.bRightButtonIsPressed = false;
			return 0;
		}

		case WM_MOUSEMOVE:
		{
			g_MouseState.dX = GET_X_LPARAM(lParam) - g_MouseState.X;
			g_MouseState.dY = GET_Y_LPARAM(lParam) - g_MouseState.Y;
			g_MouseState.X = GET_X_LPARAM(lParam);
			g_MouseState.Y = GET_Y_LPARAM(lParam);
		}
		break;

		case WM_ERASEBKGND:
			return 0;

		case WM_PAINT:
		{
			Frame();
		}
		return 0;

		case WM_CLOSE:
			g_bMainLoop = false;
			PostQuitMessage(0);
		return 0;
			
		case WM_SIZE:
			switch (wParam)
			{
				case SIZE_MINIMIZED:
				return 0;

				case SIZE_MAXIMIZED:
					g_pRendererOGL3->Resize(LOWORD (lParam), HIWORD (lParam));
				return 0;

				case SIZE_RESTORED:
					g_pRendererOGL3->Resize(LOWORD (lParam), HIWORD (lParam));
				return 0;
			}
		break;

		case WM_KEYUP:
		case WM_KEYDOWN:
		{
			if(uMessage == WM_KEYDOWN)
			{
				g_pressedKeys.push_back(wParam);
			}
			else
			{
				if(uMessage == WM_KEYUP)
				{
					g_pressedKeys.remove(wParam);
				}
			}

			return 0;
		}
	
	default:
		return DefWindowProc(hWnd, uMessage, wParam, lParam);
	}
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int iCmdShow)
{
	MSG msg;
	WNDCLASS windowClass;
	ZeroMemory (&windowClass, sizeof (WNDCLASS));
	
	windowClass.style = CS_HREDRAW | CS_VREDRAW | CS_OWNDC;
	windowClass.lpfnWndProc = WndProc;
	windowClass.cbClsExtra = 0;
	windowClass.cbWndExtra = 0;
	windowClass.hInstance = hInstance;
	windowClass.hIcon = LoadIcon(NULL, IDI_APPLICATION);
	windowClass.hCursor = LoadCursor(NULL, IDC_ARROW);
	windowClass.hbrBackground = (HBRUSH)GetStockObject(BLACK_BRUSH);
	windowClass.lpszMenuName = NULL;
	windowClass.lpszClassName = L"NsASCIIShader";
	RegisterClass(&windowClass);

	g_pApplicationData = new NsApplicationData();
	g_pApplicationData->hWnd = CreateWindow(L"NsASCIIShader", L"NsASCIIShader by Ivan Goremykin", WS_OVERLAPPEDWINDOW | WS_VISIBLE/*WS_CAPTION | WS_POPUPWINDOW | WS_VISIBLE*/, 100, 100, WINDOW_WIDTH, WINDOW_HEIGHT, NULL, NULL, hInstance, NULL);
	
	g_pRendererOGL3 = new NsRendererOGL3();
	g_pRendererOGL3->Initialize(g_pApplicationData);

	Initialize();

	while(g_bMainLoop)
	{
		if(PeekMessage(&msg, g_pApplicationData->hWnd, 0, 0, PM_REMOVE))
		{
			DispatchMessage(&msg);
		}
	}

    UnregisterClass(L"NsASCIIShader", windowClass.hInstance);
	DestroyWindow(g_pApplicationData->hWnd);
		
	return msg.wParam;
}