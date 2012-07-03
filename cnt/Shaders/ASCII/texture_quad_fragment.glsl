#version 130

uniform sampler2D colorMap;
uniform sampler2D asciiMap;

out vec4 vFragColor;
smooth in vec2 vVaryingTexCoords;

void main(void)
{
	int letterNumber = 2;
	vec2 gridSize = vec2(128, 64);

	// calculate the current grid cell index
	vec2 gridCellSize = vec2(1.0, 1.0) / gridSize;
	vec2 gridCellIndex = vVaryingTexCoords / gridCellSize;
	gridCellIndex = floor(gridCellIndex);
	
	// calculate average color, 4 values from a grid cell a sampled
	vec4 averageColor = texture(colorMap, vec2((gridCellIndex.s + 0.25) * gridCellSize.s, (gridCellIndex.t + 0.25) * gridCellSize.t));
	averageColor += texture(colorMap, vec2((gridCellIndex.s + 0.75) * gridCellSize.s, (gridCellIndex.t + 0.25) * gridCellSize.t));
	averageColor += texture(colorMap, vec2((gridCellIndex.s + 0.25) * gridCellSize.s, (gridCellIndex.t + 0.75) * gridCellSize.t));
	averageColor += texture(colorMap, vec2((gridCellIndex.s + 0.75) * gridCellSize.s, (gridCellIndex.t + 0.75) * gridCellSize.t));
	averageColor /= 4;

	// calculate average luminosity of an average color
	float averageLum = 0.2126 * averageColor.r + 0.7152 * averageColor.g + 0.0722 * averageColor.b;

	// the letter selection depends on which luminosity range the "averageLum" belongs to
	// eg: if there are only 2 letters, the first letter luminosity range is [0;0.5] and the second letter luminosity range is (0.5;1], the luminosity range delta size is 0.5
	
	// calculate the luminosity range delta size
	float lumRangeDelta = 1.0 / float(letterNumber);

	// calculate offset for the chosen letter
	float letterIndex = floor(averageLum/lumRangeDelta);

	// get the relevating pixel of the character in the font map
	vec2 gridCellOffset = mod(vVaryingTexCoords, gridCellSize);
	vec2 relativeASCIIOffset = gridCellOffset / vec2(letterNumber, 1) / gridCellSize;
	vec2 relativeASCIICoords = relativeASCIIOffset + vec2(letterIndex, 0) / vec2(letterNumber, 1);

	// peform some color improvement (just make output brighter)
	vec4 improvedColor = averageColor / (max(averageColor.r, max(averageColor.g, averageColor.b)));

	vFragColor = improvedColor * texture(asciiMap, relativeASCIICoords.st);
}