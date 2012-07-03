#include "NsBoard.h"

//--------------------------------------------------------------------------------------
// Moves the world-space XY plane into screen-space for pixel-perfect perspective
//--------------------------------------------------------------------------------------
HRESULT CalculateViewAndProjection(D3DXMATRIX * pViewOut, D3DXMATRIX* pProjectionOut, float fFieldOfViewY, float fScreenDepth = 10000, float fNearClip = 0.1f)
{
    if(pViewOut == NULL || pProjectionOut == NULL)
	{
        return E_INVALIDARG;
	}

    // get back buffer description and determine aspect ratio
    const D3DSURFACE_DESC* pBackBufferSurfaceDesc = DXUTGetD3D9BackBufferSurfaceDesc();
    float fWidth = (float)pBackBufferSurfaceDesc->Width;
    float fHeight = (float)pBackBufferSurfaceDesc->Height;
    float fAspectRatio = fWidth / fHeight;

    // Determine the correct Z depth to completely fill the frustum
    float fYScale = 1 / tanf(fFieldOfViewY / 2);
    float fZ = fYScale * fHeight / 2;

    // Calculate perspective projection
    D3DXMatrixPerspectiveFovLH(pProjectionOut, fFieldOfViewY, fAspectRatio, fNearClip, fZ + fScreenDepth);

    // Initialize the view matrix as a rotation and translation from "screen-coordinates"
    // in world space (the XY plane from the perspective of Z+) to a plane that's centered
    // along Z+
    D3DXMatrixIdentity(pViewOut);
    pViewOut->_22 = -1;
    pViewOut->_33 = -1;
    pViewOut->_41 = -(fWidth / 2);
    pViewOut->_42 = (fHeight / 2);
    pViewOut->_43 = fZ;

    return S_OK;
}

NsBoard::NsBoard(D3DXVECTOR3 position, float fSize)
{
    Initialize(position, fSize);
}

NsBoard::NsBoard(D3DXVECTOR3 position)
{
    Initialize(position);
}

NsBoard::NsBoard()
{
    Initialize();
}

NsBoard::~NsBoard()
{
	delete pRenjuGame;
}

void NsBoard::Initialize(D3DXVECTOR3 position, float fSize)
{
    Position = position;

    pVertexBuffer = NULL;
    pDiscMesh = NULL;

    ZeroMemory(&CellAnimations, sizeof(CellAnimations));
    ZeroMemory(&BoardAnimation, sizeof(BoardAnimation));

    SetSize(fSize);

	pRenjuGame = new NsRenjuGame(NsGameMode::Human_Human);

    Finish();
}

void NsBoard::Start()
{
    ZeroMemory(&Discs, sizeof(Discs));

	if(pRenjuGame->GetNsGameMode() == AI_Black)
	{
		Discs[7][7] = Black;
	}

    InitializeCellRotations();

    pRenjuGame->bGameIsFinished = false;

	pRenjuGame->Start(pRenjuGame->GetNsGameMode());

    AnimateBoard();
}

void NsBoard::Finish()
{
    ZeroMemory(&Discs, sizeof(Discs));
	pRenjuGame->activeColor = None;
    pRenjuGame->bGameIsFinished = true;
    AnimateBoard();
}

void NsBoard::AnimateBoard()
{
    BoardAnimation.fStartTime = (float)DXUTGetTime();
    BoardAnimation.fEndTime = BoardAnimation.fStartTime + 0.7f;
    BoardAnimation.fStartRotation = BoardAnimation.fCurrentRotation;

    switch(pRenjuGame->activeColor)
    {
        case None:
            BoardAnimation.fEndRotation = 0;
        break;
        case White:
            BoardAnimation.fEndRotation = -D3DX_PI / 8;
        break;
        case Black:
            BoardAnimation.fEndRotation = D3DX_PI / 8;
        break;
    }
}

void NsBoard::InitializeCellRotations()
{
    for(int iRow = 0; iRow < NS_RENJU_NUM_ROWS; iRow++)
    {
        for(int iColumn = 0; iColumn < NS_RENJU_NUM_ROWS; iColumn++)
        {
            switch(Discs[iRow][iColumn])
            {
                case White:
                    CellAnimations[iRow][iColumn].fEndRotation = D3DX_PI / 2;
                break;

                case Black:
                    CellAnimations[iRow][iColumn].fEndRotation = 3 * D3DX_PI / 2;
                break;

                case None:
                    CellAnimations[iRow][iColumn].fEndRotation = 0;
                break;

                default:
                    assert(false);
            }
        }
    }

	whiteDiscAnimation.fEndRotation = D3DX_PI / 2;
	blackDiskAnimation.fEndRotation = 3 * D3DX_PI / 2;
}

HRESULT NsBoard::OnCreateDevice(IDirect3DDevice9* pD3DDevice, DWORD dwShaderFlags)
{
    HRESULT hr;

    V_RETURN(CreateVertexDeclaration(pD3DDevice));
    V_RETURN(CreateVertexBuffer(pD3DDevice));

	std::wstring wsCurrentResourcePath;
	std::wstring wsAbsoluteContentDirectoryPath = NsD3DResourceManager::Instance()->GetAbsoluteContentFolderPath();
	
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Shaders/Renju/board.fx";
	V_RETURN(D3DXCreateEffectFromFile(pD3DDevice, wsCurrentResourcePath.c_str(), NULL, NULL, dwShaderFlags, NULL, &pEffect, NULL));
	
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Models/stone.x";
    V_RETURN(D3DXLoadMeshFromX(wsCurrentResourcePath.c_str(), D3DXMESH_MANAGED, pD3DDevice, NULL, NULL, NULL, NULL, &pDiscMesh));

    IDirect3DCubeTexture9 * pCubeTexture = NsNullPointer;
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Textures/Renju/lobby_cube.dds";
	V_RETURN(D3DXCreateCubeTextureFromFile(pD3DDevice, wsCurrentResourcePath.c_str(), &pCubeTexture));
    pEffect->SetTexture("EnvironmentMap", pCubeTexture);
    SAFE_RELEASE(pCubeTexture);

    IDirect3DTexture9 * pTexture = NsNullPointer;
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Textures/Renju/board.tga";
    V_RETURN(D3DXCreateTextureFromFile(pD3DDevice, wsCurrentResourcePath.c_str(), &pTexture));
    pEffect->SetTexture("BoardTexture", pTexture);
    SAFE_RELEASE(pTexture);
	
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Shaders/Renju/textured_quad.fx";
	RippleQuad.Create(pD3DDevice, wsCurrentResourcePath.c_str());
	wsCurrentResourcePath = wsAbsoluteContentDirectoryPath + L"/Textures/Renju/ripple.png";
    RippleQuad.LoadTexture("QuadTexture", wsCurrentResourcePath.c_str());

    return S_OK;
}

HRESULT NsBoard::OnResetDevice(IDirect3DDevice9 * pD3DDevice, const D3DSURFACE_DESC * pBackBufferSurfaceDesc)
{
    HRESULT hr;

    V_RETURN(pEffect->OnResetDevice());
    V_RETURN(RippleQuad.OnResetDevice());

    return S_OK;
}

void NsBoard::OnLostDevice()
{
    HRESULT hr;

    RippleQuad.OnLostDevice();
    V(pEffect->OnLostDevice());
}

void NsBoard::OnDestroyDevice()
{
    RippleQuad.Destroy();

    SAFE_RELEASE(pDiscMesh);
    SAFE_RELEASE(pEffect);
    SAFE_RELEASE(pVertexBuffer);
    SAFE_RELEASE(pVertexDeclaration);
}

HRESULT NsBoard::CreateVertexDeclaration(IDirect3DDevice9 * pD3DDevice)
{
    HRESULT hr;

    D3DVERTEXELEMENT9 elements[] =
    {
        { 0, 0, D3DDECLTYPE_FLOAT3, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_POSITION, 0 },
        { 0, 12, D3DDECLTYPE_FLOAT3, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_NORMAL, 0 },
        { 0, 24, D3DDECLTYPE_FLOAT2, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_TEXCOORD, 0 },
        { 0, 32, D3DDECLTYPE_D3DCOLOR, D3DDECLMETHOD_DEFAULT, D3DDECLUSAGE_COLOR, 0 },
        D3DDECL_END()
    };

    V_RETURN(pD3DDevice->CreateVertexDeclaration(elements, &pVertexDeclaration));

    return S_OK;
}

HRESULT NsBoard::CreateVertexBuffer(IDirect3DDevice9 * pD3DDevice)
{
    HRESULT hr;

    SAFE_RELEASE(pVertexBuffer);

    V_RETURN(pD3DDevice->CreateVertexBuffer(sizeof(NsBoardVertex) * 4, D3DUSAGE_WRITEONLY, 0, D3DPOOL_MANAGED, &pVertexBuffer, NULL));

    NsBoardVertex* pVertex = NsNullPointer;
    V_RETURN(pVertexBuffer->Lock(0, 0, (void**)&pVertex, 0));

    pVertex->Position = D3DXVECTOR3(-0.5f, -0.5f, 0);
    pVertex->Normal = D3DXVECTOR3(0, 0, 1);
    pVertex->TexCoord = D3DXVECTOR2(0.0f, 0.0f);
    pVertex->NsCellValue = D3DCOLOR_ARGB(255, 255, 255, 255);
    pVertex++;

    pVertex->Position = D3DXVECTOR3(0.5f, -0.5f, 0);
    pVertex->Normal = D3DXVECTOR3(0, 0, 1);
    pVertex->TexCoord = D3DXVECTOR2(1.0f, 0.0f);
    pVertex->NsCellValue = D3DCOLOR_ARGB(255, 255, 255, 255);
    pVertex++;

    pVertex->Position = D3DXVECTOR3(0.5f, 0.5f, 0);
    pVertex->Normal = D3DXVECTOR3(0, 0, 1);
    pVertex->TexCoord = D3DXVECTOR2(1.0f, 1.0f);
    pVertex->NsCellValue = D3DCOLOR_ARGB(255, 255, 255, 255);
    pVertex++;

    pVertex->Position = D3DXVECTOR3(-0.5f, 0.5f, 0);
    pVertex->Normal = D3DXVECTOR3(0, 0, 1);
    pVertex->TexCoord = D3DXVECTOR2(0.0f, 1.0f);
    pVertex->NsCellValue = D3DCOLOR_ARGB(255, 255, 255, 255);
    pVertex++;

    pVertexBuffer->Unlock();

    return S_OK;
}

void NsBoard::CalculateBoardWorldMatrix(D3DXMATRIX* world)
{
    D3DXMATRIXA16 scaling;
    D3DXMatrixScaling(&scaling, Size, Size, Size);

    D3DXMATRIXA16 translation;
    D3DXMatrixTranslation(&translation, Position.x, Position.y, Position.z);

    D3DXMATRIXA16 rotation;
    D3DXMatrixRotationY(&rotation, BoardAnimation.fCurrentRotation);

    D3DXMatrixMultiply(world, &scaling, &rotation);
    D3DXMatrixMultiply(world, world, &translation);
}

void NsBoard::CalculateDiscWorldMatrix(D3DXMATRIX* world, int iRow, int iColumn)
{
    float cellSize = Size / (NS_RENJU_NUM_ROWS + 1); //TODO

    D3DXMATRIXA16 scaling;
    float cellScale = 0.9f * cellSize;
    D3DXMatrixScaling(&scaling, cellScale, cellScale, cellScale);

    float fX = cellSize * (iColumn - 1) - ((NS_RENJU_NUM_ROWS / 2 - 0.5f) * cellSize) + cellSize/2; //TODO
    float fY = cellSize * (iRow - 1) - ((NS_RENJU_NUM_ROWS / 2 - 0.5f) * cellSize) + cellSize/2; //TODO

    D3DXMATRIXA16 translation;
    D3DXMatrixTranslation(&translation, fX, fY, Position.z);

    D3DXMATRIXA16 rotation;
    D3DXMatrixRotationY(&rotation, BoardAnimation.fCurrentRotation);

    D3DXMatrixMultiply(world, &scaling, &translation);
    D3DXMatrixMultiply(world, world, &rotation);

    D3DXMatrixTranslation(&translation, Position.x, Position.y, Position.z);
    D3DXMatrixMultiply(world, world, &translation);
}

void NsBoard::Render(IDirect3DDevice9* pD3DDevice)
{
    HRESULT hr;
    UINT NumPasses;
    D3DXVECTOR4 NsCellValue;

    RenderBoard(pD3DDevice);

    if(RippleQuad.pEffect == NsNullPointer)
	{
        return;
	}

    float fElapsedTime = DXUTGetElapsedTime();
    fRippleAlpha *= 0.98f;
    RippleQuad.pEffect->SetFloat("AlphaMultiplier", fRippleAlpha);

    fRippleScale += 20 * fElapsedTime;
    D3DXMATRIXA16 mScaling, mWorld;
    D3DXMatrixScaling(&mScaling, fRippleScale, fRippleScale, fRippleScale);
    CalculateDiscWorldMatrix(&mWorld, iRippleRow, iRippleColumn);
    D3DXMatrixMultiply(&RippleQuad.World, &mScaling, &mWorld);
    RippleQuad.Render();

    D3DXMATRIXA16 world, view, projection;
    CalculateViewAndProjection(&view, &projection, D3DX_PI / 4);

    V(pEffect->SetMatrix("View", &view));
    V(pEffect->SetMatrix("Projection", &projection));
 
    pEffect->SetTechnique("Disc");
    V(pEffect->Begin(&NumPasses, 0));
    for(UINT iPass = 0; iPass < NumPasses; ++iPass)
    {
        V(pEffect->BeginPass(iPass));

        for(int iRow = 0; iRow < NS_RENJU_NUM_ROWS; iRow++)
        {
            for(int iColumn = 0; iColumn < NS_RENJU_NUM_ROWS; iColumn++)
            {
                if(Discs[iRow][iColumn] == None)
				{
                    continue;
				}

                NsAnimationEvent& cellAnimation = CellAnimations[iRow][iColumn];

                if(cellAnimation.fStartTime < DXUTGetTime())
                {
                    if(cellAnimation.fEndTime > DXUTGetTime())
                    {
                        float fDelta = (cellAnimation.fEndRotation - cellAnimation.fStartRotation);
                        float fRatio = ((float)DXUTGetTime() - cellAnimation.fStartTime) / (cellAnimation.fEndTime - cellAnimation.fStartTime);
                        fRatio = powf(fRatio, 0.2f);
                        cellAnimation.fCurrentRotation = cellAnimation.fStartRotation + (fRatio * fDelta);
                    }
                    else
                    {
                        cellAnimation.fCurrentRotation = cellAnimation.fEndRotation;
                    }
                }

                D3DXMATRIXA16 rotation;
                D3DXMatrixRotationX(&rotation, cellAnimation.fCurrentRotation);

                CalculateDiscWorldMatrix(&world, iRow, iColumn);
                D3DXMatrixMultiply(&world, &rotation, &world);

                V(pEffect->SetMatrix("World", &world));

                NsCellValue = D3DXVECTOR4(0, 0, 0, 0);

                if(Discs[iRow][iColumn] == White)
				{
                    NsCellValue = D3DXVECTOR4(1, 1, 1, 1);
				}
                else if(Discs[iRow][iColumn] == Black)
				{
                    NsCellValue = D3DXVECTOR4(0, 0, 0, 1);
				}

                if(IsLegalMove(pRenjuGame->activeColor, iRow, iColumn))
				{
                    NsCellValue = D3DXVECTOR4(0, 0, 1, 0.5f);
				}

                V(pEffect->CommitChanges());

                V(pDiscMesh->DrawSubset(0));
                V(pDiscMesh->DrawSubset(2));
            }
        }
        V(pEffect->EndPass());
    }
    V(pEffect->End());
}



void NsBoard::RenderBoard(IDirect3DDevice9 * pD3DDevice)
{
    HRESULT hr;

    if(pEffect == NsNullPointer)
	{
        return;
	}

    if(BoardAnimation.fStartTime < DXUTGetTime())
    {
        if(BoardAnimation.fEndTime > DXUTGetTime())
        {
            float fDelta = (BoardAnimation.fEndRotation - BoardAnimation.fStartRotation);
            float fRatio = ((float)DXUTGetTime() - BoardAnimation.fStartTime) /
                (BoardAnimation.fEndTime - BoardAnimation.fStartTime);
            fRatio = sinf(fRatio * D3DX_PI / 2);
            BoardAnimation.fCurrentRotation = BoardAnimation.fStartRotation + (fRatio * fDelta);
        }
        else
        {
            BoardAnimation.fCurrentRotation = BoardAnimation.fEndRotation;
        }
    }

    V(pD3DDevice->SetVertexDeclaration(pVertexDeclaration));
    V(pD3DDevice->SetStreamSource(0, pVertexBuffer, 0, sizeof(NsBoardVertex)));

    float fBoardAlpha = 0.8f;
    for(int i = 0; i < 8; ++i)
    {
        D3DXMATRIXA16 world, view, projection;
        CalculateBoardWorldMatrix(&world);
        CalculateViewAndProjection(&view, &projection, D3DX_PI / 4);

		switch(i)
		{
		case 1:
		{
            fBoardAlpha = 0.15f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, -0.1f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		case 2:
		{
            fBoardAlpha = 0.1f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, -0.2f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		case 3:
		{
            fBoardAlpha = 0.05f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, -0.3f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		case 4:
		{
            fBoardAlpha = 0.15f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, 0.1f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		case 5:
		{
            fBoardAlpha = 0.1f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, 0.2f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		case 6:
		{
            fBoardAlpha = 0.05f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, 0.3f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		case 7:
		{
            fBoardAlpha = 0.02f;
            D3DXMATRIXA16 translation;
            D3DXMatrixTranslation(&translation, 0, 0, 0.4f);
            D3DXMatrixMultiply(&world, &translation, &world);
			break;
		}
		}

        V(pEffect->SetFloat("BoardAlpha", fBoardAlpha));
        V(pEffect->SetMatrix("World", &world));
        V(pEffect->SetMatrix("View", &view));
        V(pEffect->SetMatrix("Projection", &projection));

        UINT iNumPasses;
        pEffect->SetTechnique("Board");
        V(pEffect->Begin(&iNumPasses, 0));
        for(UINT iPass = 0; iPass < iNumPasses; iPass++)
        {
            V(pEffect->BeginPass(iPass));
            V(pD3DDevice->DrawPrimitive(D3DPT_TRIANGLEFAN, 0, 2));
            V(pEffect->EndPass());
        }
        V(pEffect->End());
    }
}

NsCell NsBoard::GetCellAtPoint(IDirect3DDevice9* pD3DDevice, int iX, int iY)
{
    D3DXVECTOR3 point((float)iX, (float)iY, 0.0f);
    D3DXVECTOR3 direction(0.0f, 0.0f, 1.0f);

    D3DXMATRIXA16 world, view, projection;
    CalculateViewAndProjection(&view, &projection, D3DX_PI / 4);

    D3DVIEWPORT9 viewport;
    pD3DDevice->GetViewport(&viewport);

    for(int iRow = 0; iRow < NS_RENJU_NUM_ROWS; ++iRow)
    {
        for(int iColumn = 0; iColumn < NS_RENJU_NUM_ROWS; ++iColumn)
        {
            D3DXVECTOR3 vertices[] =
            {
                D3DXVECTOR3(-0.5f, -0.5f, 0),
                D3DXVECTOR3(0.5f, -0.5f, 0),
                D3DXVECTOR3(0.5f, 0.5f, 0),
                D3DXVECTOR3(-0.5f, 0.5f, 0)
            };

            CalculateDiscWorldMatrix(&world, iRow, iColumn);

            for(int i = 0; i < 4; i++)
            {
                D3DXVec3Project(&vertices[i], &vertices[i], &viewport, &projection, &view, &world);
            }

            if(D3DXIntersectTri(&vertices[0], &vertices[1], &vertices[2], &point, &direction, NULL, NULL, NULL) ||
                D3DXIntersectTri(&vertices[2], &vertices[3], &vertices[0], &point, &direction, NULL, NULL, NULL))
			{
                return NsCell(iRow, iColumn);
			}
        }
    }

    return NsCell(-1, -1);
}

bool NsBoard::IsValidCellAddress(int iRow, int iColumn)
{
    return (iRow >= 0 && iRow < NS_RENJU_NUM_ROWS && iColumn >= 0 && iColumn < NS_RENJU_NUM_ROWS);
}

bool NsBoard::IsLegalMove(NsCellValue disc, int iRow, int iColumn)
{
    if(disc != White && disc != Black)
	{
        return false;
	}

    if(!IsValidCellAddress(iRow, iColumn))
	{
        return false;
	}

    if(Discs[iRow][iColumn] != None)
	{
        return false;
	}

    return true;
}

bool NsBoard::PerformMove(NsCellValue disc, int iRow, int iColumn)
{
	if(pRenjuGame->bGameIsFinished)
	{
		return false;
	}

    if(!IsLegalMove(disc, iRow, iColumn))
	{
        return false;
	}

	if(pRenjuGame->activeColor == Black)
	{
		NsCellValue board_Debug[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS];

		// тут приходитс€ мен€ть цвета местами из-за нашей кривизны рук и несоответстви€ цветов в прологе и с€х
		NsCellValue InvertedDiscs[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS];
		for(int i = 0; i < NS_RENJU_NUM_ROWS; ++i)
		{
			for(int j = 0; j < NS_RENJU_NUM_ROWS; ++j)
			{
				if(Discs[i][j] == White)
				{
					InvertedDiscs[i][j] = Black;
				}
				else
				{
					if(Discs[i][j] == Black)
					{
						InvertedDiscs[i][j] = White;
					}
					else
					{
						InvertedDiscs[i][j] = Discs[i][j];
					}
				}
			}
		}

		bool bLegalMove = pRenjuGame->renjuArbitrator.CheckLegalBlackMove(InvertedDiscs, board_Debug, iRow, iColumn);
		NsConsole::Instance()->AddMessage("Arbitrator is cheking if the black move was legal...");
		pRenjuGame->Write(board_Debug);

		if(!bLegalMove)
		{
			NsConsole::Instance()->AddMessage("Black player is trying to set a stone at (" + NsText::ToString(iRow) + ";" +	NsText::ToString(iColumn) + ") It's rectricted (black fail)");
			return false;
		}
	}

    iRippleRow = iRow;
    iRippleColumn = iColumn;
    fRippleScale = 1.0f;
    fRippleAlpha = 0.3f;

    if(disc == White)
    {
        float colorMultiplier[] = {1, 1, 1};
        RippleQuad.pEffect->SetFloatArray("ColorMultiplier", colorMultiplier, 3);
    }

    if(disc == Black)
    {
        float colorMultiplier[] = {0, 0, 0};
        RippleQuad.pEffect->SetFloatArray("ColorMultiplier", colorMultiplier, 3);
    }

    Discs[iRow][iColumn] = disc;
    CellAnimations[iRow][iColumn].fEndRotation = (disc == White) ? D3DX_PI / 2 : 3 * D3DX_PI / 2;

	int iWinner = pRenjuGame->renjuArbitrator.CheckGameOver(Discs, pRenjuGame->renjuAI.GetColor());
	if(iWinner)
	{
		NsString sMessage("Game over. ");
		if(iWinner == Black)
		{
			sMessage.append("Black player have won!");
		}
		else
		{
			sMessage.append("White player have won!");
		}
		NsConsole::Instance()->AddMessage(sMessage);

		pRenjuGame->winner = (NsCellValue)iWinner;
		pRenjuGame->activeColor = None;
		pRenjuGame->bGameIsFinished = true;
	}
	else
	{
		int iAIRow, iAIColumn;
		NsCellValue board_debug[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS];
		switch(pRenjuGame->GetNsGameMode())
		{
			case Human_Human:
				pRenjuGame->activeColor = (pRenjuGame->activeColor == White) ? Black : White;
				pRenjuGame->Write(Discs, disc, iRow, iColumn);
			break;
			case AI_Black:
				pRenjuGame->renjuAI.GetNextStep_Debug(Discs, iAIRow, iAIColumn, board_debug);
				Discs[iAIRow][iAIColumn] = Black;
				CellAnimations[iAIRow][iAIColumn].fEndRotation = 3 * D3DX_PI / 2;
				pRenjuGame->Write(board_debug, Black, iAIRow, iAIColumn);
			break;
			case AI_White:
				pRenjuGame->renjuAI.GetNextStep_Debug(Discs, iAIRow, iAIColumn, board_debug);
				Discs[iAIRow][iAIColumn] = White;
				CellAnimations[iAIRow][iAIColumn].fEndRotation = D3DX_PI / 2;
				pRenjuGame->Write(board_debug, White, iAIRow, iAIColumn);
			break;
		}

		int iWinner = pRenjuGame->renjuArbitrator.CheckGameOver(Discs, pRenjuGame->renjuAI.GetColor());
		if(iWinner)
		{
			NsString sMessage("Game over. ");
			if(iWinner == Black)
			{
				sMessage.append("Black player have won!");
			}
			else
			{
				sMessage.append("White player have won!");
			}
			NsConsole::Instance()->AddMessage(sMessage);

			pRenjuGame->winner = (NsCellValue)iWinner;
			pRenjuGame->activeColor = None;
			pRenjuGame->bGameIsFinished = true;
		}
		else
		{
			if(!LegalMoveExists(pRenjuGame->activeColor))
			{
				pRenjuGame->activeColor = (pRenjuGame->activeColor == White) ? Black : White;
				if(!LegalMoveExists(pRenjuGame->activeColor))
				{
					NsConsole::Instance()->AddMessage("Game over. The Drawn Game!");
					pRenjuGame->activeColor = None;
					pRenjuGame->bGameIsFinished = true;
				}
			}
		}
	}

    AnimateBoard();

    return true;
}


bool NsBoard::LegalMoveExists(NsCellValue cellValue)
{
    for(int iRow = 0; iRow < NS_RENJU_NUM_ROWS; ++iRow)
    {
        for(int iColumn = 0; iColumn < NS_RENJU_NUM_ROWS; ++iColumn)
        {
            if(IsLegalMove(cellValue, iRow, iColumn))
			{
                return true;
			}
        }
    }

    return false;
}

int NsBoard::GetScore(NsCellValue cellValue)
{
    int iScore = 0;
    for(int iRow = 0; iRow < NS_RENJU_NUM_ROWS; ++iRow)
    {
        for(int iColumn = 0; iColumn < NS_RENJU_NUM_ROWS; ++iColumn)
        {
            if(Discs[iRow][iColumn] == cellValue)
			{
                iScore++;
			}
        }
    }

    return iScore;
}