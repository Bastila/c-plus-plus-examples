#pragma comment (lib, "../../../../../lib/Renju/Renju.lib")

#include "../../Shared/Common/NsIncludes.h"
#include "../../3rd party/DXUT/Core/dxut.h"
#include "../../3rd party/DXUT/Optional/SDKmisc.h"
#include "../../3rd party/DXUT/Optional/DXUTsettingsdlg.h"
#include "../../3rd party/DXUT/Optional/DXUTcamera.h"
#include "../Rendering/NsBoard.h"
#include "../Rendering/NsTexturedQuad.h"

//#define DEBUG_VS	// uncomment this line to debug vertex shaders 
//#define DEBUG_PS	// uncomment this line to debug pixel shaders 

//=====================================Global Variables=====================================

ID3DXFont * g_pFont = NULL; // font for drawing text
ID3DXSprite * g_pTextSprite = NULL; // sprite for batching draw text calls
CModelViewerCamera g_Camera; // a model viewing camera
bool g_bShowHelp = true; // if true, it renders the UI control text
CDXUTDialog g_HUD; // dialog for standard controls
CDXUTDialog g_SampleUI; // dialog for sample specific controls
CDXUTDialogResourceManager g_DialogResourceManager; // manager for shared resources of dialogs
CDXUTDialog g_TheWhiteWinnerDialog;
CDXUTDialog g_TheBlackWinnerDialog;
CDXUTDialog g_WhiteArrowDialog;
CDXUTDialog g_BlackArrowDialog;
NsBoard g_Board;
NsTexturedQuad g_BackgroundQuad;

// UI control IDs
#define IDC_TOGGLEFULLSCREEN    		1
#define IDC_TOGGLEREF           		2
#define IDC_CHANGEDEVICE        		3
#define IDC_WHITESCORE          		4
#define IDC_BLACKSCORE          		5
#define IDC_HIDECONSOLE					6
#define IDC_RESETGAME					7
#define IDC_GAMEMODE_RADIO				8
#define IDC_GAMEMODE_HUMAN_HUMAN_RADIO	9
#define IDC_GAMEMODE_AI_IS_BLACK_RADIO  10
#define IDC_GAMEMODE_AI_IS_WHITE_RADIO	11
#define IDC_THE_WHITE_WINNER_DIALOG		12
#define IDC_THE_BLACK_WINNER_DIALOG		13
#define IDC_LAUNCH_RENJU_MANUAL  		14

bool CALLBACK IsDeviceAcceptable(D3DCAPS9* pCaps, D3DFORMAT AdapterFormat, D3DFORMAT BackBufferFormat, bool bWindowed, void* pUserContext)
{
    // Skip backbuffer formats that don't support alpha blending
    IDirect3D9* pD3D = DXUTGetD3D9Object();
    if(FAILED(pD3D->CheckDeviceFormat(pCaps->AdapterOrdinal, pCaps->DeviceType,
                                         AdapterFormat, D3DUSAGE_QUERY_POSTPIXELSHADER_BLENDING,
                                         D3DRTYPE_TEXTURE, BackBufferFormat)))
        return false;

    return true;
}

bool CALLBACK ModifyDeviceSettings(DXUTDeviceSettings* pDeviceSettings, void* pUserContext)
{
    IDirect3D9* pD3D = DXUTGetD3D9Object();
    D3DCAPS9 caps;
    HRESULT hr;

    V(pD3D->GetDeviceCaps(pDeviceSettings->d3d9.AdapterOrdinal, pDeviceSettings->d3d9.DeviceType, &caps));

    if((caps.DevCaps & D3DDEVCAPS_HWTRANSFORMANDLIGHT) == 0 ||
        caps.VertexShaderVersion < D3DVS_VERSION(1, 1))
    {
        pDeviceSettings->d3d9.BehaviorFlags = D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    }
    else
    {
        pDeviceSettings->d3d9.BehaviorFlags = D3DCREATE_HARDWARE_VERTEXPROCESSING;
    }

    // This application is designed to work on a pure device by not using 
    // IDirect3D9::Get*() methods, so create a pure device if supported and using HWVP.
    if((caps.DevCaps & D3DDEVCAPS_PUREDEVICE) != 0 &&
        (pDeviceSettings->d3d9.BehaviorFlags & D3DCREATE_HARDWARE_VERTEXPROCESSING) != 0)
        pDeviceSettings->d3d9.BehaviorFlags |= D3DCREATE_PUREDEVICE;

    // Debugging vertex shaders requires either REF or software vertex processing 
    // and debugging pixel shaders requires REF.  
#ifdef DEBUG_VS
    if(pDeviceSettings->d3d9.DeviceType != D3DDEVTYPE_REF)
    {
        pDeviceSettings->d3d9.BehaviorFlags &= ~D3DCREATE_HARDWARE_VERTEXPROCESSING;
        pDeviceSettings->d3d9.BehaviorFlags &= ~D3DCREATE_PUREDEVICE;
        pDeviceSettings->d3d9.BehaviorFlags |= D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    }
#endif
#ifdef DEBUG_PS
    pDeviceSettings->d3d9.DeviceType = D3DDEVTYPE_REF;
#endif

    // Enable anti-aliasing for HAL devices which support it
    CD3D9Enumeration* pEnum = DXUTGetD3D9Enumeration();
    CD3D9EnumDeviceSettingsCombo* pCombo = pEnum->GetDeviceSettingsCombo(&pDeviceSettings->d3d9);

    if(pDeviceSettings->d3d9.DeviceType == D3DDEVTYPE_HAL &&
        pCombo->multiSampleTypeList.Contains(D3DMULTISAMPLE_4_SAMPLES))
    {
        pDeviceSettings->d3d9.pp.MultiSampleType = D3DMULTISAMPLE_4_SAMPLES;
        pDeviceSettings->d3d9.pp.MultiSampleQuality = 0;
    }

    return true;
}

HRESULT CALLBACK OnCreateDevice(IDirect3DDevice9* pd3dDevice, const D3DSURFACE_DESC* pBackBufferSurfaceDesc, void* pUserContext)
{
    HRESULT hr;

    V_RETURN(g_DialogResourceManager.OnD3D9CreateDevice(pd3dDevice));

    V_RETURN(D3DXCreateFont(pd3dDevice, 15, 0, FW_BOLD, 1, FALSE, DEFAULT_CHARSET,
                              OUT_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_DONTCARE,
                              L"Arial", &g_pFont));

    DWORD dwShaderFlags = 0;
#ifdef DEBUG_VS
        dwShaderFlags |= D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT;
    #endif
#ifdef DEBUG_PS
        dwShaderFlags |= D3DXSHADER_FORCE_PS_SOFTWARE_NOOPT;
    #endif

    // Create the game board's Direct3D resources
    V_RETURN(g_Board.OnCreateDevice(pd3dDevice, dwShaderFlags));
	    
	std::wstring wsCurrentResourcePath;
	std::wstring wsAbsoluteContentDirectoryPath = NsD3DResourceManager::Instance()->GetAbsoluteContentFolderPath();
		
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Shaders/Renju/textured_quad.fx";
    V_RETURN(g_BackgroundQuad.Create(pd3dDevice, wsCurrentResourcePath.c_str(), dwShaderFlags));
	
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Textures/Renju/background.tga";
	V_RETURN(g_BackgroundQuad.LoadTexture("QuadTexture", wsCurrentResourcePath.c_str()));


    // Setup the camera's view parameters
    D3DXVECTOR3 vecEye(0.0f, 0.0f, -5.0f);
    D3DXVECTOR3 vecAt (0.0f, 0.0f, -0.0f);
    g_Camera.SetViewParams(&vecEye, &vecAt);

    return S_OK;
}

HRESULT CALLBACK OnResetDevice(IDirect3DDevice9* pd3dDevice, const D3DSURFACE_DESC* pBackBufferSurfaceDesc, void* pUserContext)
{
    HRESULT hr;

    V_RETURN(g_DialogResourceManager.OnD3D9ResetDevice());

    if(g_pFont)
        V_RETURN(g_pFont->OnResetDevice());

    V_RETURN(D3DXCreateSprite(pd3dDevice, &g_pTextSprite));

    V_RETURN(g_Board.OnResetDevice(pd3dDevice, pBackBufferSurfaceDesc));
    V_RETURN(g_BackgroundQuad.OnResetDevice());

    D3DXMATRIXA16 matrix;
    D3DXMatrixIdentity(&g_BackgroundQuad.World);

    D3DXMatrixScaling(&matrix, (float)pBackBufferSurfaceDesc->Width, (float)pBackBufferSurfaceDesc->Height,
                       1.0f);
    D3DXMatrixMultiply(&g_BackgroundQuad.World, &g_BackgroundQuad.World, &matrix);

    D3DXMatrixTranslation(&matrix, (float)pBackBufferSurfaceDesc->Width / 2.0f, pBackBufferSurfaceDesc->Height /
                           2.0f, 0.0f);
    D3DXMatrixMultiply(&g_BackgroundQuad.World, &g_BackgroundQuad.World, &matrix);

    g_Board.SetPosition(D3DXVECTOR3(pBackBufferSurfaceDesc->Width / 2.0f, pBackBufferSurfaceDesc->Height / 2.0f,
                                      0));
    g_Board.SetSize(min(pBackBufferSurfaceDesc->Height, pBackBufferSurfaceDesc->Width) * 0.7f);

    g_WhiteArrowDialog.SetLocation(100, pBackBufferSurfaceDesc->Height / 2 - g_WhiteArrowDialog.GetHeight() / 2);
    g_BlackArrowDialog.SetLocation(-100 + pBackBufferSurfaceDesc->Width - g_BlackArrowDialog.GetWidth(),
                                    pBackBufferSurfaceDesc->Height / 2 - g_BlackArrowDialog.GetHeight() / 2);

    g_TheWhiteWinnerDialog.SetLocation(50, pBackBufferSurfaceDesc->Height - 100);
    g_TheBlackWinnerDialog.SetLocation(50, pBackBufferSurfaceDesc->Height - 100);

    float fAspectRatio = pBackBufferSurfaceDesc->Width / (FLOAT)pBackBufferSurfaceDesc->Height;
    g_Camera.SetProjParams(D3DX_PI / 4, fAspectRatio, 0.1f, 1000.0f);
    g_Camera.SetWindow(pBackBufferSurfaceDesc->Width, pBackBufferSurfaceDesc->Height);

    g_HUD.SetLocation(pBackBufferSurfaceDesc->Width - 170, 0);
    g_HUD.SetSize(170, 170);
    g_SampleUI.SetLocation(pBackBufferSurfaceDesc->Width - 170, 0);
    g_SampleUI.SetSize(170, 300);

    return S_OK;
}

void CALLBACK OnLostDevice(void* pUserContext)
{
    g_DialogResourceManager.OnD3D9LostDevice();
    if(g_pFont)
        g_pFont->OnLostDevice();
    SAFE_RELEASE(g_pTextSprite);

    g_Board.OnLostDevice();
    g_BackgroundQuad.OnLostDevice();
}

void CALLBACK OnDestroyDevice(void* pUserContext)
{
    g_DialogResourceManager.OnD3D9DestroyDevice();
    SAFE_RELEASE(g_pFont);

    g_Board.OnDestroyDevice();
    g_BackgroundQuad.Destroy();

}

HRESULT LoadMesh(IDirect3DDevice9* pd3dDevice, WCHAR* strFileName, ID3DXMesh** ppMesh)
{
    ID3DXMesh* pMesh = NULL;
    WCHAR str[MAX_PATH];
    HRESULT hr;

    V_RETURN(DXUTFindDXSDKMediaFileCch(str, MAX_PATH, strFileName));

    V_RETURN(D3DXLoadMeshFromX(str, D3DXMESH_MANAGED, pd3dDevice, NULL, NULL, NULL, NULL, &pMesh));

    DWORD* rgdwAdjacency = NULL;

    if(!(pMesh->GetFVF() & D3DFVF_NORMAL))
    {
        ID3DXMesh* pTempMesh;
        V(pMesh->CloneMeshFVF(pMesh->GetOptions(),
                                pMesh->GetFVF() | D3DFVF_NORMAL,
                                pd3dDevice, &pTempMesh));
        V(D3DXComputeNormals(pTempMesh, NULL));

        SAFE_RELEASE(pMesh);
        pMesh = pTempMesh;
    }
   
    rgdwAdjacency = new DWORD[pMesh->GetNumFaces() * 3];
    if(rgdwAdjacency == NULL)
        return E_OUTOFMEMORY;
    V(pMesh->GenerateAdjacency(1e-6f, rgdwAdjacency));
    V(pMesh->OptimizeInplace(D3DXMESHOPT_VERTEXCACHE, rgdwAdjacency, NULL, NULL, NULL));
    delete []rgdwAdjacency;

    *ppMesh = pMesh;

    return S_OK;
}

void CALLBACK OnFrameMove(double fTime, float fElapsedTime, void* pUserContext)
{
    g_Camera.FrameMove(fElapsedTime);
}

void RenderArrows(float fElapsedTime)
{
    WCHAR strWhite[MAX_PATH] = {26};
    WCHAR strBlack[MAX_PATH] = {27};
    CDXUTStatic* pStatic = NULL;

    pStatic = g_WhiteArrowDialog.GetStatic(IDC_WHITESCORE);
    if(pStatic != NULL)
    {
        pStatic->SetText(strWhite);
    }

    pStatic = g_BlackArrowDialog.GetStatic(IDC_BLACKSCORE);
    if(pStatic != NULL)
    {
        pStatic->SetText(strBlack);
    }

	if(!g_Board.pRenjuGame->bGameIsFinished)
	{
		if(g_Board.pRenjuGame->activeColor == White)
		{
			g_WhiteArrowDialog.OnRender(fElapsedTime);
		}
		if(g_Board.pRenjuGame->activeColor == Black)
		{
			g_BlackArrowDialog.OnRender(fElapsedTime);
		}
	}
}

void RenderText()
{
    const D3DSURFACE_DESC* pd3dsdBackBuffer = DXUTGetD3D9BackBufferSurfaceDesc();
    CDXUTTextHelper txtHelper(g_pFont, g_pTextSprite, 15);

    // Output statistics
    txtHelper.Begin();
    txtHelper.SetInsertionPos(5, 5);
    txtHelper.SetForegroundColor(D3DXCOLOR(1.0f, 1.0f, 0.0f, 1.0f));
    txtHelper.DrawTextLine(DXUTGetFrameStats());
    txtHelper.DrawTextLine(DXUTGetDeviceStats());

    txtHelper.SetForegroundColor(D3DXCOLOR(1.0f, 1.0f, 1.0f, 1.0f));
    txtHelper.DrawTextLine(L"Put whatever misc status here");

    if(g_bShowHelp)
    {
        txtHelper.SetInsertionPos(10, pd3dsdBackBuffer->Height - 15 * 6);
        txtHelper.SetForegroundColor(D3DXCOLOR(1.0f, 0.75f, 0.0f, 1.0f));
        txtHelper.DrawTextLine(L"Controls (F1 to hide):");

        txtHelper.SetInsertionPos(40, pd3dsdBackBuffer->Height - 15 * 5);
        txtHelper.DrawTextLine(L"Blah: X\n"
                                L"Quit: ESC");
    }
    else
    {
        txtHelper.SetInsertionPos(10, pd3dsdBackBuffer->Height - 15 * 2);
        txtHelper.SetForegroundColor(D3DXCOLOR(1.0f, 1.0f, 1.0f, 1.0f));
        txtHelper.DrawTextLine(L"Press F1 for help");
    }
    txtHelper.End();
}

void RenderWinner(float fElapsedTime)
{
	if(g_Board.pRenjuGame->winner == Black)
	{
		WCHAR strMessage[MAX_PATH] = L"The Black have won!";
		CDXUTStatic* pStatic = NULL;
		CDXUTElement* pElement = NULL;

		pStatic = g_TheBlackWinnerDialog.GetStatic(IDC_THE_BLACK_WINNER_DIALOG);
		if(pStatic != NULL)
		{
			pStatic->SetText(strMessage);
		}
	        
		pElement = g_TheBlackWinnerDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
		pElement->FontColor.Init(D3DCOLOR_ARGB(255, 255, 255, 255));
		
		g_TheBlackWinnerDialog.OnRender(fElapsedTime);
	}
	else
	{
		if(g_Board.pRenjuGame->winner == White)
		{
			WCHAR strMessage[MAX_PATH] = L"The White have won!";
			CDXUTStatic* pStatic = NULL;
			CDXUTElement* pElement = NULL;

			pStatic = g_TheWhiteWinnerDialog.GetStatic(IDC_THE_WHITE_WINNER_DIALOG);
			if(pStatic != NULL)
			{
				pStatic->SetText(strMessage);
			}
		        
			pElement = g_TheWhiteWinnerDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
			pElement->FontColor.Init(D3DCOLOR_ARGB(255, 0, 0, 0));
			
			g_TheWhiteWinnerDialog.OnRender(fElapsedTime);
		}
	}
}

void CALLBACK OnFrameRender(IDirect3DDevice9* pd3dDevice, double fTime, float fElapsedTime, void* pUserContext)
{
    HRESULT hr;

    V(pd3dDevice->Clear(0, NULL, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER, D3DCOLOR_ARGB(0, 33, 64, 145), 1.0f, 0));

    if(SUCCEEDED(pd3dDevice->BeginScene()))
    {
        g_BackgroundQuad.Render();
        g_Board.Render(pd3dDevice);
        RenderArrows(fElapsedTime);
		RenderWinner(fElapsedTime);


        DXUT_BeginPerfEvent(DXUT_PERFEVENTCOLOR, L"HUD / Stats");
        //RenderText();
        V(g_HUD.OnRender(fElapsedTime));
        V(g_SampleUI.OnRender(fElapsedTime));
        DXUT_EndPerfEvent();

        V(pd3dDevice->EndScene());
    }
}

LRESULT CALLBACK MsgProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam, bool* pbNoFurtherProcessing, void* pUserContext)
{
    *pbNoFurtherProcessing = g_HUD.MsgProc(hWnd, uMsg, wParam, lParam);
    if(*pbNoFurtherProcessing)
        return 0;
    *pbNoFurtherProcessing = g_SampleUI.MsgProc(hWnd, uMsg, wParam, lParam);
    if(*pbNoFurtherProcessing)
        return 0;

    g_Camera.HandleMessages(hWnd, uMsg, wParam, lParam);

    return 0;
}

void CALLBACK KeyboardProc(UINT nChar, bool bKeyDown, bool bAltDown, void* pUserContext)
{
    if(bKeyDown)
    {
        switch(nChar)
        {
            case VK_F1:
                g_bShowHelp = !g_bShowHelp; break;
        }
    }
}

void CALLBACK MouseProc(bool bLeftButtonDown, bool bRightButtonDown, bool bMiddleButtonDown, bool bSideButton1Down, bool bSideButton2Down, int nMouseWheelDelta, int xPos, int yPos, void* pUserContext)
{
    if(bLeftButtonDown)
    {
        NsCell cell = g_Board.GetCellAtPoint(DXUTGetD3D9Device(), xPos, yPos);

        g_Board.PerformMove(g_Board.GetActiveColor(), cell.iRow, cell.iColumn);

		if(g_Board.pRenjuGame->bGameIsFinished)
		{
			g_HUD.GetButton(IDC_RESETGAME)->SetText(L"Start");

			g_SampleUI.GetRadioButton(IDC_GAMEMODE_HUMAN_HUMAN_RADIO)->SetVisible(true);
			g_SampleUI.GetRadioButton(IDC_GAMEMODE_AI_IS_BLACK_RADIO)->SetVisible(true);
			g_SampleUI.GetRadioButton(IDC_GAMEMODE_AI_IS_WHITE_RADIO)->SetVisible(true);
		}
    }
}

void CALLBACK OnGUIEvent(UINT nEvent, int nControlID, CDXUTControl* pControl, void* pUserContext)
{
    switch(nControlID)
    {
        case IDC_TOGGLEFULLSCREEN:
            DXUTToggleFullScreen();
		break;
        case IDC_TOGGLEREF:
            DXUTToggleREF();
		break;
        case IDC_HIDECONSOLE:
			NsConsole::Instance()->Toogle();
		break;
        case IDC_RESETGAME:
			if(!g_Board.pRenjuGame->bGameIsFinished)
			{
				g_Board.Finish();
				NsConsole::Instance()->AddMessage("The game was finished mannualy");
				g_HUD.GetButton(IDC_RESETGAME)->SetText(L"Start");

				g_SampleUI.GetRadioButton(IDC_GAMEMODE_HUMAN_HUMAN_RADIO)->SetVisible(true);
				g_SampleUI.GetRadioButton(IDC_GAMEMODE_AI_IS_BLACK_RADIO)->SetVisible(true);
				g_SampleUI.GetRadioButton(IDC_GAMEMODE_AI_IS_WHITE_RADIO)->SetVisible(true);
			}
			else
			{
				g_Board.Start();
				g_HUD.GetButton(IDC_RESETGAME)->SetText(L"Finish");

				g_SampleUI.GetRadioButton(IDC_GAMEMODE_HUMAN_HUMAN_RADIO)->SetVisible(false);
				g_SampleUI.GetRadioButton(IDC_GAMEMODE_AI_IS_BLACK_RADIO)->SetVisible(false);
				g_SampleUI.GetRadioButton(IDC_GAMEMODE_AI_IS_WHITE_RADIO)->SetVisible(false);
			}
		break;
        case IDC_GAMEMODE_HUMAN_HUMAN_RADIO:
			g_Board.pRenjuGame->SetNsGameMode(NsGameMode::Human_Human);
		break;
        case IDC_GAMEMODE_AI_IS_BLACK_RADIO:
			g_Board.pRenjuGame->SetNsGameMode(NsGameMode::AI_Black);
		break;
        case IDC_GAMEMODE_AI_IS_WHITE_RADIO:
			g_Board.pRenjuGame->SetNsGameMode(NsGameMode::AI_White);
		break;
        case IDC_LAUNCH_RENJU_MANUAL:
			HINSTANCE hiResult = ShellExecute(
				NULL,
				L"open",
				(NsD3DResourceManager::Instance()->GetAbsoluteContentFolderPath() + L"/Other/renju_manual.pdf").c_str(),
				NULL,
				NULL,
				SW_SHOWNORMAL);

			if((int)hiResult > 32)
			{
				NsConsole::Instance()->AddMessage("The manual was shown");
			}
			else
			{
				NsConsole::Instance()->AddMessage("Warning! Fail to show manual");
			}
		break;
    }
}

void InitApp()
{
    g_HUD.Init(&g_DialogResourceManager);
    g_SampleUI.Init(&g_DialogResourceManager);
    g_WhiteArrowDialog.Init(&g_DialogResourceManager);
    g_BlackArrowDialog.Init(&g_DialogResourceManager);
	g_TheWhiteWinnerDialog.Init(&g_DialogResourceManager);
	g_TheBlackWinnerDialog.Init(&g_DialogResourceManager);

    g_HUD.SetCallback(OnGUIEvent); int iY = 10;
    g_HUD.AddButton(IDC_TOGGLEFULLSCREEN, L"Toggle Full Screen", 35, iY, 125, 22);
    g_HUD.AddButton(IDC_HIDECONSOLE, L"Console", 35, iY += 24, 125, 22);
    g_HUD.AddButton(IDC_LAUNCH_RENJU_MANUAL, L"Manual", 35, iY += 24, 125, 22);
    g_HUD.AddButton(IDC_RESETGAME, L"Start", 35, iY += 24, 125, 22);

	g_SampleUI.AddRadioButton(IDC_GAMEMODE_HUMAN_HUMAN_RADIO, 1, L"Human - Human", 35, iY += 24, 220, 24, true, L'1');
    g_SampleUI.AddRadioButton(IDC_GAMEMODE_AI_IS_BLACK_RADIO, 1, L"AI is Black", 35, iY += 24, 220, 24, false, L'2');
    g_SampleUI.AddRadioButton(IDC_GAMEMODE_AI_IS_WHITE_RADIO, 1, L"AI is White", 35, iY += 24, 220, 24, false, L'3');

	g_SampleUI.SetCallback(OnGUIEvent);

    CDXUTStatic* pStatic = NULL;
    CDXUTElement* pElement = g_WhiteArrowDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
    if(pElement)
    {
        pElement->FontColor.Init(D3DCOLOR_ARGB(255, 255, 255, 255));
    }

    g_WhiteArrowDialog.SetSize(150, 100);
    g_WhiteArrowDialog.SetBackgroundColors(D3DCOLOR_ARGB(0, 255, 255, 255), D3DCOLOR_ARGB(0, 255, 255, 255),
                                            D3DCOLOR_ARGB(0, 255, 255, 255), D3DCOLOR_ARGB(0, 255, 255, 255));
    g_WhiteArrowDialog.SetCallback(OnGUIEvent);
    g_WhiteArrowDialog.SetFont(0, L"Arial", 120, FW_BOLD);
    g_WhiteArrowDialog.AddStatic(IDC_WHITESCORE, L"2", 0, 0, g_WhiteArrowDialog.GetWidth(),
                                  g_WhiteArrowDialog.GetHeight(), false, &pStatic);

    pElement = g_BlackArrowDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
    if(pElement)
    {
        pElement->FontColor.Init(D3DCOLOR_ARGB(255, 0, 0, 0));
    }

    g_BlackArrowDialog.SetSize(150, 100);
    g_BlackArrowDialog.SetBackgroundColors(D3DCOLOR_ARGB(0, 16, 16, 16), D3DCOLOR_ARGB(0, 16, 16, 16),
                                            D3DCOLOR_ARGB(0, 16, 16, 16), D3DCOLOR_ARGB(0, 16, 16, 16));
    g_BlackArrowDialog.SetCallback(OnGUIEvent);
    g_BlackArrowDialog.SetFont(0, L"Arial", 120, FW_BOLD);
    g_BlackArrowDialog.AddStatic(IDC_BLACKSCORE, L"2", 0, 0, g_BlackArrowDialog.GetWidth(),
                                  g_BlackArrowDialog.GetHeight(), false, &pStatic);

	pElement = g_TheWhiteWinnerDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
    if(pElement)
    {
       pElement->FontColor.Init(D3DCOLOR_ARGB(255, 255, 255, 255));
    }

    pElement = g_TheWhiteWinnerDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
    g_TheWhiteWinnerDialog.SetSize(500, 100);
    g_TheWhiteWinnerDialog.SetBackgroundColors(D3DCOLOR_ARGB(0, 16, 16, 16), D3DCOLOR_ARGB(0, 16, 16, 16),
                                            D3DCOLOR_ARGB(0, 16, 16, 16), D3DCOLOR_ARGB(0, 16, 16, 16));
    g_TheWhiteWinnerDialog.SetCallback(OnGUIEvent);
    g_TheWhiteWinnerDialog.SetFont(0, L"Arial", 60, FW_BOLD);
    g_TheWhiteWinnerDialog.AddStatic(IDC_THE_WHITE_WINNER_DIALOG, L"2", 0, 0, g_TheWhiteWinnerDialog.GetWidth(),
                                  g_TheWhiteWinnerDialog.GetHeight(), false, &pStatic);

	pElement = g_TheBlackWinnerDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
    if(pElement)
    {
       pElement->FontColor.Init(D3DCOLOR_ARGB(255, 0, 0, 0));
    }

    pElement = g_TheBlackWinnerDialog.GetDefaultElement(DXUT_CONTROL_STATIC, 0);
    g_TheBlackWinnerDialog.SetSize(500, 100);
    g_TheBlackWinnerDialog.SetBackgroundColors(D3DCOLOR_ARGB(0, 16, 16, 16), D3DCOLOR_ARGB(0, 16, 16, 16),
                                            D3DCOLOR_ARGB(0, 16, 16, 16), D3DCOLOR_ARGB(0, 16, 16, 16));
    g_TheBlackWinnerDialog.SetCallback(OnGUIEvent);
    g_TheBlackWinnerDialog.SetFont(0, L"Arial", 60, FW_BOLD);
    g_TheBlackWinnerDialog.AddStatic(IDC_THE_BLACK_WINNER_DIALOG, L"2", 0, 0, g_TheBlackWinnerDialog.GetWidth(),
                                  g_TheBlackWinnerDialog.GetHeight(), false, &pStatic);
}

INT WINAPI wWinMain(HINSTANCE, HINSTANCE, LPWSTR, int)
{
    DXUTSetCallbackD3D9DeviceAcceptable(IsDeviceAcceptable);
    DXUTSetCallbackD3D9DeviceCreated(OnCreateDevice);
    DXUTSetCallbackD3D9FrameRender(OnFrameRender);
    DXUTSetCallbackD3D9DeviceReset(OnResetDevice);
    DXUTSetCallbackD3D9DeviceLost(OnLostDevice);
    DXUTSetCallbackD3D9DeviceDestroyed(OnDestroyDevice);
    DXUTSetCallbackMsgProc(MsgProc);
    DXUTSetCallbackKeyboard(KeyboardProc);
    DXUTSetCallbackMouse(MouseProc, true);
    DXUTSetCallbackFrameMove(OnFrameMove);
    DXUTSetCallbackDeviceChanging(ModifyDeviceSettings);

    DXUTSetCursorSettings(true, true);

    InitApp();

    DXUTInit();
    DXUTSetHotkeyHandling();
    DXUTCreateWindow(L"NsRenju by Ivan Goremykin");
    DXUTCreateDevice(true, 1024, 768);

    DXUTMainLoop();

    return DXUTGetExitCode();
}