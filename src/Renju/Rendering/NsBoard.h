#pragma once
#include "../../3rd party/DXUT/Core/dxut.h"
#include "../../3rd party/DXUT/Optional/SDKmisc.h"
#include "../../Shared/ResourceManagement/NsD3DResourceManager.h"
#include "../../Shared/Utils/NsConsole.h"
#include "../Game/NsRenjuGame.h"
#include "NsTexturedQuad.h"
#include "math.h"

struct NsCell
{
    int iRow;
    int iColumn;

    NsCell(int iSourceRow, int iSoureColumn)
    {
        iRow = iSourceRow;
		iColumn = iSoureColumn;
    }
};

struct NsBoardVertex
{
    D3DXVECTOR3 Position;
    D3DXVECTOR3 Normal;
    D3DXVECTOR2 TexCoord;
    D3DCOLOR NsCellValue;
};

struct NsAnimationEvent
{
    float fCurrentRotation;

    float fStartTime;
    float fStartRotation;

    float fEndTime;
    float fEndRotation;
};

class NsBoard
{
public:
	NsBoard();
	NsBoard(D3DXVECTOR3 position);
	NsBoard(D3DXVECTOR3 position, float fSize);
	~NsBoard();

    void Start();
    void Finish();

    HRESULT OnCreateDevice(IDirect3DDevice9* pD3DDevice, DWORD dwShaderFlags=0);
    HRESULT OnResetDevice(IDirect3DDevice9* pD3DDevice, const D3DSURFACE_DESC* pBackBufferSurfaceDesc);
    void OnLostDevice();
    void OnDestroyDevice();

    void Render(IDirect3DDevice9 * pD3DDevice);
    void RenderBoard(IDirect3DDevice9 * pD3DDevice);

    bool IsLegalMove(NsCellValue disc, int iRow, int iColumn);
    bool IsValidCellAddress(int iRow, int iColumn);
    NsCell GetCellAtPoint(IDirect3DDevice9 * pD3DDevice, int iX, int iY);
    int GetScore(NsCellValue cellValue);
    bool LegalMoveExists(NsCellValue NsCellValue);
    bool PerformMove(NsCellValue disc, int iRow, int iColumn);

    void SetPosition(D3DXVECTOR3 position)
    {
        Position = position;
    }

    float GetPositionX()
    {
        return Position.x;
    }

    float GetPositionY()
    {
        return Position.y;
    }

    float GetPositionZ()
    {
        return Position.z;
    }

    void SetSize(float fSize)
    {
        Size = fSize;
    }
    float GetSize()
    {
        return Size;
    }

    NsCellValue GetActiveColor()
    {
        return pRenjuGame->activeColor;
    }

    void SetActiveColor(NsCellValue cellValue)
    {
        pRenjuGame->activeColor = cellValue;
    }

    bool IsFinished()
    {
        return pRenjuGame->bGameIsFinished;
    }
	
	NsRenjuGame * pRenjuGame;

private:
    HRESULT CreateVertexDeclaration(IDirect3DDevice9* pD3DDevice);
    HRESULT CreateVertexBuffer(IDirect3DDevice9* pD3DDevice);

    void Initialize(D3DXVECTOR3 position = D3DXVECTOR3(100, 100, 0), float fSize = 100);
    void InitializeCellRotations();
    void CalculateBoardWorldMatrix(D3DXMATRIX* world);
    void CalculateDiscWorldMatrix(D3DXMATRIX* world, int iRow, int iColumn);
    void AnimateBoard();

    D3DXVECTOR3 Position;
    float Size;

    NsAnimationEvent BoardAnimation;
    NsAnimationEvent CellAnimations[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS];
	NsAnimationEvent whiteDiscAnimation, blackDiskAnimation;

    ID3DXMesh * pDiscMesh;
    NsCellValue Discs[NS_RENJU_NUM_ROWS][NS_RENJU_NUM_ROWS];

    NsTexturedQuad RippleQuad;
    float fRippleScale;
    float fRippleAlpha;
    int iRippleRow;
    int iRippleColumn;

    ID3DXEffect * pEffect;
    IDirect3DVertexBuffer9 * pVertexBuffer;
    IDirect3DVertexDeclaration9 * pVertexDeclaration;
};