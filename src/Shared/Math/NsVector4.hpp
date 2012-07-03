#pragma once
#include "NsMath.hpp"
#include "NsVector3.hpp"

class NsVector4
{
public:
	float	x;
	float	y;
	float	z;
	float	w;

					NsVector4();
					explicit NsVector4( const float x, const float y, const float z, const float w );
					explicit NsVector4( const NsVector3& xyz, const float w );
					explicit NsVector4( const float xyzw );

	void 			Set( const float x, const float y, const float z, const float w );
	void			SetZero( void );

	float			operator[]( const int index ) const;
	float &			operator[]( const int index );
	NsVector4			operator-() const;
	float			operator*( const NsVector4 &a ) const;
	NsVector4			operator*( const float a ) const;
	NsVector4			operator/( const float a ) const;
	NsVector4			operator+( const NsVector4 &a ) const;
	NsVector4			operator-( const NsVector4 &a ) const;
	NsVector4 &			operator+=( const NsVector4 &a );
	NsVector4 &			operator-=( const NsVector4 &a );
	NsVector4 &			operator/=( const NsVector4 &a );
	NsVector4 &			operator/=( const float a );
	NsVector4 &			operator*=( const float a );

	friend NsVector4	operator*( const float a, const NsVector4& b );

	bool			Compare( const NsVector4 &a ) const;							// exact compare, no epsilon
	bool			Compare( const NsVector4 &a, const float epsilon ) const;		// compare with epsilon
	bool			operator==(	const NsVector4 &a ) const;						// exact compare, no epsilon
	bool			operator!=(	const NsVector4 &a ) const;						// exact compare, no epsilon

	float			GetLength( void ) const;
	float			LengthSqr( void ) const;
	float			Normalize( void );			// returns length
	float			NormalizeFast( void );		// returns length

	int				GetDimension( void ) const;

	const NsVector3 &	ToVec3( void ) const;
	NsVector3 &			ToVec3( void );
	const float *	ToFloatPtr( void ) const;
	float *			ToFloatPtr( void );
	const char *	ToString( int precision = 2 ) const;

	void			Lerp( const NsVector4 &v1, const NsVector4 &v2, const float l );

	NsVector4 & 		RotateAboutX( float angle );
	NsVector4 & 		RotateAboutY( float angle );
	NsVector4 & 		RotateAboutZ( float angle );
	NsVector4 & 		RotateAboutAxis( float angle, const NsVector3& axis );

public:
	static const NsVector4 vec4_origin;
};

inline NsVector4::NsVector4()
{
	this->x = 0.0f;
	this->y = 0.0f;
	this->z = 0.0f;
	this->w = 0.0f;
}

inline NsVector4::NsVector4( const float x, const float y, const float z, const float w )
{
	this->x = x;
	this->y = y;
	this->z = z;
	this->w = w;
}



inline NsVector4::NsVector4( const NsVector3& xyz, const float w ) {
	this->x = xyz.x;
	this->y = xyz.y;
	this->z = xyz.z;
	this->w = w;
}

inline NsVector4::NsVector4( const float xyzw ) {
	this->x = xyzw;
	this->y = xyzw;
	this->z = xyzw;
	this->w = xyzw;
}

inline void NsVector4::Set( const float x, const float y, const float z, const float w ) {
	this->x = x;
	this->y = y;
	this->z = z;
	this->w = w;
}

inline void NsVector4::SetZero( void ) {
	x = y = z = w = 0.0f;
}

inline float NsVector4::operator[]( int index ) const {
	return ( &x )[ index ];
}

inline float& NsVector4::operator[]( int index ) {
	return ( &x )[ index ];
}

inline NsVector4 NsVector4::operator-() const {
	return NsVector4( -x, -y, -z, -w );
}

inline NsVector4 NsVector4::operator-( const NsVector4 &a ) const {
	return NsVector4( x - a.x, y - a.y, z - a.z, w - a.w );
}

inline float NsVector4::operator*( const NsVector4 &a ) const {
	return x * a.x + y * a.y + z * a.z + w * a.w;
}

inline NsVector4 NsVector4::operator*( const float a ) const {
	return NsVector4( x * a, y * a, z * a, w * a );
}

inline NsVector4 NsVector4::operator/( const float a ) const {
	float inva = 1.0f / a;
	return NsVector4( x * inva, y * inva, z * inva, w * inva );
}

inline NsVector4 operator*( const float a, const NsVector4& b ) {
	return NsVector4( b.x * a, b.y * a, b.z * a, b.w * a );
}

inline NsVector4 NsVector4::operator+( const NsVector4 &a ) const {
	return NsVector4( x + a.x, y + a.y, z + a.z, w + a.w );
}

inline NsVector4 &NsVector4::operator+=( const NsVector4 &a ) {
	x += a.x;
	y += a.y;
	z += a.z;
	w += a.w;

	return *this;
}

inline NsVector4 &NsVector4::operator/=( const NsVector4 &a ) {
	x /= a.x;
	y /= a.y;
	z /= a.z;
	w /= a.w;

	return *this;
}

inline NsVector4 &NsVector4::operator/=( const float a ) {
	float inva = 1.0f / a;
	x *= inva;
	y *= inva;
	z *= inva;
	w *= inva;

	return *this;
}

inline NsVector4 &NsVector4::operator-=( const NsVector4 &a ) {
	x -= a.x;
	y -= a.y;
	z -= a.z;
	w -= a.w;

	return *this;
}

inline NsVector4 &NsVector4::operator*=( const float a ) {
	x *= a;
	y *= a;
	z *= a;
	w *= a;

	return *this;
}

inline bool NsVector4::Compare( const NsVector4 &a ) const {
	return ( ( x == a.x ) && ( y == a.y ) && ( z == a.z ) && w == a.w );
}

inline bool NsVector4::Compare( const NsVector4 &a, const float epsilon ) const {
	if ( NsMath::Abs( x - a.x ) > epsilon ) {
		return false;
	}
			
	if ( NsMath::Abs( y - a.y ) > epsilon ) {
		return false;
	}

	if ( NsMath::Abs( z - a.z ) > epsilon ) {
		return false;
	}

	if ( NsMath::Abs( w - a.w ) > epsilon ) {
		return false;
	}

	return true;
}

inline bool NsVector4::operator==( const NsVector4 &a ) const {
	return Compare( a );
}

inline bool NsVector4::operator!=( const NsVector4 &a ) const {
	return !Compare( a );
}

inline float NsVector4::GetLength( void ) const {
	return ( float )NsMath::Sqrt( x * x + y * y + z * z + w * w );
}

inline float NsVector4::LengthSqr( void ) const {
	return ( x * x + y * y + z * z + w * w );
}

inline float NsVector4::Normalize( void ) {
	float sqrLength, invLength;

	sqrLength = x * x + y * y + z * z + w * w;
	invLength = NsMath::InvSqrt( sqrLength );
	x *= invLength;
	y *= invLength;
	z *= invLength;
	w *= invLength;
	return invLength * sqrLength;
}

inline float NsVector4::NormalizeFast( void ) {
	float sqrLength, invLength;

	sqrLength = x * x + y * y + z * z + w * w;
	invLength = NsMath::InvSqrt( sqrLength );
	x *= invLength;
	y *= invLength;
	z *= invLength;
	w *= invLength;
	return invLength * sqrLength;
}

inline int NsVector4::GetDimension( void ) const {
	return 4;
}

inline const NsVector3 &NsVector4::ToVec3( void ) const {
	return *reinterpret_cast<const NsVector3 *>(this);
}

inline NsVector3 &NsVector4::ToVec3( void ) {
	return *reinterpret_cast<NsVector3 *>(this);
}

inline const float *NsVector4::ToFloatPtr( void ) const {
	return &x;
}

inline float *NsVector4::ToFloatPtr( void ) {
	return &x;
}