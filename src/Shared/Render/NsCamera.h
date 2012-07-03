#pragma once
#include "../Render/NsCameraController.h"
#include "../Math/NsMath.hpp"
#include <vector>

#include "../Math/NsVector3.hpp"
#include "../Math/NsVector4.hpp"
#include "../Math/NsMatrix3.hpp"
#include "../Math/NsMatrix4.hpp"

enum EVectorComponent
{
	Vector_X = 0,
	Vector_Y,
	Vector_Z,
	Vector_W,
};

enum EViewAxes
{
	VA_Right	= Vector_X,
	VA_Up		= Vector_Y,	// 'upward'
	VA_LookAt	= Vector_Z,	// Look direction vector ('forward').
};

class NsCamera
{
friend class NsCameraController;

public:
	NsCamera();

	void Walk(float units); // Convenience function to move backward or forward in camera space.
	void Strafe(float units); // Convenience function to move to the right or left in camera space.
	void Fly(float units);  // Convenience function to move up or down in camera space.

	void Yaw(float angle);  // Convenience function to rotate around the vertical (y-axis) of the camera. NOTE: Angle in radians.
	void Pitch(float angle); // Convenience function to rotate around the x-axis of the camera. NOTE: Angle in radians.
	void Roll(float angle); // Convenience function to rotate around the look direction vector of the camera. NOTE: Angle in radians.

	void RepairNormals(); // Orthonormalize

protected:
	float _pitch;
	NsCameraController * _pCameraController;

public:
	NsVector3 viewOrigin;		// Eye position.
	float viewZoom;		// NsCamera zoom.
	NsVector3 viewAxes[3];	// X(right), Y(up) and Z(lookAt) vectors, must be orthonormal (they form the camera coordinate system).
	float fovY, aspect;	// Vertical field of view angle, in radians, and aspect ratio.
	float nearZ, farZ;	// Near and far clipping planes.

public:
	void SetView( const NsVector3& eyePosition, const NsVector3& lookAt,
 	const NsVector3& upVector = NsVector3( 0.0f, 1.0f, 0.0f ) );

	void SetLens( float inFoV_Y, float inAspectRatio,
 	float inNearZ, float inFarZ, float inZoom = 1.0f );

	// These functions are provided for convenience.

	const NsVector3 & GetOrigin() const;
	const NsVector3 & GetLookDirection() const;
	const NsVector3 & GetRight() const;
	const NsVector3 & GetUp() const;
};