#pragma once
#include <math.h>

#define PI float(3.1415926535897932384626433832795028841971693993751f)
#define ONEFOURTH_PI float(0.785398163f)
#define DEG2RAD float(PI/180.0f)
#define RAD2DEG float(180.0f/PI)

class NsMath
{
public:
	static float Abs(float value)
	{
		return ::fabs(value);
	}

	static float Sqrt(float value)
	{
		return ::sqrtf(value);
	}

	static float InvSqrt(float value)
	{
		return 1.0f / ::sqrtf(value);
	}

	static float Floor(float value)
	{
		return ::floorf(value);
	}

	static float Tan(float value)
	{
		return ::tan(value);
	}

	inline static int Rint(float value)
	{
		return (int)::floorf(value + 0.5f);
	}

	inline static float Deg2Rad(float value)
	{
		return value*DEG2RAD;
	}

	inline static float Rad2Deg(float value)
	{
		return value*RAD2DEG;
	}

	inline static float Clampf(float x, float min, float max)
	{
		return (x < min) ? min : (x > max) ? max : x;
	}

	inline static void SinCos(float value, float & sinValue, float & cosValue)
	{
		sinValue = ::sin(value);
		cosValue = ::cos(value);
	}

	static void mul_mat4_mat4( const float * __restrict m1, const float* __restrict m2, float * __restrict m)
	{
		m[0] = m1[0]*m2[0] + m1[4]*m2[1] + m1[8]*m2[2] + m1[12]*m2[3];
		m[1] = m1[1]*m2[0] + m1[5]*m2[1] + m1[9]*m2[2] + m1[13]*m2[3];
		m[2] = m1[2]*m2[0] + m1[6]*m2[1] + m1[10]*m2[2] + m1[14]*m2[3];
		m[3] = m1[3]*m2[0] + m1[7]*m2[1] + m1[11]*m2[2] + m1[15]*m2[3];

		m[4] = m1[0]*m2[4] + m1[4]*m2[5] + m1[8]*m2[6] + m1[12]*m2[7];
		m[5] = m1[1]*m2[4] + m1[5]*m2[5] + m1[9]*m2[6] + m1[13]*m2[7];
		m[6] = m1[2]*m2[4] + m1[6]*m2[5] + m1[10]*m2[6] + m1[14]*m2[7];
		m[7] = m1[3]*m2[4] + m1[7]*m2[5] + m1[11]*m2[6] + m1[15]*m2[7];

		m[8] = m1[0]*m2[8] + m1[4]*m2[9] + m1[8]*m2[10] + m1[12]*m2[11];
		m[9] = m1[1]*m2[8] + m1[5]*m2[9] + m1[9]*m2[10] + m1[13]*m2[11];
		m[10] = m1[2]*m2[8] + m1[6]*m2[9] + m1[10]*m2[10] + m1[14]*m2[11];
		m[11] = m1[3]*m2[8] + m1[7]*m2[9] + m1[11]*m2[10] + m1[15]*m2[11];

		m[12] = m1[0]*m2[12] + m1[4]*m2[13] + m1[8]*m2[14] + m1[12]*m2[15];
		m[13] = m1[1]*m2[12] + m1[5]*m2[13] + m1[9]*m2[14] + m1[13]*m2[15];
		m[14] = m1[2]*m2[12] + m1[6]*m2[13] + m1[10]*m2[14] + m1[14]*m2[15];
		m[15] = m1[3]*m2[12] + m1[7]*m2[13] + m1[11]*m2[14] + m1[15]*m2[15];
	}
};