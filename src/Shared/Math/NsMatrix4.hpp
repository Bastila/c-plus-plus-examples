#pragma once
#include "../Math/NsMath.hpp"
#include "../Math/NsVector3.hpp"
#include "../Math/NsVector4.hpp"
#include "../Common/NsMemory.hpp"

class NsMatrix4
{
public:
					NsMatrix4( void );
					
					explicit NsMatrix4( const NsVector4 &x, const NsVector4 &y, const NsVector4 &z, const NsVector4 &w );
					
					explicit NsMatrix4(const float xx, const float xy, const float xz, const float xw,
									const float yx, const float yy, const float yz, const float yw,
									const float zx, const float zy, const float zz, const float zw,
									const float wx, const float wy, const float wz, const float ww );


					explicit NsMatrix4( const float src[ 4 ][ 4 ] );
					explicit NsMatrix4( const float * m );

	const NsVector4 &	operator []( int index ) const;
	NsVector4 &			operator []( int index );
	NsMatrix4			operator *( const float a ) const;
	NsVector4			operator *( const NsVector4 &vec ) const;
	NsVector3			operator *( const NsVector3 &vec ) const;
	NsMatrix4			operator *( const NsMatrix4 &a ) const;
	NsMatrix4			operator +( const NsMatrix4 &a ) const;
	NsMatrix4			operator -( const NsMatrix4 &a ) const;
	NsMatrix4 &		operator *=( const float a );
	NsMatrix4 &		operator *=( const NsMatrix4 &a );
	NsMatrix4 &		operator +=( const NsMatrix4 &a );
	NsMatrix4 &		operator -=( const NsMatrix4 &a );

	friend NsMatrix4	operator * ( const float a, const NsMatrix4 &mat );
	friend NsVector4	operator * ( const NsVector4 &vec, const NsMatrix4 &mat );
	friend NsVector3	operator * ( const NsVector3 &vec, const NsMatrix4 &mat );
	friend NsVector4 &	operator *=( NsVector4 &vec, const NsMatrix4 &mat );
	friend NsVector3 &	operator *=( NsVector3 &vec, const NsMatrix4 &mat );

	bool			Compare( const NsMatrix4 &a ) const;						// exact compare, no epsilon
	bool			Compare( const NsMatrix4 &a, const float epsilon ) const;	// compare with epsilon
	bool			operator==( const NsMatrix4 &a ) const;					// exact compare, no epsilon
	bool			operator!=( const NsMatrix4 &a ) const;					// exact compare, no epsilon

	void			SetZero( void );
	bool			IsIdentity( const float epsilon = 1e-6 ) const;
	bool			IsSymmetric( const float epsilon = 1e-6 ) const;
	bool			IsDiagonal( const float epsilon = 1e-6 ) const;
	bool			IsRotated( void ) const;

	void			ProjectVector( const NsVector4 &src, NsVector4 &dst ) const;
	void			UnprojectVector( const NsVector4 &src, NsVector4 &dst ) const;

	float			Trace( void ) const;		// Returns the sum of diagonal components.
	float			Determinant( void ) const;
	NsMatrix4			Transpose( void ) const;	// returns transpose
	NsMatrix4 &		TransposeSelf( void );
	NsMatrix4			Inverse( void ) const;		// returns the inverse ( m * m.Inverse() = identity )
	bool			InverseSelf( void );		// returns false if determinant is zero
	NsMatrix4			InverseFast( void ) const;	// returns the inverse ( m * m.Inverse() = identity )
	bool			InverseFastSelf( void );	// returns false if determinant is zero
	NsMatrix4			TransposeMultiply( const NsMatrix4 &b ) const;
	NsMatrix4			GetAbsolute() const;		// Returns a matrix with non-negative values.

	void			SetRotationInDegrees( const NsVector3& rotation );
	void			SetRotationInRadians( const NsVector3& rotation );
	NsVector3			GetRotationInDegrees() const;

			// Builds a left-handed, look-at matrix.
	void	BuildViewLH( const NsVector3& eyePosition, const NsVector3& target, const NsVector3& upVector = NsVector3::vec3_unit_y );

			// Builds a left-handed perspective projection matrix based on a field of view.
	void	BuildPerspectiveLH( float FOVy, float Aspect, float NearZ, float FarZ );

			// Builds a left-handed orthographic projection matrix.
	void	BuildOrthoLH( float Width, float Height, float NearZ, float FarZ );

					// Transforms a point.
	NsVector3			TransformVector( const NsVector3& point ) const;

					// Note: assumes that the matrix is composed from translation and rotation (and, maybe, uniform scaling).
	NsVector3			InverseTransformVector( const NsVector3& point ) const;

					// Transforms a normal ( direction ).
	NsVector3			TransformNormal( const NsVector3& normal ) const;

					// Note: assumes that the matrix is composed from translation and rotation (and, maybe, uniform scaling).
	NsVector3			InverseTransformNormal( const NsVector3& normal ) const;

	NsVector4			GetTransformedPlane( const NsVector4& plane ) const;

					// The same as TransformNormal(), provided for convenience.
	void			RotateVector( NsVector3 & /* in out */ v ) const { v = TransformNormal( v ); }

	int				GetDimension( void ) const;
	bool			IsAffine() const;	// An affine matrix has no projective coefficients.


	void			SetRow( int iRow, const NsVector4& v );
	const float *	ToFloatPtr( void ) const;
	float *			ToFloatPtr( void );
	const char *	ToString( int precision = 2 ) const;

	NsMatrix4 &		SetTranslation( const NsVector3& v );
	const NsVector3 &	GetTranslation() const;
	NsVector3 &			GetTranslation();

					// this function is provided for convenience
	void			SetOrigin( const NsVector3& newOrigin ) { this->SetTranslation( newOrigin ); }

	void			SetScale( const NsVector3& scaleFactor );	// Sets the scale part of the matrix.
	void			SetDiagonal( const NsVector3& v );

	void	SetRotationX( float angle );						// NOTE: Angle in radians.
	void	SetRotationY( float angle );						// NOTE: Angle in radians.
	void	SetRotationZ( float angle );						// NOTE: Angle in radians.
	
	void	SetRotationAxis( float angle, const NsVector3& axis );	// NOTE: Angle in radians.

	// Builds a matrix than rotates from one vector to another vector.
	void	SetRotationAxis( float angle, const NsVector3& vFrom, const NsVector3& vTo );	// NOTE: Angle in radians.

	NsVector3	HomogeneousMultiply( const NsVector3& v, float w ) const;

public:
	static NsMatrix4	CreateScale( float uniformScaleFactor );
	static NsMatrix4	CreateScale( const NsVector3& scaleFactor );
	static NsMatrix4	CreateTranslation( const NsVector3& translation );
	static NsMatrix4 Identity();

public:
	static const NsMatrix4	mat4_zero;
	static const NsMatrix4	mat4_identity;

	// takes 2D clipspace {-1,1} to {0,1} and inverts Y.
	static const NsMatrix4	mat4_clip_space_to_image_space;

	// takes 2D imagespace {0,1} to {-1,1} and inverts Y.
	static const NsMatrix4	mat4_image_space_to_clip_space;

private:
	NsVector4		mRows[ 4 ];
};

inline NsMatrix4::NsMatrix4( void ) {
}

inline NsMatrix4::NsMatrix4( const NsVector4 &x, const NsVector4 &y, const NsVector4 &z, const NsVector4 &w )
{
	mRows[ 0 ] = x;
	mRows[ 1 ] = y;
	mRows[ 2 ] = z;
	mRows[ 3 ] = w;
}

inline NsMatrix4::NsMatrix4( const float xx, const float xy, const float xz, const float xw,
							const float yx, const float yy, const float yz, const float yw,
							const float zx, const float zy, const float zz, const float zw,
							const float wx, const float wy, const float wz, const float ww )
{
	mRows[0][0] = xx; mRows[0][1] = xy; mRows[0][2] = xz; mRows[0][3] = xw;
	mRows[1][0] = yx; mRows[1][1] = yy; mRows[1][2] = yz; mRows[1][3] = yw;
	mRows[2][0] = zx; mRows[2][1] = zy; mRows[2][2] = zz; mRows[2][3] = zw;
	mRows[3][0] = wx; mRows[3][1] = wy; mRows[3][2] = wz; mRows[3][3] = ww;
}



inline NsMatrix4::NsMatrix4( const float src[ 4 ][ 4 ] ) {
	NsMemory::Copy( mRows, src, 4 * 4 * sizeof( float ) );
}

inline NsMatrix4::NsMatrix4( const float * m )
{
	mRows[0][0] = m[ 0]; mRows[0][1] = m[ 4]; mRows[0][2] = m[ 8]; mRows[0][3] = m[12];
	mRows[1][0] = m[ 1]; mRows[1][1] = m[ 5]; mRows[1][2] = m[ 9]; mRows[1][3] = m[13];
	mRows[2][0] = m[ 2]; mRows[2][1] = m[ 6]; mRows[2][2] = m[10]; mRows[2][3] = m[14];
	mRows[3][0] = m[ 3]; mRows[3][1] = m[ 7]; mRows[3][2] = m[11]; mRows[3][3] = m[15];
}

inline const NsVector4 &NsMatrix4::operator[]( int index ) const {
	//Assert( ( index >= 0 ) && ( index < 4 ) );
	return mRows[ index ];
}

inline NsVector4 &NsMatrix4::operator[]( int index ) {
	//Assert( ( index >= 0 ) && ( index < 4 ) );
	return mRows[ index ];
}

inline NsMatrix4 NsMatrix4::operator*( const float a ) const {
	return NsMatrix4(
		mRows[0].x * a, mRows[0].y * a, mRows[0].z * a, mRows[0].w * a,
		mRows[1].x * a, mRows[1].y * a, mRows[1].z * a, mRows[1].w * a,
		mRows[2].x * a, mRows[2].y * a, mRows[2].z * a, mRows[2].w * a,
		mRows[3].x * a, mRows[3].y * a, mRows[3].z * a, mRows[3].w * a );
}

inline NsVector4 NsMatrix4::operator*( const NsVector4 &vec ) const
{
	return NsVector4(
		mRows[ 0 ].x * vec.x + mRows[ 0 ].y * vec.y + mRows[ 0 ].z * vec.z + mRows[ 0 ].w * vec.w,
		mRows[ 1 ].x * vec.x + mRows[ 1 ].y * vec.y + mRows[ 1 ].z * vec.z + mRows[ 1 ].w * vec.w,
		mRows[ 2 ].x * vec.x + mRows[ 2 ].y * vec.y + mRows[ 2 ].z * vec.z + mRows[ 2 ].w * vec.w,
		mRows[ 3 ].x * vec.x + mRows[ 3 ].y * vec.y + mRows[ 3 ].z * vec.z + mRows[ 3 ].w * vec.w );
}

inline NsVector3 NsMatrix4::operator*( const NsVector3 &vec ) const
{
	float s = mRows[ 3 ].x * vec.x + mRows[ 3 ].y * vec.y + mRows[ 3 ].z * vec.z + mRows[ 3 ].w;
	if ( s == 0.0f ) {
		return NsVector3( 0.0f, 0.0f, 0.0f );
	}
	if ( s == 1.0f ) {
		return NsVector3(
			mRows[ 0 ].x * vec.x + mRows[ 0 ].y * vec.y + mRows[ 0 ].z * vec.z + mRows[ 0 ].w,
			mRows[ 1 ].x * vec.x + mRows[ 1 ].y * vec.y + mRows[ 1 ].z * vec.z + mRows[ 1 ].w,
			mRows[ 2 ].x * vec.x + mRows[ 2 ].y * vec.y + mRows[ 2 ].z * vec.z + mRows[ 2 ].w );
	}
	else {
		float invS = 1.0f / s;
		return NsVector3(
			(mRows[ 0 ].x * vec.x + mRows[ 0 ].y * vec.y + mRows[ 0 ].z * vec.z + mRows[ 0 ].w) * invS,
			(mRows[ 1 ].x * vec.x + mRows[ 1 ].y * vec.y + mRows[ 1 ].z * vec.z + mRows[ 1 ].w) * invS,
			(mRows[ 2 ].x * vec.x + mRows[ 2 ].y * vec.y + mRows[ 2 ].z * vec.z + mRows[ 2 ].w) * invS );
	}
}

inline NsMatrix4 NsMatrix4::operator*( const NsMatrix4 &a ) const {
	int i, j;
	const float *m1Ptr, *m2Ptr;
	float *dstPtr;
	NsMatrix4 dst;

	m1Ptr = reinterpret_cast<const float *>(this);
	m2Ptr = reinterpret_cast<const float *>(&a);
	dstPtr = reinterpret_cast<float *>(&dst);
	for ( i = 0; i < 4; i++ ) {
		for ( j = 0; j < 4; j++ ) {
			*dstPtr = m1Ptr[0] * m2Ptr[ 0 * 4 + j ]
					+ m1Ptr[1] * m2Ptr[ 1 * 4 + j ]
					+ m1Ptr[2] * m2Ptr[ 2 * 4 + j ]
					+ m1Ptr[3] * m2Ptr[ 3 * 4 + j ];
			dstPtr++;
		}
		m1Ptr += 4;
	}
	return dst;
}

inline NsMatrix4 NsMatrix4::operator+( const NsMatrix4 &a ) const {
	return NsMatrix4( 
		mRows[0].x + a[0].x, mRows[0].y + a[0].y, mRows[0].z + a[0].z, mRows[0].w + a[0].w,
		mRows[1].x + a[1].x, mRows[1].y + a[1].y, mRows[1].z + a[1].z, mRows[1].w + a[1].w,
		mRows[2].x + a[2].x, mRows[2].y + a[2].y, mRows[2].z + a[2].z, mRows[2].w + a[2].w,
		mRows[3].x + a[3].x, mRows[3].y + a[3].y, mRows[3].z + a[3].z, mRows[3].w + a[3].w );
}
    
inline NsMatrix4 NsMatrix4::operator-( const NsMatrix4 &a ) const {
	return NsMatrix4( 
		mRows[0].x - a[0].x, mRows[0].y - a[0].y, mRows[0].z - a[0].z, mRows[0].w - a[0].w,
		mRows[1].x - a[1].x, mRows[1].y - a[1].y, mRows[1].z - a[1].z, mRows[1].w - a[1].w,
		mRows[2].x - a[2].x, mRows[2].y - a[2].y, mRows[2].z - a[2].z, mRows[2].w - a[2].w,
		mRows[3].x - a[3].x, mRows[3].y - a[3].y, mRows[3].z - a[3].z, mRows[3].w - a[3].w );
}

inline NsMatrix4 &NsMatrix4::operator*=( const float a ) {
	mRows[0].x *= a; mRows[0].y *= a; mRows[0].z *= a; mRows[0].w *= a;
	mRows[1].x *= a; mRows[1].y *= a; mRows[1].z *= a; mRows[1].w *= a;
	mRows[2].x *= a; mRows[2].y *= a; mRows[2].z *= a; mRows[2].w *= a;
	mRows[3].x *= a; mRows[3].y *= a; mRows[3].z *= a; mRows[3].w *= a;
    return *this;
}

inline NsMatrix4 &NsMatrix4::operator*=( const NsMatrix4 &a ) {
	*this = (*this) * a;
	return *this;
}

inline NsMatrix4 &NsMatrix4::operator+=( const NsMatrix4 &a ) {
	mRows[0].x += a[0].x; mRows[0].y += a[0].y; mRows[0].z += a[0].z; mRows[0].w += a[0].w;
	mRows[1].x += a[1].x; mRows[1].y += a[1].y; mRows[1].z += a[1].z; mRows[1].w += a[1].w;
	mRows[2].x += a[2].x; mRows[2].y += a[2].y; mRows[2].z += a[2].z; mRows[2].w += a[2].w;
	mRows[3].x += a[3].x; mRows[3].y += a[3].y; mRows[3].z += a[3].z; mRows[3].w += a[3].w;
    return *this;
}

inline NsMatrix4 &NsMatrix4::operator-=( const NsMatrix4 &a ) {
	mRows[0].x -= a[0].x; mRows[0].y -= a[0].y; mRows[0].z -= a[0].z; mRows[0].w -= a[0].w;
	mRows[1].x -= a[1].x; mRows[1].y -= a[1].y; mRows[1].z -= a[1].z; mRows[1].w -= a[1].w;
	mRows[2].x -= a[2].x; mRows[2].y -= a[2].y; mRows[2].z -= a[2].z; mRows[2].w -= a[2].w;
	mRows[3].x -= a[3].x; mRows[3].y -= a[3].y; mRows[3].z -= a[3].z; mRows[3].w -= a[3].w;
    return *this;
}

inline NsMatrix4 operator*( const float a, const NsMatrix4 &mat ) {
	return mat * a;
}

inline NsVector4 operator*( const NsVector4 &vec, const NsMatrix4 &mat ) {
	return mat * vec;
}

inline NsVector3 operator*( const NsVector3 &vec, const NsMatrix4 &mat ) {
	return mat * vec;
}

inline NsVector4 &operator*=( NsVector4 &vec, const NsMatrix4 &mat ) {
	vec = mat * vec;
	return vec;
}

inline NsVector3 &operator*=( NsVector3 &vec, const NsMatrix4 &mat ) {
	vec = mat * vec;
	return vec;
}

inline bool NsMatrix4::Compare( const NsMatrix4 &a ) const {
	int i;
	const float *ptr1, *ptr2;

	ptr1 = reinterpret_cast<const float *>(mRows);
	ptr2 = reinterpret_cast<const float *>(a.mRows);
	for ( i = 0; i < 4*4; i++ ) {
		if ( ptr1[i] != ptr2[i] ) {
			return false;
		}
	}
	return true;
}

inline bool NsMatrix4::Compare( const NsMatrix4 &a, const float epsilon ) const {
	unsigned long i;
	const float *ptr1, *ptr2;

	ptr1 = reinterpret_cast<const float *>(mRows);
	ptr2 = reinterpret_cast<const float *>(a.mRows);
	for ( i = 0; i < 4*4; i++ ) {
		if ( NsMath::Abs( ptr1[i] - ptr2[i] ) > epsilon ) {
			return false;
		}
	}
	return true;
}

inline bool NsMatrix4::operator==( const NsMatrix4 &a ) const {
	return Compare( a );
}

inline bool NsMatrix4::operator!=( const NsMatrix4 &a ) const {
	return !Compare( a );
}

inline void NsMatrix4::SetZero( void ) {
	memset( mRows, 0, sizeof( NsMatrix4 ) );
}

inline bool NsMatrix4::IsIdentity( const float epsilon ) const {
	return Compare( mat4_identity, epsilon );
}

inline bool NsMatrix4::IsSymmetric( const float epsilon ) const {
	for ( int i = 1; i < 4; i++ ) {
		for ( int j = 0; j < i; j++ ) {
			if ( NsMath::Abs( mRows[i][j] - mRows[j][i] ) > epsilon ) {
				return false;
			}
		}
	}
	return true;
}

inline bool NsMatrix4::IsDiagonal( const float epsilon ) const {
	for ( int i = 0; i < 4; i++ ) {
		for ( int j = 0; j < 4; j++ ) {
			if ( i != j && NsMath::Abs( mRows[i][j] ) > epsilon ) {
				return false;
			}
		}
	}
	return true;
}

inline bool NsMatrix4::IsRotated( void ) const {
	if ( !mRows[ 0 ][ 1 ] && !mRows[ 0 ][ 2 ] &&
		!mRows[ 1 ][ 0 ] && !mRows[ 1 ][ 2 ] &&
		!mRows[ 2 ][ 0 ] && !mRows[ 2 ][ 1 ] ) {
		return false;
	}
	return true;
}

inline void NsMatrix4::ProjectVector( const NsVector4 &src, NsVector4 &dst ) const {
	dst.x = src * mRows[ 0 ];
	dst.y = src * mRows[ 1 ];
	dst.z = src * mRows[ 2 ];
	dst.w = src * mRows[ 3 ];
}

inline void NsMatrix4::UnprojectVector( const NsVector4 &src, NsVector4 &dst ) const {
	dst = mRows[ 0 ] * src.x + mRows[ 1 ] * src.y + mRows[ 2 ] * src.z + mRows[ 3 ] * src.w;
}

inline float NsMatrix4::Trace( void ) const {
	return ( mRows[0][0] + mRows[1][1] + mRows[2][2] + mRows[3][3] );
}

inline NsMatrix4 NsMatrix4::Inverse( void ) const {
	NsMatrix4 invMat;

	invMat = *this;
#if 1
	invMat.InverseSelf();
#else
	AssertPtr( D3DXMatrixInverse( (D3DXMATRIX*) &invMat, null, (const D3DXMATRIX*) this->ToFloatPtr() ) );
#endif
	return invMat;
}

inline NsMatrix4 NsMatrix4::InverseFast( void ) const {
	NsMatrix4 invMat;

	invMat = *this;
	invMat.InverseFastSelf();
	return invMat;
}


inline int NsMatrix4::GetDimension( void ) const {
	return 16;
}

inline void NsMatrix4::SetRow( int iRow, const NsVector4& v )
{
	mRows[ iRow ] = v;
}

inline const float *NsMatrix4::ToFloatPtr( void ) const {
	return mRows[0].ToFloatPtr();
}

inline float *NsMatrix4::ToFloatPtr( void ) {
	return mRows[0].ToFloatPtr();
}

inline NsMatrix4& NsMatrix4::SetTranslation( const NsVector3& v ) {
	mRows[3].x = v.x;
	mRows[3].y = v.y;
	mRows[3].z = v.z;
	return *this;
}

inline const NsVector3 & NsMatrix4::GetTranslation() const {
	return *(const NsVector3*) & mRows[3]; // the fourth row
}
inline NsVector3 & NsMatrix4::GetTranslation() {
	return *(NsVector3*) & mRows[3]; // the fourth row
}
inline void NsMatrix4::SetScale( const NsVector3& scaleFactor )
{
	mRows[0][0] = scaleFactor.x;
	mRows[1][1] = scaleFactor.y;
	mRows[2][2] = scaleFactor.z;
}

inline void NsMatrix4::SetDiagonal( const NsVector3& v ) {
	mRows[0][0] = v.x;
	mRows[1][1] = v.y;
	mRows[2][2] = v.z;
}

inline NsMatrix4 NsMatrix4::CreateScale( float uniformScaleFactor ) {
	return NsMatrix4( 
		uniformScaleFactor,	0.0f,				0.0f,				0.0f,
		0.0f,				uniformScaleFactor,	0.0f,				0.0f,
		0.0f,				0.0f,				uniformScaleFactor,	0.0f,
		0.0f,				0.0f,				0.0f,				1.0f );
}

inline NsMatrix4 NsMatrix4::CreateScale( const NsVector3& scaleFactor ) {
	return NsMatrix4( 
		scaleFactor.x,		0.0f,				0.0f,				0.0f,
		0.0f,				scaleFactor.y,		0.0f,				0.0f,
		0.0f,				0.0f,				scaleFactor.z,		0.0f,
		0.0f,				0.0f,				0.0f,				1.0f );
}

inline NsMatrix4 NsMatrix4::CreateTranslation( const NsVector3& translation ) {
	return NsMatrix4( 
		1.0f,				0.0f,				0.0f,				0.0f,
		0.0f,				1.0f,				0.0f,				0.0f,
		0.0f,				0.0f,				1.0f,				0.0f,
		translation.x,		translation.y,		translation.z,		1.0f );
}

inline NsMatrix4 NsMatrix4::Identity()
{
	return NsMatrix4(
		1.0f,				0.0f,				0.0f,				0.0f,
		0.0f,				1.0f,				0.0f,				0.0f,
		0.0f,				0.0f,				1.0f,				0.0f,
		0.0f,				0.0f,				0.0f,				1.0f);
}

//
//	NsMatrix4::BuildViewLH
//
//	NOTE: watch out for singularities if look vector is close to up vector! 
//
inline void NsMatrix4::BuildViewLH( const NsVector3& eyePosition, const NsVector3& target, const NsVector3& upVector )
{
	NsVector3 	zaxis( target - eyePosition );
	zaxis.Normalize();

	NsVector3 	xaxis( upVector.Cross( zaxis ) );
	xaxis.Normalize();

	NsVector3 	yaxis( zaxis.Cross( xaxis ) );

	mRows[0].Set(	xaxis.x,           			yaxis.x,           			zaxis.x,          			0.0f );
	mRows[1].Set(	xaxis.y,           			yaxis.y,           			zaxis.y,          			0.0f );
	mRows[2].Set(	xaxis.z,           			yaxis.z,           			zaxis.z,          			0.0f );
	mRows[3].Set(	-xaxis.Dot( eyePosition ),  -yaxis.Dot( eyePosition ),  -zaxis.Dot( eyePosition ),  1.0f );
}

//
//	NsMatrix4::BuildPerspectiveLH - makes a left-handed perspective projection matrix.
//
// FOVy - Vertical field of view ( in the y direction ), in radians.
// Aspect - Aspect ratio ( screen width divided by screen height ).
//
inline void NsMatrix4::BuildPerspectiveLH( float FOVy, float Aspect, float NearZ, float FarZ )
{
	const float yScale = 1 / NsMath::Tan( 0.5f * FOVy );
	const float xScale = yScale / Aspect;

	mRows[0].Set( xScale,		0.0f,		0.0f,               			0.0f );
	mRows[1].Set( 0.0f,			yScale,		0.0f,               			0.0f );
	mRows[2].Set( 0.0f,			0.0f,       FarZ/(FarZ - NearZ),			1.0f );
	mRows[3].Set( 0.0f,			0.0f,       -NearZ * FarZ/(FarZ - NearZ),	0.0f );
}

//
//	NsMatrix4::BuildOrthoLH - makes a left-handed orthographic projection matrix.
//
inline void NsMatrix4::BuildOrthoLH( float Width, float Height, float NearZ, float FarZ )
{
	mRows[0].Set( 2/Width,  0.0f,		0.0f,					0.0f );
	mRows[1].Set( 0,        2/Height,	0.0f,					0.0f );
	mRows[2].Set( 0.0f,     0.0f,       1/(FarZ - NearZ),		0.0f );
	mRows[3].Set( 0.0f,     0.0f,       NearZ/(NearZ - FarZ),	1.0f );
}

//
//	NsMatrix4::TransformVector
//
inline NsVector3 NsMatrix4::TransformVector( const NsVector3& point ) const
{
	const float * M = (const float*) mRows;

	return NsVector3(
			point.x * M[0] + point.y * M[4] + point.z * M[8] + M[12],
			point.x * M[1] + point.y * M[5] + point.z * M[9] + M[13],
			point.x * M[2] + point.y * M[6] + point.z * M[10] + M[14]
		);
}

//
//	NsMatrix4::InverseTransformVector
//
inline NsVector3 NsMatrix4::InverseTransformVector( const NsVector3& point ) const
{
	const float ** M = (const float**) mRows;

	const NsVector3	temp(
		point.x - M[3][0],
		point.y - M[3][1],
		point.z - M[3][2]
	);

	return NsVector3(
		temp.x * M[0][0] + temp.y * M[0][1] + temp.z * M[0][2],
		temp.x * M[1][0] + temp.y * M[1][1] + temp.z * M[1][2],
		temp.x * M[2][0] + temp.y * M[2][1] + temp.z * M[2][2]
	);
}

//
//	NsMatrix4::TransformNormal
//
inline NsVector3 NsMatrix4::TransformNormal( const NsVector3& normal ) const
{
	const float * M = (float*) mRows;

	return NsVector3(
			normal.x * M[0] + normal.y * M[4] + normal.z * M[8],
			normal.x * M[1] + normal.y * M[5] + normal.z * M[9],
			normal.x * M[2] + normal.y * M[6] + normal.z * M[10]
		);
}

//
//	NsMatrix4::InverseTransformNormal
//
inline NsVector3 NsMatrix4::InverseTransformNormal( const NsVector3& normal ) const
{
	const float ** M = (const float**) mRows;

	return NsVector3(
		normal.x * M[0][0] + normal.y * M[0][1] + normal.z * M[0][2],
		normal.x * M[1][0] + normal.y * M[1][1] + normal.z * M[1][2],
		normal.x * M[2][0] + normal.y * M[2][1] + normal.z * M[2][2]
	);
}

//
//	NsMatrix4::GetTransformedPlane
//
inline NsVector4 NsMatrix4::GetTransformedPlane( const NsVector4& plane ) const
{
	const float ** M = (const float**) mRows;

	return NsVector4(
		plane.x * M[0][0] + plane.y * M[1][0] + plane.z * M[2][0] + plane.w * M[3][0],
		plane.x * M[0][1] + plane.y * M[1][1] + plane.z * M[2][1] + plane.w * M[3][1],
		plane.x * M[0][2] + plane.y * M[1][2] + plane.z * M[2][2] + plane.w * M[3][2],
		plane.x * M[0][3] + plane.y * M[1][3] + plane.z * M[2][3] + plane.w * M[3][3]
	);
}








/*
===========================================================
		BuildLookAtMatrixLH

	Creates a left-handed view transformation matrix.
	NOTE: watch out for singularities if look vector is close to up vector! 
===========================================================
*/
inline NsMatrix4 BuildLookAtMatrixLH( const NsVector3& eyePosition, const NsVector3& lookAt, const NsVector3& upVector = NsVector3::vec3_unit_y )
{
	NsVector3 	zaxis( lookAt );

	NsVector3 	xaxis( upVector.Cross( zaxis ) );
	xaxis.Normalize();

	NsVector3 	yaxis( zaxis.Cross( xaxis ) );

	return NsMatrix4(
		xaxis.x,           			yaxis.x,           			zaxis.x,          			0.0f,
		xaxis.y,           			yaxis.y,           			zaxis.y,          			0.0f,
		xaxis.z,           			yaxis.z,           			zaxis.z,          			0.0f,
		-xaxis.Dot( eyePosition ),  -yaxis.Dot( eyePosition ),  -zaxis.Dot( eyePosition ),  1.0f );
}

inline NsVector3 NsMatrix4::HomogeneousMultiply( const NsVector3& v, float w ) const
{
    NsVector4 r = (*this) * NsVector4( v, w );
	return r.ToVec3() * ( 1.0f / r.w );
}