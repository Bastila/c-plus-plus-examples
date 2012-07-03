#pragma once
#include "../../Shared/Common/NsIncludes.h"
#include "../../3rd party/DXUT/Core/dxut.h"
#include "../../3rd party/DXUT/Optional/SDKmisc.h"

struct NsQuadVertex
{
    D3DXVECTOR3 Position;
    D3DXVECTOR3 Normal;
    D3DXVECTOR2 TexCoord;
    D3DCOLOR Color;

	NsQuadVertex()
	{
		ZeroMemory(this, sizeof(NsQuadVertex));
	}

	NsQuadVertex(const D3DXVECTOR3 & crPosition, const D3DXVECTOR3 & crNormal, const D3DXVECTOR2 & crTexCoord, const D3DCOLOR & crColor)
	{
		Position = crPosition;
		Normal = crNormal;
		TexCoord = crTexCoord;
		Color = crColor;
	}
};

class NsTexturedQuad
{
public:
	NsTexturedQuad();

    HRESULT Create(IDirect3DDevice9 * pD3DDevice, const WCHAR * wcpEffectFileName, DWORD dwShaderFlags = 0);
    void Destroy();

    void OnLostDevice();
    HRESULT OnResetDevice();

    HRESULT LoadTexture(D3DXHANDLE effectParameterHandle, const WCHAR * wcpFileName);

    void Render();
    void DrawPrimitives();

    ID3DXEffect * pEffect;
    D3DXMATRIXA16 World;
    D3DXMATRIXA16 View;
    D3DXMATRIXA16 Projection;

private:
    static HRESULT CreateVertexDeclaration(IDirect3DDevice9 * pD3DDevice);
    static HRESULT CreateVertexBuffer(IDirect3DDevice9 * pD3DDevice);

    void InitializeViewAndProjection(float fFieldOfViewY, float fScreenDepth = 10000.f, float fNearClip = 0.1f);

    static IDirect3DDevice9 * pDevice;
    static IDirect3DVertexBuffer9 * pVertexBuffer;
    static IDirect3DVertexDeclaration9 * pVertexDeclaration;
};
