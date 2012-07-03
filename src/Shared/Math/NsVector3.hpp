#pragma once
#include "NsMath.hpp"

class NsVector3
{
	friend NsVector3 operator*(const float a, const NsVector3 b);

public:
	float x;
	float y;
	float z;

public:
	NsVector3();
	explicit NsVector3(const float f);
	explicit NsVector3(const float x, const float y, const float z);

	void Set(const float x, const float y, const float z);
	void SetAll(const float value);
	void SetZero(void);

	float operator[](const int index) const;
	float & operator[](const int index);
	NsVector3 operator-() const;
	NsVector3 & operator=(const NsVector3 &a);
	float operator*(const NsVector3 &a) const;
	NsVector3 operator^(const NsVector3 &a) const;
	NsVector3 operator*(const float a) const;
	NsVector3 operator/(const float a) const;
	NsVector3 operator+(const NsVector3 &a) const;
	NsVector3 operator-(const NsVector3 &a) const;
	NsVector3 & operator+=(const NsVector3 &a);
	NsVector3 & operator-=(const NsVector3 &a);
	NsVector3 & operator/=(const NsVector3 &a);
	NsVector3 & operator/=(const float a);
	NsVector3 & operator*=(const float a);
	
	bool Compare(const NsVector3 &a) const;  	// exact compare, no epsilon
	bool Compare(const NsVector3 &a, const float epsilon) const;		// compare with epsilon
	bool operator==(	const NsVector3 &a) const;  // exact compare, no epsilon
	bool operator!=(	const NsVector3 &a) const;  // exact compare, no epsilon

	bool FixDegenerateNormal(void);	// fix degenerate axial cases
	bool FixDenormals(void); // change tiny numbers to zero
	bool IsZero() const;
	bool Any() const;	// returns 'true' if any components of the vector are non-zero; otherwise, returns 'false'
	bool All() const;	// returns 'true' if if all components of the vector are non-zero; otherwise, returns 'false'

	float Dot(const NsVector3 &a) const;
	NsVector3 Cross(const NsVector3 &a) const;
	NsVector3 & Cross(const NsVector3 &a, const NsVector3 &b);
	float GetLength(void) const;
	float LengthSqr(void) const;
	float LengthFast(void) const;
	NsVector3 GetNormalized() const;
	float Normalize(void); 	// returns length
	void NormalizeFast(void); // unsafe!
	NsVector3 & Truncate(float length);		// cap length
	void Clamp(const NsVector3 &min, const NsVector3 &max);
	void Snap(void); // snap to closest integer value
	void SnapInt(void); 	// snap towards integer (floor)

	int 	GetDimension(void) const;

	float ToYaw(void) const;
	float ToPitch(void) const;

	const float *	ToFloatPtr(void) const;
	float * ToFloatPtr(void);
	const char *	ToString(int precision = 2) const;

	void NormalVectors(NsVector3 &left, NsVector3 &down) const;	// vector should be normalized
	void OrthogonalBasis(NsVector3 &left, NsVector3 &up) const;

	void ProjectOntoPlane(const NsVector3 &normal, const float overBounce = 1.0f);
	bool ProjectAlongPlane(const NsVector3 &normal, const float epsilon, const float overBounce = 1.0f);
	void ProjectSelfOntoSphere(const float radius);

	void Lerp(const NsVector3 &v1, const NsVector3 &v2, const float l);
	void SLerp(const NsVector3 &v1, const NsVector3 &v2, const float l);

	NsVector3 & RotateAboutX(float angle);
	NsVector3 & RotateAboutY(float angle);
	NsVector3 & RotateAboutZ(float angle);
	NsVector3 & RotateAboutAxis(float angle, const NsVector3& axis);

	bool IsValid() const;

public:
	static NsVector3	GetRandom(int seed = 0);
	static NsVector3	GetRandomNormalized(int seed = 0);

public:
	static NsVector3 CreateOrigin();
	static NsVector3 CreateUnit();

public:
	static const NsVector3 vec3_origin;	// (0, 0, 0).

	static const NsVector3 ZERO; // (0, 0, 0).

	static const NsVector3 vec3_unit;	// (1, 1, 1).

	static const NsVector3 vec3_unit_x;
	static const NsVector3 vec3_unit_y;
	static const NsVector3 vec3_unit_z;
	static const NsVector3 vec3_neg_unit_x;
	static const NsVector3 vec3_neg_unit_y;
	static const NsVector3 vec3_neg_unit_z;

	static const NsVector3 vec3_plus_inf;
	static const NsVector3 vec3_minus_inf;
};

inline NsVector3 NsVector3::CreateOrigin()
{
	return NsVector3(0, 0, 0);
}
	
inline NsVector3 NsVector3::CreateUnit()
{
	return NsVector3(1, 1, 1);
}

inline NsVector3::NsVector3()
{
	this->x = 0;
	this->y = 0;
	this->z = 0;
}

inline NsVector3::NsVector3(const float f) {
	this->x = f;
	this->y = f;
	this->z = f;
}

inline NsVector3::NsVector3(const float x, const float y, const float z) {
	this->x = x;
	this->y = y;
	this->z = z;
}

inline float NsVector3::operator[](const int index) const {
	return (&x)[ index ];
}

inline float &NsVector3::operator[](const int index) {
	return (&x)[ index ];
}

inline void NsVector3::Set(const float x, const float y, const float z) {
	this->x = x;
	this->y = y;
	this->z = z;
}

inline void NsVector3::SetAll(const float value) {
	this->x = value;
	this->y = value;
	this->z = value;
}

inline void NsVector3::SetZero(void) {
	x = y = z = 0.0f;
}

inline NsVector3 NsVector3::operator-() const {
	return NsVector3(-x, -y, -z);
}

inline NsVector3 &NsVector3::operator=(const NsVector3 &a) {
	x = a.x;
	y = a.y;
	z = a.z;
	return *this;
}

inline NsVector3 NsVector3::operator-(const NsVector3 &a) const {
	return NsVector3(x - a.x, y - a.y, z - a.z);
}

inline float NsVector3::operator*(const NsVector3 &a) const {
	return Dot(a);
}

inline float NsVector3::Dot(const NsVector3 &a) const {
	return x * a.x + y * a.y + z * a.z;
}

inline NsVector3 NsVector3::operator*(const float a) const {
	return NsVector3(x * a, y * a, z * a);
}

inline NsVector3 NsVector3::operator^(const NsVector3 &a) const {
	return NsVector3(
		y * a.z - z * a.y,
		z * a.x - x * a.z,
		x * a.y - y * a.x);
}

inline NsVector3 NsVector3::operator/(const float a) const {
	float inva = 1.0f / a;
	return NsVector3(x * inva, y * inva, z * inva);
}

inline NsVector3 operator*(const float a, const NsVector3 b) {
	return NsVector3(b.x * a, b.y * a, b.z * a);
}

inline NsVector3 NsVector3::operator+(const NsVector3 &a) const {
	return NsVector3(x + a.x, y + a.y, z + a.z);
}

inline NsVector3 &NsVector3::operator+=(const NsVector3 &a) {
	x += a.x;
	y += a.y;
	z += a.z;

	return *this;
}

inline NsVector3 &NsVector3::operator/=(const NsVector3 &a) {
	x /= a.x;
	y /= a.y;
	z /= a.z;

	return *this;
}

inline NsVector3 &NsVector3::operator/=(const float a) {
	float inva = 1.0f / a;
	x *= inva;
	y *= inva;
	z *= inva;

	return *this;
}

inline NsVector3 &NsVector3::operator-=(const NsVector3 &a) {
	x -= a.x;
	y -= a.y;
	z -= a.z;

	return *this;
}

inline NsVector3 &NsVector3::operator*=(const float a) {
	x *= a;
	y *= a;
	z *= a;

	return *this;
}

inline bool NsVector3::Compare(const NsVector3 &a) const {
	return ((x == a.x) && (y == a.y) && (z == a.z));
}

inline bool NsVector3::Compare(const NsVector3 &a, const float epsilon) const {
	if (NsMath::Abs(x - a.x) > epsilon) {
		return false;
	}

	if (NsMath::Abs(y - a.y) > epsilon) {
		return false;
	}

	if (NsMath::Abs(z - a.z) > epsilon) {
		return false;
	}

	return true;
}

inline bool NsVector3::operator==(const NsVector3 &a) const {
	return Compare(a);
}

inline bool NsVector3::operator!=(const NsVector3 &a) const {
	return !Compare(a);
}

// fast vector normalize routine that does not check to make sure
// that length != 0, nor does it return length, uses rsqrt approximation
//
inline void NsVector3::NormalizeFast(void) {
	float sqrLength, invLength;

	sqrLength = x * x + y * y + z * z;
	invLength = NsMath::InvSqrt(sqrLength);
	x *= invLength;
	y *= invLength;
	z *= invLength;
}

inline bool NsVector3::FixDegenerateNormal(void) {
	if (x == 0.0f) {
		if (y == 0.0f) {
			if (z > 0.0f) {
				if (z != 1.0f) {
					z = 1.0f;
					return true;
				}
			} else {
				if (z != -1.0f) {
					z = -1.0f;
					return true;
				}
			}
			return false;
		} else if (z == 0.0f) {
			if (y > 0.0f) {
				if (y != 1.0f) {
					y = 1.0f;
					return true;
				}
			} else {
				if (y != -1.0f) {
					y = -1.0f;
					return true;
				}
			}
			return false;
		}
	} else if (y == 0.0f) {
		if (z == 0.0f) {
			if (x > 0.0f) {
				if (x != 1.0f) {
					x = 1.0f;
					return true;
				}
			} else {
				if (x != -1.0f) {
					x = -1.0f;
					return true;
				}
			}
			return false;
		}
	}
	if (NsMath::Abs(x) == 1.0f) {
		if (y != 0.0f || z != 0.0f) {
			y = z = 0.0f;
			return true;
		}
		return false;
	} else if (NsMath::Abs(y) == 1.0f) {
		if (x != 0.0f || z != 0.0f) {
			x = z = 0.0f;
			return true;
		}
		return false;
	} else if (NsMath::Abs(z) == 1.0f) {
		if (x != 0.0f || y != 0.0f) {
			x = y = 0.0f;
			return true;
		}
		return false;
	}
	return false;
}

inline bool NsVector3::FixDenormals(void) {
	bool denormal = false;
	if (NsMath::Abs(x) < 1e-30f) {
		x = 0.0f;
		denormal = true;
	}
	if (NsMath::Abs(y) < 1e-30f) {
		y = 0.0f;
		denormal = true;
	}
	if (NsMath::Abs(z) < 1e-30f) {
		z = 0.0f;
		denormal = true;
	}
	return denormal;
}

// NOTE: (vec3_unit_x * -vec3_unit_z == vec3_unit_y).
inline NsVector3 NsVector3::Cross(const NsVector3 &a) const {
	return NsVector3(
		y * a.z - z * a.y,
		z * a.x - x * a.z,
		x * a.y - y * a.x);
}
// NOTE: (vec3_unit_x * -vec3_unit_z == vec3_unit_y).
inline NsVector3 & NsVector3::Cross(const NsVector3 &a, const NsVector3 &b) {
	x = a.y * b.z - a.z * b.y;
	y = a.z * b.x - a.x * b.z;
	z = a.x * b.y - a.y * b.x;

	return *this;
}

inline float NsVector3::GetLength(void) const {
	return (float)NsMath::Sqrt(x * x + y * y + z * z);
}

inline float NsVector3::LengthSqr(void) const {
	return (x * x + y * y + z * z);
}

inline float NsVector3::LengthFast(void) const {
	float sqrLength;

	sqrLength = x * x + y * y + z * z;
	return sqrLength * NsMath::InvSqrt(sqrLength);
}

inline NsVector3 NsVector3::GetNormalized() const {
	float sqrLength, invLength;

	sqrLength = x * x + y * y + z * z;
	invLength = NsMath::InvSqrt(sqrLength);

	return NsVector3(
		x * invLength,
		y * invLength,
		z * invLength
	);
}

inline float NsVector3::Normalize(void) {
	float sqrLength, invLength;

	sqrLength = x * x + y * y + z * z;
	invLength = NsMath::InvSqrt(sqrLength);
	x *= invLength;
	y *= invLength;
	z *= invLength;
	return invLength * sqrLength;
}

inline NsVector3 & NsVector3::Truncate(float length) {
	float length2;
	float ilength;

	if (!length) {
		SetZero();
	}
	else {
		length2 = LengthSqr();
		if (length2 > length * length) {
			ilength = length * NsMath::InvSqrt(length2);
			x *= ilength;
			y *= ilength;
			z *= ilength;
		}
	}

	return *this;
}

inline void NsVector3::Clamp(const NsVector3 &min, const NsVector3 &max) {
	if (x < min.x) {
		x = min.x;
	} else if (x > max.x) {
		x = max.x;
	}
	if (y < min.y) {
		y = min.y;
	} else if (y > max.y) {
		y = max.y;
	}
	if (z < min.z) {
		z = min.z;
	} else if (z > max.z) {
		z = max.z;
	}
}

inline void NsVector3::Snap(void) {
	x = NsMath::Floor(x + 0.5f);
	y = NsMath::Floor(y + 0.5f);
	z = NsMath::Floor(z + 0.5f);
}

inline void NsVector3::SnapInt(void) {
	x = float(int(x));
	y = float(int(y));
	z = float(int(z));
}

inline int NsVector3::GetDimension(void) const {
	return 3;
}

inline const float *NsVector3::ToFloatPtr(void) const {
	return &x;
}

inline float *NsVector3::ToFloatPtr(void) {
	return &x;
}

inline void NsVector3::NormalVectors(NsVector3 &left, NsVector3 &down) const {
	float d;

	d = x * x + y * y;
	if (!d) {
		left[0] = 1;
		left[1] = 0;
		left[2] = 0;
	} else {
		d = NsMath::InvSqrt(d);
		left[0] = -y * d;
		left[1] = x * d;
		left[2] = 0;
	}
	down = left.Cross(*this);
}

inline void NsVector3::OrthogonalBasis(NsVector3 &left, NsVector3 &up) const {
	float l, s;

	if (NsMath::Abs(z) > 0.7f) {
		l = y * y + z * z;
		s = NsMath::InvSqrt(l);
		up[0] = 0;
		up[1] = z * s;
		up[2] = -y * s;
		left[0] = l * s;
		left[1] = -x * up[2];
		left[2] = x * up[1];
	}
	else {
		l = x * x + y * y;
		s = NsMath::InvSqrt(l);
		left[0] = -y * s;
		left[1] = x * s;
		left[2] = 0;
		up[0] = -z * left[1];
		up[1] = z * left[0];
		up[2] = l * s;
	}
}

inline void NsVector3::ProjectOntoPlane(const NsVector3 &normal, const float overBounce) {
	float backoff;
	
	backoff = *this * normal;
	
	if (overBounce != 1.0) {
		if (backoff < 0) {
			backoff *= overBounce;
		} else {
			backoff /= overBounce;
		}
	}

	*this -= backoff * normal;
}

inline bool NsVector3::ProjectAlongPlane(const NsVector3 &normal, const float epsilon, const float overBounce) {
	NsVector3 cross;
	float len;

	cross = this->Cross(normal).Cross((*this));
	// normalize so a fixed epsilon can be used
	cross.Normalize();
	len = normal * cross;
	if (NsMath::Abs(len) < epsilon) {
		return false;
	}
	cross *= overBounce * (normal * (*this)) / len;
	(*this) -= cross;
	return true;
}

inline bool NsVector3::IsZero() const
{
	return (x == 0.0f) && (y == 0.0f) && (z == 0.0f);
}

inline bool NsVector3::Any() const
{
	return (x != 0.0f) || (y != 0.0f) || (z != 0.0f);
}

inline bool NsVector3::All() const
{
	return (x != 0.0f) && (y != 0.0f) && (z != 0.0f);
}