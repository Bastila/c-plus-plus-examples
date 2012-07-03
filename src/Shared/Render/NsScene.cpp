#include "NsScene.h"

NsSceneObject::NsSceneObject(void)
{
	this->_position = NsVector3::CreateOrigin();
	this->_rotation = NsMatrix3::CreateIdentity();
	this->_scale = NsVector3::CreateUnit();
}

NsSceneObject::~NsSceneObject(void)
{
}

NsMatrix4 NsSceneObject::GetWorldTransform() const
{
	return NsMatrix4::CreateScale(_scale)*_rotation.ToMatrix4().SetTranslation(_position);
}

NsQuad3D::NsQuad3D()
{
	bUseASCIIShader = false;
}

NsQuad3D::~NsQuad3D()
{
}

NsQuad3D & NsQuad3D::operator=(const NsQuad3D & value)
{
	_position = value._position;
	_rotation = value._rotation;
	_scale = value._scale;
	_ID = value._ID;
	fWidth = value.fWidth;
	fHeight = value.fHeight;
	v3Normal = value.v3Normal;
	shaderID = value.shaderID;
	textureID = value.textureID;
	bUseASCIIShader = value.bUseASCIIShader;

	return *this;
}

NsScene::NsScene()
{
	_IDCounter = 1;

	_editAxis = NsVector3(1, 0, 0);
}

NsScene::~NsScene()
{
}

void NsScene::CreateQuad3D(NsVector3 position, float fWidth, float fHeight, unsigned int textureID, unsigned int shaderID, bool bIsWebView, bool bIsWebCameraView)
{
	NsQuad3D newQuad;
	newQuad._position = position;
	newQuad.fHeight = fHeight;
	newQuad.fWidth= fWidth;
	newQuad.textureID = textureID;
	newQuad.shaderID = shaderID;
	newQuad._ID = _IDCounter++;

	_quads.push_back(newQuad);
}

void NsScene::Update(NsCamera * pCamera, const std::list<WPARAM> pressedKeys, const NsMouseState & mouseState)
{
	if(pressedKeys.size() != 0)
	{
		std::list<WPARAM>::const_iterator cit = pressedKeys.begin();
		for(; cit != pressedKeys.end(); ++cit)
		{
			switch(*cit)
			{
				case CURRENT_AXIS_IS_Z:
				{
					_editAxis = NsVector3(1, 0, 0);
				}
				break;
				case CURRENT_AXIS_IS_Y:
				{
					_editAxis = NsVector3(0, 1, 0);
				}
				break;
				case CURRENT_AXIS_IS_X:
				{
					_editAxis = NsVector3(0, 0, 1);
				}
				break;
				case TOOGLE_CONSOLE:
				{
					//NsConsole::Instance()->Toogle();
				}
				break;
				case 'u':
				case 'U':
				{
					std::list<NsQuad3D>::iterator itQuads = _quads.begin();

					for(; itQuads != _quads.end(); ++itQuads)
					{
						(*itQuads).bUseASCIIShader = true;
					}
				}
				break;
			}
		}
	}
}