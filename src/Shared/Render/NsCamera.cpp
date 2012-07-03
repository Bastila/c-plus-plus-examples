#include "NsCamera.h"

NsCamera::NsCamera(void)
{
	viewOrigin.Set( 0.0f, 0.0f, 0.0f );
	
	viewZoom = 1.0f;

	viewAxes[ EViewAxes::VA_Right ]	.Set( 1.0f, 0.0f, 0.0f );
	viewAxes[ EViewAxes::VA_Up ]	.Set( 0.0f, 1.0f, 0.0f );
	viewAxes[ EViewAxes::VA_LookAt ].Set( 0.0f, 0.0f, 1.0f );

	fovY = ONEFOURTH_PI;
	aspect = 4.0f/3.0f;

	nearZ = 0.1f;
	farZ = 1000.0f;

	_pitch = 0.0f;
}

void NsCamera::Walk(float units)
{
	viewOrigin += viewAxes[ VA_LookAt ] * units;
}

void NsCamera::Strafe(float units)
{
	viewOrigin += viewAxes[ VA_Right ] * units;
}

void NsCamera::Fly(float units)
{
	if(false /*bCameraIsAircraft*/) {
		viewOrigin += viewAxes[ VA_Up ] * units;
	} else {
		viewOrigin.y += units;
	}
}

void NsCamera::Yaw(float angle)
{
	NsMatrix3  mat;
	if(false /*bCameraIsAircraft*/) {
		mat.SetRotationAxis(angle, viewAxes[ VA_Up ]);
	} else {
		mat.SetRotationY(angle);	// Rotate around world up axis (0, 1, 0) for land objects.
	}

	// Rotate Right and LookAt vectors around y-axis.
	viewAxes[ VA_Right ] *= mat;
	viewAxes[ VA_LookAt ] *= mat;
}

void NsCamera::Pitch(float angle)
{
	_pitch += angle;

	const float MaxVerticalAngle = +NsMath::Deg2Rad(80.0f);
	const float MinVerticalAngle = -NsMath::Deg2Rad(80.0f);

	// limit vertical angle
	_pitch = NsMath::Clampf(_pitch, MinVerticalAngle, MaxVerticalAngle);

	NsMatrix3  mat;
	mat.SetRotationAxis(angle, viewAxes[ VA_Right ]);

	// Rotate Up and LookAt vectors around Right vector.
	viewAxes[ VA_Up ] *= mat;
	viewAxes[ VA_LookAt ] *= mat;
}

void NsCamera::Roll(float angle)
{
	if(false /*bCameraIsAircraft*/)
	{
		NsMatrix3  mat;
		mat.SetRotationAxis(angle, viewAxes[ VA_LookAt ]);

		// Rotate Up and LookAt vectors around Right vector.
		viewAxes[ VA_Right ] *= mat;
		viewAxes[ VA_LookAt ] *= mat;
	}
}

void NsCamera::RepairNormals()
{
	// Keep camera's axes orthogonal to each other.
	viewAxes[ VA_LookAt ].NormalizeFast();

	viewAxes[ VA_Up ] = viewAxes[ VA_LookAt ].Cross(viewAxes[ VA_Right ]);
	viewAxes[ VA_Up ].NormalizeFast();

	viewAxes[ VA_Right ] = viewAxes[ VA_Up ].Cross(viewAxes[ VA_LookAt ]);
	viewAxes[ VA_Right ].NormalizeFast();
}

void NsCamera::SetView( const NsVector3& eyePosition, const NsVector3& lookAt,
			const NsVector3& upVector )
{
	viewOrigin = eyePosition;

	viewAxes[ EViewAxes::VA_Right ]	= upVector.Cross( lookAt ).GetNormalized();
	viewAxes[ EViewAxes::VA_Up ]	= upVector;
	viewAxes[ EViewAxes::VA_LookAt ] = lookAt;
}

void NsCamera::SetLens( float inFoV_Y, float inAspectRatio,
					 float inNearZ, float inFarZ, float inZoom )
{
	fovY	= inFoV_Y;
	aspect	= inAspectRatio;

	nearZ	= inNearZ;
	farZ	= inFarZ;

	viewZoom = inZoom;
}

const NsVector3 & NsCamera::GetOrigin() const
{
	return viewOrigin;
}

const NsVector3 & NsCamera::GetLookDirection() const
{
	return viewAxes[ EViewAxes::VA_LookAt ];
}

const NsVector3 & NsCamera::GetRight() const
{
	return viewAxes[ EViewAxes::VA_Right ];
}

const NsVector3 & NsCamera::GetUp() const
{
	return viewAxes[ EViewAxes::VA_Up ];
}