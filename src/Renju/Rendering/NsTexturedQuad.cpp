#include "NsTexturedQuad.h"

IDirect3DDevice9 * NsTexturedQuad::pDevice;
IDirect3DVertexBuffer9 * NsTexturedQuad::pVertexBuffer;
IDirect3DVertexDeclaration9 * NsTexturedQuad::pVertexDeclaration;

NsTexturedQuad::NsTexturedQuad()
{
    pDevice = NsNullPointer;
}

HRESULT NsTexturedQuad::Create(IDirect3DDevice9 * pD3DDevice, const WCHAR * wcpEffectFileName, DWORD dwShaderFlags)
{
    HRESULT hr;

    if(pDevice == NsNullPointer)
    {
        pDevice = pD3DDevice;
        pDevice->AddRef();

        V_RETURN(CreateVertexDeclaration(pD3DDevice));
        V_RETURN(CreateVertexBuffer(pD3DDevice));
    }

    D3DXMatrixIdentity(&World);
    InitializeViewAndProjection(D3DX_PI / 4);

    V_RETURN(D3DXCreateEffectFromFile(pD3DDevice, wcpEffectFileName, NULL, NULL, dwShaderFlags, NULL, &pEffect, NULL));

    D3DXHANDLE hTechnique = NULL;
    V_RETURN(pEffect->FindNextValidTechnique(NULL, &hTechnique));
    V_RETURN(pEffect->SetTechnique(hTechnique));

    return S_OK;
}

void NsTexturedQuad::Destroy()
{
    SAFE_RELEASE(pEffect);
    SAFE_RELEASE(pVertexBuffer);
    SAFE_RELEASE(pVertexDeclaration);
    SAFE_RELEASE(pDevice);
}

void NsTexturedQuad::OnLostDevice()
{
    if(pEffect)
	{
        pEffect->OnLostDevice();
	}
}

HRESULT NsTexturedQuad::OnResetDevice()
{
    HRESULT hr = S_OK;

    if(pEffect)
	{
        V_RETURN(pEffect->OnResetDevice());
	}

    InitializeViewAndProjection(D3DX_PI / 4);

    return S_OK;
}

HRESULT NsTexturedQuad::CreateVertexDeclaration(IDirect3DDevice9* pD3DDevice)
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

HRESULT NsTexturedQuad::CreateVertexBuffer(IDirect3DDevice9 * pD3DDevice)
{
    HRESULT hr;

    NsQuadVertex corners[] =
    {
        NsQuadVertex(D3DXVECTOR3(-0.5f, -0.5f, 0), D3DXVECTOR3(0, 0, 1), D3DXVECTOR2(0.0f, 0.0f),
                    D3DCOLOR_ARGB(255, 255, 255, 255)),
        NsQuadVertex(D3DXVECTOR3(0.5f, -0.5f, 0), D3DXVECTOR3(0, 0, 1), D3DXVECTOR2(1.0f, 0.0f),
                    D3DCOLOR_ARGB(255, 255, 255, 255)),
        NsQuadVertex(D3DXVECTOR3(0.5f, 0.5f, 0), D3DXVECTOR3(0, 0, 1), D3DXVECTOR2(1.0f, 1.0f),
                    D3DCOLOR_ARGB(255, 255, 255, 255)),
        NsQuadVertex(D3DXVECTOR3(-0.5f, 0.5f, 0), D3DXVECTOR3(0, 0, 1), D3DXVECTOR2(0.0f, 1.0f),
                    D3DCOLOR_ARGB(255, 255, 255, 255))
    };

    V_RETURN(pD3DDevice->CreateVertexBuffer(sizeof(NsQuadVertex) * 4,
                                              D3DUSAGE_WRITEONLY,
                                              0,
                                              D3DPOOL_MANAGED,
                                              &pVertexBuffer,
                                              NULL));

    NsQuadVertex * pVertex = NsNullPointer;
    V_RETURN(pVertexBuffer->Lock(0, 0, (void**)&pVertex, 0));
    CopyMemory(pVertex, corners, sizeof(corners));
    pVertexBuffer->Unlock();

    return S_OK;
}

HRESULT NsTexturedQuad::LoadTexture(D3DXHANDLE effectParameterHandle, const WCHAR* wcpFileName)
{
    HRESULT hr = S_OK;

    IDirect3DTexture9 * pTexture = NsNullPointer;
    V_RETURN(D3DXCreateTextureFromFile(pDevice, wcpFileName, &pTexture));

    pEffect->SetTexture(effectParameterHandle, pTexture);

    SAFE_RELEASE(pTexture);

    return S_OK;
}

void NsTexturedQuad::Render()
{
    HRESULT hr;

    V(pEffect->SetMatrix("World", &World));
    V(pEffect->SetMatrix("View", &View));
    V(pEffect->SetMatrix("Projection", &Projection));

    // render the board
    UINT NumPasses;
    V(pEffect->Begin(&NumPasses, 0));
    for(UINT iPass = 0; iPass < NumPasses; ++iPass)
    {
        V(pEffect->BeginPass(iPass));
        DrawPrimitives();
        V(pEffect->EndPass());
    }
    V(pEffect->End());
}

void NsTexturedQuad::DrawPrimitives()
{
    HRESULT hr;

    V(pDevice->SetVertexDeclaration(pVertexDeclaration));
    V(pDevice->SetStreamSource(0, pVertexBuffer, 0, sizeof(NsQuadVertex)));
    V(pDevice->DrawPrimitive(D3DPT_TRIANGLEFAN, 0, 2));
}

//--------------------------------------------------------------------------------------
// Moves the world-space XY plane into screen-space for pixel-perfect perspective
//--------------------------------------------------------------------------------------
void NsTexturedQuad::InitializeViewAndProjection(float fFieldOfViewY, float fScreenDepth, float fNearClip)
{
    // get back buffer description and determine aspect ratio
    const D3DSURFACE_DESC* pBackBufferSurfaceDesc = DXUTGetD3D9BackBufferSurfaceDesc();
    float fWidth = (float)pBackBufferSurfaceDesc->Width;
    float fHeight = (float)pBackBufferSurfaceDesc->Height;
    float fAspectRatio = fWidth / fHeight;

    // determine the correct Z depth to completely fill the frustum
    float fYScale = 1 / tanf(fFieldOfViewY / 2);
    float fZ = fYScale * fHeight / 2;

    // calculate perspective projection
    D3DXMatrixPerspectiveFovLH(&Projection, fFieldOfViewY, fAspectRatio, fNearClip, fZ + fScreenDepth);

    // initialize the view matrix as a rotation and translation from "screen-coordinates"
    // in world space (the XY plane from the perspective of Z+) to a plane that's centered
    // along Z+
    D3DXMatrixIdentity(&View);
    View._22 = -1;
    View._33 = -1;
    View._41 = -(fWidth / 2);
    View._42 = (fHeight / 2);
    View._43 = fZ;
}