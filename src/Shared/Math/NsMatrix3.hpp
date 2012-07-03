#pragma once
#include "../Math/NsMath.hpp"
#include "../Math/NsVector3.hpp"
#include "../Math/NsMatrix4.hpp"
#include "../Common/NsMemory.hpp"

const double MATRIX_INVERSE_EPSILON	= 1e-14;
const double MATRIX_EPSILON			= 1e-6;

class NsMatrix3 {
public:
					NsMatrix3(void);
					explicit NsMatrix3(const NsVector3 &x, const NsVector3 &y, const NsVector3 &z);
					explicit NsMatrix3(const float xx, const float xy, const float xz, const float yx, const float yy, const float yz, const float zx, const float zy, const float zz);
					explicit NsMatrix3(const float src[ 3 ][ 3 ]);

	const NsVector3 &	operator[](int index) const;
	NsVector3 &			operator[](int index);
	NsMatrix3			operator-() const;
	NsMatrix3			operator*(const float a) const;
	NsVector3			operator*(const NsVector3 &vec) const;
	NsMatrix3			operator*(const NsMatrix3 &a) const;
	NsMatrix3			operator+(const NsMatrix3 &a) const;
	NsMatrix3			operator-(const NsMatrix3 &a) const;
	NsMatrix3 &		operator*=(const float a);
	NsMatrix3 &		operator*=(const NsMatrix3 &a);
	NsMatrix3 &		operator+=(const NsMatrix3 &a);
	NsMatrix3 &		operator-=(const NsMatrix3 &a);

	friend NsMatrix3	operator*(const float a, const NsMatrix3 &mat);
	friend NsVector3	operator*(const NsVector3 &vec, const NsMatrix3 &mat);
	friend NsVector3 &	operator*=(NsVector3 &vec, const NsMatrix3 &mat);

	bool			Compare(const NsMatrix3 &a) const;						// exact compare, no epsilon
	bool			Compare(const NsMatrix3 &a, const float epsilon) const;	// compare with epsilon
	bool			operator==(const NsMatrix3 &a) const;					// exact compare, no epsilon
	bool			operator!=(const NsMatrix3 &a) const;					// exact compare, no epsilon

	void			Set(float xx, float xy, float xz,
						 float yx, float yy, float yz,
						 float zx, float zy, float zz);
	void			SetZero(void);
	bool			IsIdentity(const float epsilon = MATRIX_EPSILON) const;
	bool			IsSymmetric(const float epsilon = MATRIX_EPSILON) const;
	bool			IsDiagonal(const float epsilon = MATRIX_EPSILON) const;
	bool			IsRotated(void) const;

	void			ProjectVector(const NsVector3 &src, NsVector3 &dst) const;
	void			UnprojectVector(const NsVector3 &src, NsVector3 &dst) const;

	bool			FixDegeneracies(void);	// fix degenerate axial cases
	bool			FixDenormals(void);		// change tiny numbers to zero

	float			Trace(void) const;
	float			Determinant(void) const;
	NsMatrix3			OrthoNormalize(void) const;
	NsMatrix3 &		OrthoNormalizeSelf(void);
	NsMatrix3			Transpose(void) const;	// returns transpose
	NsMatrix3 &		TransposeSelf(void);
	NsMatrix3			Inverse(void) const;		// returns the inverse (m * m.Inverse() = identity)
	bool			InverseSelf(void);		// returns false if determinant is zero
	NsMatrix3			InverseFast(void) const;	// returns the inverse (m * m.Inverse() = identity)
	bool			InverseFastSelf(void);	// returns false if determinant is zero
	NsMatrix3			TransposeMultiply(const NsMatrix3 &b) const;

	NsMatrix3			InertiaTranslate(const float mass, const NsVector3 &centerOfMass, const NsVector3 &translation) const;
	NsMatrix3 &		InertiaTranslateSelf(const float mass, const NsVector3 &centerOfMass, const NsVector3 &translation);
	NsMatrix3			InertiaRotate(const NsMatrix3 &rotation) const;
	NsMatrix3 &		InertiaRotateSelf(const NsMatrix3 &rotation);

	int				GetDimension(void) const;

	NsMatrix4 ToMatrix4() const;

	NsVector3			ToAngularVelocity(void) const;
	const float *	ToFloatPtr(void) const;
	float *			ToFloatPtr(void);
	const char *	ToString(int precision = 2) const;

	void	SetRotationX(float angle);						// NOTE: Angle in radians.
	void	SetRotationY(float angle);						// NOTE: Angle in radians.
	void	SetRotationZ(float angle);

	void	SetRotationAxis(float angle, const NsVector3& axis);

	friend void		TransposeMultiply(const NsMatrix3 &inv, const NsMatrix3 &b, NsMatrix3 &dst);
	friend NsMatrix3	SkewSymmetric(NsVector3 const &src);

public:

	// Creates a rotation matrix that rotates vector 'from' into another vector 'to'.
	//
	static NsMatrix3	CreateRotation(const NsVector3& vFrom, const NsVector3& vTo);

	static NsMatrix3 CreateIdentity();

public:
	static const NsMatrix3	mat3_zero;
	static const NsMatrix3	mat3_identity;

private:
	NsVector3		mColumns[ 3 ];	// stored in column-major order
};

inline NsMatrix3 NsMatrix3::CreateIdentity()
{
	return NsMatrix3(
	NsVector3(1.0f, 0.0f, 0.0f),
	NsVector3(0.0f, 1.0f, 0.0f),
	NsVector3(0.0f, 0.0f, 1.0f));
}

inline NsMatrix4 NsMatrix3::ToMatrix4() const
{
	// NOTE: NsMatrix3 is transposed because it is column-major.
	return NsMatrix4(	mColumns[0][0],	mColumns[1][0],	mColumns[2][0],	0.0f,
					mColumns[0][1],	mColumns[1][1],	mColumns[2][1],	0.0f,
					mColumns[0][2],	mColumns[1][2],	mColumns[2][2],	0.0f,
					0.0f,			0.0f,			0.0f,			1.0f );
}

inline NsMatrix3::NsMatrix3(void) {
}

inline NsMatrix3::NsMatrix3(const NsVector3 &x, const NsVector3 &y, const NsVector3 &z) {
	mColumns[ 0 ].x = x.x; mColumns[ 0 ].y = x.y; mColumns[ 0 ].z = x.z;
	mColumns[ 1 ].x = y.x; mColumns[ 1 ].y = y.y; mColumns[ 1 ].z = y.z;
	mColumns[ 2 ].x = z.x; mColumns[ 2 ].y = z.y; mColumns[ 2 ].z = z.z;
}

inline NsMatrix3::NsMatrix3(const float xx, const float xy, const float xz, const float yx, const float yy, const float yz, const float zx, const float zy, const float zz) {
	mColumns[ 0 ].x = xx; mColumns[ 0 ].y = xy; mColumns[ 0 ].z = xz;
	mColumns[ 1 ].x = yx; mColumns[ 1 ].y = yy; mColumns[ 1 ].z = yz;
	mColumns[ 2 ].x = zx; mColumns[ 2 ].y = zy; mColumns[ 2 ].z = zz;
}

inline NsMatrix3::NsMatrix3(const float src[ 3 ][ 3 ]) {
	memcpy(mColumns, src, 3 * 3 * sizeof(float));
}

inline const NsVector3 &NsMatrix3::operator[](int index) const {
	//Assert((index >= 0) && (index < 3));
	return mColumns[ index ];
}

inline NsVector3 &NsMatrix3::operator[](int index) {
	//Assert((index >= 0) && (index < 3));
	return mColumns[ index ];
}

inline NsMatrix3 NsMatrix3::operator-() const {
	return NsMatrix3(	-mColumns[0][0], -mColumns[0][1], -mColumns[0][2],
					-mColumns[1][0], -mColumns[1][1], -mColumns[1][2],
					-mColumns[2][0], -mColumns[2][1], -mColumns[2][2]);
}

inline NsVector3 NsMatrix3::operator*(const NsVector3 &vec) const {
	return NsVector3(
		mColumns[ 0 ].x * vec.x + mColumns[ 1 ].x * vec.y + mColumns[ 2 ].x * vec.z,
		mColumns[ 0 ].y * vec.x + mColumns[ 1 ].y * vec.y + mColumns[ 2 ].y * vec.z,
		mColumns[ 0 ].z * vec.x + mColumns[ 1 ].z * vec.y + mColumns[ 2 ].z * vec.z);
}

inline NsMatrix3 NsMatrix3::operator*(const NsMatrix3 &a) const {
	int i, j;
	const float *m1Ptr, *m2Ptr;
	float *dstPtr;
	NsMatrix3 dst;

	m1Ptr = reinterpret_cast<const float *>(this);
	m2Ptr = reinterpret_cast<const float *>(&a);
	dstPtr = reinterpret_cast<float *>(&dst);

	for (i = 0; i < 3; i++) {
		for (j = 0; j < 3; j++) {
			*dstPtr = m1Ptr[0] * m2Ptr[ 0 * 3 + j ]
					+ m1Ptr[1] * m2Ptr[ 1 * 3 + j ]
					+ m1Ptr[2] * m2Ptr[ 2 * 3 + j ];
			dstPtr++;
		}
		m1Ptr += 3;
	}

	return dst;
}

inline NsMatrix3 NsMatrix3::operator*(const float a) const {
	return NsMatrix3(
		mColumns[0].x * a, mColumns[0].y * a, mColumns[0].z * a,
		mColumns[1].x * a, mColumns[1].y * a, mColumns[1].z * a,
		mColumns[2].x * a, mColumns[2].y * a, mColumns[2].z * a);
}

inline NsMatrix3 NsMatrix3::operator+(const NsMatrix3 &a) const {
	return NsMatrix3(
		mColumns[0].x + a[0].x, mColumns[0].y + a[0].y, mColumns[0].z + a[0].z,
		mColumns[1].x + a[1].x, mColumns[1].y + a[1].y, mColumns[1].z + a[1].z,
		mColumns[2].x + a[2].x, mColumns[2].y + a[2].y, mColumns[2].z + a[2].z);
}
    
inline NsMatrix3 NsMatrix3::operator-(const NsMatrix3 &a) const {
	return NsMatrix3(
		mColumns[0].x - a[0].x, mColumns[0].y - a[0].y, mColumns[0].z - a[0].z,
		mColumns[1].x - a[1].x, mColumns[1].y - a[1].y, mColumns[1].z - a[1].z,
		mColumns[2].x - a[2].x, mColumns[2].y - a[2].y, mColumns[2].z - a[2].z);
}

inline NsMatrix3 &NsMatrix3::operator*=(const float a) {
	mColumns[0].x *= a; mColumns[0].y *= a; mColumns[0].z *= a;
	mColumns[1].x *= a; mColumns[1].y *= a; mColumns[1].z *= a; 
	mColumns[2].x *= a; mColumns[2].y *= a; mColumns[2].z *= a;

    return *this;
}

inline NsMatrix3 &NsMatrix3::operator*=(const NsMatrix3 &a) {
	int i, j;
	const float *m2Ptr;
	float *m1Ptr, dst[3];

	m1Ptr = reinterpret_cast<float *>(this);
	m2Ptr = reinterpret_cast<const float *>(&a);

	for (i = 0; i < 3; i++) {
		for (j = 0; j < 3; j++) {
			dst[j]  = m1Ptr[0] * m2Ptr[ 0 * 3 + j ]
					+ m1Ptr[1] * m2Ptr[ 1 * 3 + j ]
					+ m1Ptr[2] * m2Ptr[ 2 * 3 + j ];
		}
		m1Ptr[0] = dst[0]; m1Ptr[1] = dst[1]; m1Ptr[2] = dst[2];
		m1Ptr += 3;
	}

	return *this;
}

inline NsMatrix3 &NsMatrix3::operator+=(const NsMatrix3 &a) {
	mColumns[0].x += a[0].x; mColumns[0].y += a[0].y; mColumns[0].z += a[0].z;
	mColumns[1].x += a[1].x; mColumns[1].y += a[1].y; mColumns[1].z += a[1].z;
	mColumns[2].x += a[2].x; mColumns[2].y += a[2].y; mColumns[2].z += a[2].z;

    return *this;
}

inline NsMatrix3 &NsMatrix3::operator-=(const NsMatrix3 &a) {
	mColumns[0].x -= a[0].x; mColumns[0].y -= a[0].y; mColumns[0].z -= a[0].z;
	mColumns[1].x -= a[1].x; mColumns[1].y -= a[1].y; mColumns[1].z -= a[1].z;
	mColumns[2].x -= a[2].x; mColumns[2].y -= a[2].y; mColumns[2].z -= a[2].z;

    return *this;
}

inline NsVector3 operator*(const NsVector3 &vec, const NsMatrix3 &mat) {
	return mat * vec;
}

inline NsMatrix3 operator*(const float a, const NsMatrix3 &mat) {
	return mat * a;
}

inline NsVector3 &operator*=(NsVector3 &vec, const NsMatrix3 &mat) {
	float x = mat[ 0 ].x * vec.x + mat[ 1 ].x * vec.y + mat[ 2 ].x * vec.z;
	float y = mat[ 0 ].y * vec.x + mat[ 1 ].y * vec.y + mat[ 2 ].y * vec.z;
	vec.z = mat[ 0 ].z * vec.x + mat[ 1 ].z * vec.y + mat[ 2 ].z * vec.z;
	vec.x = x;
	vec.y = y;
	return vec;
}

inline bool NsMatrix3::Compare(const NsMatrix3 &a) const {
	if (mColumns[0].Compare(a[0]) &&
		mColumns[1].Compare(a[1]) &&
		mColumns[2].Compare(a[2])) {
		return true;
	}
	return false;
}

inline bool NsMatrix3::Compare(const NsMatrix3 &a, const float epsilon) const {
	if (mColumns[0].Compare(a[0], epsilon) &&
		mColumns[1].Compare(a[1], epsilon) &&
		mColumns[2].Compare(a[2], epsilon)) {
		return true;
	}
	return false;
}

inline bool NsMatrix3::operator==(const NsMatrix3 &a) const {
	return Compare(a);
}

inline bool NsMatrix3::operator!=(const NsMatrix3 &a) const {
	return !Compare(a);
}

inline
void NsMatrix3::Set(
		float e00, float e01, float e02,
		float e10, float e11, float e12,
		float e20, float e21, float e22)
{
	mColumns[0].Set(e00, e10, e20);
	mColumns[1].Set(e01, e11, e21);
	mColumns[2].Set(e02, e12, e22);
}

inline void NsMatrix3::SetZero(void) {
	NsMemory::Set(mColumns, 0, sizeof(NsMatrix3));
}

inline bool NsMatrix3::IsIdentity(const float epsilon) const {
	return Compare(mat3_identity, epsilon);
}

inline bool NsMatrix3::IsSymmetric(const float epsilon) const {
	if (NsMath::Abs(mColumns[0][1] - mColumns[1][0]) > epsilon) {
		return false;
	}
	if (NsMath::Abs(mColumns[0][2] - mColumns[2][0]) > epsilon) {
		return false;
	}
	if (NsMath::Abs(mColumns[1][2] - mColumns[2][1]) > epsilon) {
		return false;
	}
	return true;
}

inline bool NsMatrix3::IsDiagonal(const float epsilon) const {
	if (NsMath::Abs(mColumns[0][1]) > epsilon ||
		NsMath::Abs(mColumns[0][2]) > epsilon ||
		NsMath::Abs(mColumns[1][0]) > epsilon ||
		NsMath::Abs(mColumns[1][2]) > epsilon ||
		NsMath::Abs(mColumns[2][0]) > epsilon ||
		NsMath::Abs(mColumns[2][1]) > epsilon) {
		return false;
	}
	return true;
}

inline bool NsMatrix3::IsRotated(void) const {
	return !Compare(mat3_identity);
}

inline void NsMatrix3::ProjectVector(const NsVector3 &src, NsVector3 &dst) const {
	dst.x = src * mColumns[ 0 ];
	dst.y = src * mColumns[ 1 ];
	dst.z = src * mColumns[ 2 ];
}

inline void NsMatrix3::UnprojectVector(const NsVector3 &src, NsVector3 &dst) const {
	dst = mColumns[ 0 ] * src.x + mColumns[ 1 ] * src.y + mColumns[ 2 ] * src.z;
}

inline bool NsMatrix3::FixDegeneracies(void) {
	bool r = mColumns[0].FixDegenerateNormal();
	r |= mColumns[1].FixDegenerateNormal();
	r |= mColumns[2].FixDegenerateNormal();
	return r;
}

inline bool NsMatrix3::FixDenormals(void) {
	bool r = mColumns[0].FixDenormals();
	r |= mColumns[1].FixDenormals();
	r |= mColumns[2].FixDenormals();
	return r;
}

inline float NsMatrix3::Trace(void) const {
	return (mColumns[0][0] + mColumns[1][1] + mColumns[2][2]);
}

inline NsMatrix3 NsMatrix3::OrthoNormalize(void) const {
	NsMatrix3 ortho;

	ortho = *this;
	ortho[ 0 ].Normalize();
	ortho[ 2 ].Cross(mColumns[ 0 ], mColumns[ 1 ]);
	ortho[ 2 ].Normalize();
	ortho[ 1 ].Cross(mColumns[ 2 ], mColumns[ 0 ]);
	ortho[ 1 ].Normalize();
	return ortho;
}

inline NsMatrix3 &NsMatrix3::OrthoNormalizeSelf(void) {
	mColumns[ 0 ].Normalize();
	mColumns[ 2 ].Cross(mColumns[ 0 ], mColumns[ 1 ]);
	mColumns[ 2 ].Normalize();
	mColumns[ 1 ].Cross(mColumns[ 2 ], mColumns[ 0 ]);
	mColumns[ 1 ].Normalize();
	return *this;
}

inline NsMatrix3 NsMatrix3::Transpose(void) const {
	return NsMatrix3(	mColumns[0][0], mColumns[1][0], mColumns[2][0],
					mColumns[0][1], mColumns[1][1], mColumns[2][1],
					mColumns[0][2], mColumns[1][2], mColumns[2][2]);
}

inline NsMatrix3 &NsMatrix3::TransposeSelf(void) {
	float tmp0, tmp1, tmp2;

	tmp0 = mColumns[0][1];
	mColumns[0][1] = mColumns[1][0];
	mColumns[1][0] = tmp0;
	tmp1 = mColumns[0][2];
	mColumns[0][2] = mColumns[2][0];
	mColumns[2][0] = tmp1;
	tmp2 = mColumns[1][2];
	mColumns[1][2] = mColumns[2][1];
	mColumns[2][1] = tmp2;

	return *this;
}

inline NsMatrix3 NsMatrix3::Inverse(void) const {
	NsMatrix3 invMat;

	invMat = *this;
	invMat.InverseSelf();
	return invMat;
}

inline NsMatrix3 NsMatrix3::InverseFast(void) const {
	NsMatrix3 invMat;

	invMat = *this;
	invMat.InverseFastSelf();
	return invMat;
}

inline NsMatrix3 NsMatrix3::TransposeMultiply(const NsMatrix3 &b) const {
	return NsMatrix3(	mColumns[0].x * b[0].x + mColumns[1].x * b[1].x + mColumns[2].x * b[2].x,
					mColumns[0].x * b[0].y + mColumns[1].x * b[1].y + mColumns[2].x * b[2].y,
					mColumns[0].x * b[0].z + mColumns[1].x * b[1].z + mColumns[2].x * b[2].z,
					mColumns[0].y * b[0].x + mColumns[1].y * b[1].x + mColumns[2].y * b[2].x,
					mColumns[0].y * b[0].y + mColumns[1].y * b[1].y + mColumns[2].y * b[2].y,
					mColumns[0].y * b[0].z + mColumns[1].y * b[1].z + mColumns[2].y * b[2].z,
					mColumns[0].z * b[0].x + mColumns[1].z * b[1].x + mColumns[2].z * b[2].x,
					mColumns[0].z * b[0].y + mColumns[1].z * b[1].y + mColumns[2].z * b[2].y,
					mColumns[0].z * b[0].z + mColumns[1].z * b[1].z + mColumns[2].z * b[2].z);
}

inline void TransposeMultiply(const NsMatrix3 &transpose, const NsMatrix3 &b, NsMatrix3 &dst) {
	dst[0].x = transpose[0].x * b[0].x + transpose[1].x * b[1].x + transpose[2].x * b[2].x;
	dst[0].y = transpose[0].x * b[0].y + transpose[1].x * b[1].y + transpose[2].x * b[2].y;
	dst[0].z = transpose[0].x * b[0].z + transpose[1].x * b[1].z + transpose[2].x * b[2].z;
	dst[1].x = transpose[0].y * b[0].x + transpose[1].y * b[1].x + transpose[2].y * b[2].x;
	dst[1].y = transpose[0].y * b[0].y + transpose[1].y * b[1].y + transpose[2].y * b[2].y;
	dst[1].z = transpose[0].y * b[0].z + transpose[1].y * b[1].z + transpose[2].y * b[2].z;
	dst[2].x = transpose[0].z * b[0].x + transpose[1].z * b[1].x + transpose[2].z * b[2].x;
	dst[2].y = transpose[0].z * b[0].y + transpose[1].z * b[1].y + transpose[2].z * b[2].y;
	dst[2].z = transpose[0].z * b[0].z + transpose[1].z * b[1].z + transpose[2].z * b[2].z;
}

inline NsMatrix3 SkewSymmetric(NsVector3 const &src) {
	return NsMatrix3(
		0.0f,	-src.z,	src.y,
		src.z,	0.0f,	-src.x,
		-src.y,	src.x,	0.0f
	);
}

inline int NsMatrix3::GetDimension(void) const {
	return 9;
}

inline const float *NsMatrix3::ToFloatPtr(void) const {
	return mColumns[0].ToFloatPtr();
}

inline float *NsMatrix3::ToFloatPtr(void) {
	return mColumns[0].ToFloatPtr();
}

inline void NsMatrix3::SetRotationAxis(float angle, const NsVector3& axis)
{
	float s, c;
	NsMath::SinCos(angle, s, c);

	const float xy = axis.x * axis.y;
	const float yz = axis.y * axis.z;
	const float zx = axis.z * axis.x;
	const float xs = axis.x * s;
	const float ys = axis.y * s;
	const float zs = axis.z * s;
	const float oneMinusC = 1.0f - c;

	mColumns[0].Set(
		oneMinusC * axis.x * axis.x + c,
		oneMinusC * xy + zs,
		oneMinusC * zx - ys
	);
	mColumns[1].Set(
		oneMinusC * xy - zs,
		oneMinusC * axis.y * axis.y + c,
		oneMinusC * yz + xs
	);
	mColumns[2].Set(
		oneMinusC * zx + ys,
		oneMinusC * yz - xs,
		oneMinusC * axis.z * axis.z + c
	);
}

inline void NsMatrix3::SetRotationX(float angle)
{
	float fSin, fCos;
	NsMath::SinCos(angle, fSin, fCos);

	mColumns[0][0] = 1.0f;		mColumns[1][0] = 0.0f;		mColumns[2][0] = 0.0f;
	mColumns[0][1] = 0.0f;		mColumns[1][1] = fCos;		mColumns[2][1] = -fSin;
	mColumns[0][2] = 0.0f;		mColumns[1][2] = fSin;		mColumns[2][2] = fCos;
}

inline void NsMatrix3::SetRotationY(float angle)
{
	float fSin, fCos;
	NsMath::SinCos(angle, fSin, fCos);

	mColumns[0][0] = fCos;		mColumns[1][0] = 0.0f;		mColumns[2][0] = fSin;
	mColumns[0][1] = 0.0f;		mColumns[1][1] = 1.0f;		mColumns[2][1] = 0.0f;
	mColumns[0][2] = -fSin;		mColumns[1][2] = 0.0f;		mColumns[2][2] = fCos;
}

inline void NsMatrix3::SetRotationZ(float angle)
{
	float fSin, fCos;
	NsMath::SinCos(angle, fSin, fCos);

	mColumns[0][0] = fCos;		mColumns[1][0] = -fSin;		mColumns[2][0] = 0.0f;
	mColumns[0][1] = fSin;		mColumns[1][1] = fCos;		mColumns[2][1] = 0.0f;
	mColumns[0][2] = 0.0f;		mColumns[1][2] = 0.0f;		mColumns[2][2] = 1.0f;
}