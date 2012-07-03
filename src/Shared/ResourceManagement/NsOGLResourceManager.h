#pragma once
#include "../../3rd party/GLEW/GL/glew.h"
#include "../../3rd party/SOIL/SOIL.h"
#include "../Common/NsSingleton.hpp"
#include "../Utils/NsConsole.h"
#include "NsResourceManager.hpp"
#include <string>
#include <fstream>
#include <streambuf>
#include <map>

typedef struct _TgaHeader
{
	unsigned char		id_length, colormap_type, image_type;
	unsigned short		colormap_index, colormap_length;
	unsigned char		colormap_size;
	unsigned short		x_origin, y_origin, width, height;
	unsigned char		pixel_size, attributes;
} TgaHeader;

class NsOGLResourceManager : public NsResourceManager, public NsSingleton<NsOGLResourceManager>
{
	friend class NsSingleton<NsOGLResourceManager>;

public:
	GLuint GetResourceID(const char * resourceName);
	GLuint LoadContentTexture2D(const char * texturePath, int * width, int * height);
	GLuint LoadContentTGATexture(const char * texturePath);
	GLuint LoadASCIIFragmentAndVertexShader(const char * vertexShaderPath, const char * fragmentShaderPath);
	std::string LoadText(const char * textPath);

	std::string colorMapName;

protected:
	NsOGLResourceManager();
	virtual ~NsOGLResourceManager();

	std::map<std::string, short int> _resources;
};

