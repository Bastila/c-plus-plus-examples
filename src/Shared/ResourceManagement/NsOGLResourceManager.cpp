#include "NsOGLResourceManager.h"

NsOGLResourceManager::NsOGLResourceManager(void)
{
	TiXmlDocument configDocument("NsTestbed.config");

	if(configDocument.LoadFile())
	{
		TiXmlElement * pRootNode = configDocument.RootElement();
		colorMapName = std::string(pRootNode->FirstChild("TestImage")->FirstChild()->Value());
	}
}


NsOGLResourceManager::~NsOGLResourceManager(void)
{
}

GLuint NsOGLResourceManager::GetResourceID(const char * resourceName)
{
	return _resources[std::string(resourceName)];
}

std::string NsOGLResourceManager::LoadText(const char * textPath)
{
	return std::string((std::istreambuf_iterator<char>(std::ifstream(textPath))), std::istreambuf_iterator<char>());
}

GLuint NsOGLResourceManager::LoadContentTexture2D(const char * texturePath, int * width, int * height)
{
	unsigned int resourceID = SOIL_load_OGL_texture((NsText::ToNarrowString(GetAbsoluteContentFolderPath()) + std::string(texturePath)).c_str(),
		SOIL_LOAD_AUTO,
		SOIL_CREATE_NEW_ID,
		SOIL_FLAG_MIPMAPS | SOIL_FLAG_INVERT_Y | SOIL_FLAG_NTSC_SAFE_RGB | SOIL_FLAG_COMPRESS_TO_DXT,
		width, height);

	if(resourceID > 0)
	{
		_resources[texturePath] = resourceID;
	}

	return resourceID;
}

GLuint NsOGLResourceManager::LoadASCIIFragmentAndVertexShader(const char * vertexShaderPath, const char * fragmentShaderPath)
{
	std::string fragmentShaderSource = LoadText((NsText::ToNarrowString(GetAbsoluteContentFolderPath()) + std::string(fragmentShaderPath)).c_str());
	std::string vertexShaderSource = LoadText((NsText::ToNarrowString(GetAbsoluteContentFolderPath()) + std::string(vertexShaderPath)).c_str());

	GLuint hFragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	GLuint hVertexShader = glCreateShader(GL_VERTEX_SHADER);

	const char *pcFragmentShaderSource = fragmentShaderSource.c_str();
	glShaderSource(hFragmentShader, 1, &pcFragmentShaderSource, 0);
	const char *pcVertexShaderSource = vertexShaderSource.c_str();
	glShaderSource(hVertexShader, 1, &pcVertexShaderSource, 0);

	glCompileShader(hFragmentShader);
	glCompileShader(hVertexShader);

	GLint status;
	glGetShaderiv(hVertexShader, GL_COMPILE_STATUS, &status);
	if (status == GL_FALSE)
	{
		GLint infoLogLength;
		glGetShaderiv(hVertexShader, GL_INFO_LOG_LENGTH, &infoLogLength);

		GLchar *strInfoLog = new GLchar[infoLogLength + 1];
		glGetShaderInfoLog(hVertexShader, infoLogLength, NULL, strInfoLog);

		glDeleteShader(hVertexShader);

		NsConsole::Instance()->AddMessage(std::string("Failed to compile vertex shader: ") + std::string(strInfoLog));
		delete[] strInfoLog;

		return 0;
	}

	glGetShaderiv(hFragmentShader, GL_COMPILE_STATUS, &status);
	if (status == GL_FALSE)
	{
		GLint infoLogLength;
		glGetShaderiv(hFragmentShader, GL_INFO_LOG_LENGTH, &infoLogLength);

		GLchar *strInfoLog = new GLchar[infoLogLength + 1];
		glGetShaderInfoLog(hFragmentShader, infoLogLength, NULL, strInfoLog);

		glDeleteShader(hFragmentShader);

		NsConsole::Instance()->AddMessage(std::string("Failed to compile fragment shader: ") + std::string(strInfoLog));
		delete[] strInfoLog;

		return 0;
	}

	GLuint hProgram = glCreateProgram();
	glAttachShader(hProgram, hFragmentShader);
	glAttachShader(hProgram, hVertexShader);

	glBindAttribLocation(hProgram, 0, "vVertex");
	glBindAttribLocation(hProgram, 8, "vTexCoords");

	glLinkProgram(hProgram);

	glDeleteShader(hVertexShader);
	glDeleteShader(hFragmentShader);

	glGetProgramiv(hProgram, GL_LINK_STATUS, &status);
	if(status == GL_FALSE)
	{
		char infoLog[1024];
		glGetProgramInfoLog(hProgram, 1024, NULL, infoLog);
		glDeleteProgram(hProgram);

		NsConsole::Instance()->AddMessage(std::string("Failed to link shader program: ") + std::string(infoLog));
	}

	return hProgram;
}

static int LoadTGAFile( const char* name, int& width, int& height, int& bpp, byte** data )
{
	if ( name == NULL || data == NULL )
		return 0;

	FILE* file = fopen( name, "rb" );
	if ( NULL == file )
		return 0;

	int			i, columns, rows, row_inc, row, col;
	unsigned char		*buf_p, *buffer, *pixbuf, *targa_rgba;
	int			length, samples, readpixelcount, pixelcount;
	unsigned char		palette[256][4], red, green, blue, alpha;
	bool		compressed;
	TgaHeader	targa_header;

	fseek( file, 0, SEEK_END );
	length = ftell( file );
	fseek( file, 0, SEEK_SET );

	if ( 0 >= length )
		return 0;
	buffer = (unsigned char *)malloc( length );
	if ( buffer == NULL )
		return 0;

	fread( buffer, 1, length, file );
	fclose( file );

	if ( !buffer )
		return 0;

	buf_p = buffer;
	targa_header.id_length     = *buf_p++;
	targa_header.colormap_type = *buf_p++;
	targa_header.image_type    = *buf_p++;

	targa_header.colormap_index = buf_p[0] + buf_p[1] * 256;
	buf_p += 2;
	targa_header.colormap_length = buf_p[0] + buf_p[1] * 256;
	buf_p += 2;
	targa_header.colormap_size = *buf_p++;
	targa_header.x_origin = ( *((short *)buf_p) );
	buf_p += 2;
	targa_header.y_origin = ( *((short *)buf_p) );
	buf_p += 2;
	targa_header.width    = ( *((short *)buf_p) );
	buf_p += 2;
	targa_header.height   = ( *((short *)buf_p) );
	buf_p += 2;
	targa_header.pixel_size = *buf_p++;
	targa_header.attributes = *buf_p++;
	if ( targa_header.id_length != 0 )
		buf_p += targa_header.id_length;

	bpp    = targa_header.pixel_size;
	height = targa_header.height;
	width  = targa_header.width;

	if ( targa_header.image_type == 1 || targa_header.image_type == 9 )
	{
		if ( targa_header.pixel_size != 8 )
		{
			free( buffer );
			return 0;
		}
		if ( targa_header.colormap_length != 256 )
		{
			free( buffer );
			return 0;
		}
		if ( targa_header.colormap_index )
		{
			free( buffer );
			return 0;
		}
		if ( targa_header.colormap_size == 24 )
		{
			for ( i=0; i<targa_header.colormap_length; i++ )
			{
				palette[i][0] = *buf_p++;
				palette[i][1] = *buf_p++;
				palette[i][2] = *buf_p++;
				palette[i][3] = 255;
			}
		}
		else if ( targa_header.colormap_size == 32 )
		{
			for ( i=0; i<targa_header.colormap_length; i++ )
			{
				palette[i][0] = *buf_p++;
				palette[i][1] = *buf_p++;
				palette[i][2] = *buf_p++;
				palette[i][3] = *buf_p++;
			}
		}
		else
		{
			free( buffer );
			return 0;
		}
	}
	else if ( targa_header.image_type == 2 || targa_header.image_type == 10 )
	{
		if ( targa_header.pixel_size != 32 && targa_header.pixel_size != 24 )
		{
			free( buffer );
			return 0;
		}
	}
	else if ( targa_header.image_type == 3 || targa_header.image_type == 11 )
	{
		if ( targa_header.pixel_size != 8 )
		{
			free( buffer );
			return 0;
		}
	}

	columns = targa_header.width;
	width   = columns;

	rows   = targa_header.height;
	height = rows;

	targa_rgba  = (unsigned char *)malloc( columns * rows * 4 );
	unsigned char* pData = targa_rgba;
	if ( pData == NULL )
	{
		free( buffer );
		return 0;
	}

	if ( targa_header.attributes & 0x20 )
	{
		pixbuf = targa_rgba;
		row_inc = 0;
	}
	else 
	{
		pixbuf = targa_rgba + (rows - 1) * columns * 4;
		row_inc = -columns * 4 * 2;
	}

	compressed = ( targa_header.image_type == 9 || targa_header.image_type == 10 || targa_header.image_type == 11 );
	for ( row = col = 0, samples = 4; row < rows; )
	{
		pixelcount = 0x10000;
		readpixelcount = 0x10000;

		if ( compressed ) 
		{
			pixelcount = *buf_p++;
			if ( pixelcount & 0x80 )
				readpixelcount = 1;
			pixelcount = 1 + (pixelcount & 0x7f);
		}

		while( pixelcount-- && (row < rows) ) 
		{
			if ( readpixelcount-- > 0 ) 
			{
				switch( targa_header.image_type ) 
				{
				case 1:
				case 9:
					blue  = *buf_p++;
					red   = palette[blue][0];
					green = palette[blue][1];
					alpha = palette[blue][3];
					blue  = palette[blue][2];
					if ( alpha != 255 )
						samples = 4;
					break;
				case 2:
				case 10:
					samples = 4;
					blue  = *buf_p++;
					green = *buf_p++;
					red   = *buf_p++;
					alpha = 255;
					if ( targa_header.pixel_size == 32 )
						alpha = *buf_p++;
					break;
				case 3:
				case 11:
					blue  = green = red = *buf_p++;
					alpha = 255;
					break;
				}
			}

			*pixbuf++ = red;
			*pixbuf++ = green;
			*pixbuf++ = blue;
			*pixbuf++ = alpha;
			if ( ++col == columns ) 
			{
				row++;
				col = 0;
				pixbuf += row_inc;
			}
		}
	}

	bpp = 32;

	free( buffer );

	*data = pData;

	return 1;
}

GLuint NsOGLResourceManager::LoadContentTGATexture(const char * texturePath)
{
	GLuint textureID;
	int w, h, bpp;
	unsigned char * data = NULL;

	if ( !LoadTGAFile( (NsText::ToNarrowString(GetAbsoluteContentFolderPath()) + std::string(texturePath)).c_str(), w, h, bpp, &data ) )
		return 0;

	glGenTextures( 1, &textureID );

	glBindTexture( GL_TEXTURE_2D, textureID );

	glTexParameteri	( GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT );
	glTexParameteri	( GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT );
	glTexParameteri	( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );
	glTexParameteri	( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
	glPixelStorei	( GL_UNPACK_ALIGNMENT, 1 );

	glTexImage2D( GL_TEXTURE_2D, 0, GL_RGBA8, w, h, 0, GL_RGBA, GL_UNSIGNED_BYTE, data );

	glBindTexture( GL_TEXTURE_2D, 0 );

	free( data );

	return textureID;
}