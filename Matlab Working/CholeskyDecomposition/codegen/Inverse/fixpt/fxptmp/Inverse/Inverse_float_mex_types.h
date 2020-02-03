/*
 * Inverse_float_mex_types.h
 *
 * Code generation for function 'Inverse'
 *
 */

#ifndef INVERSE_FLOAT_MEX_TYPES_H
#define INVERSE_FLOAT_MEX_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
#ifndef struct_emxArray_boolean_T
#define struct_emxArray_boolean_T

struct emxArray_boolean_T
{
  boolean_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_boolean_T*/

#ifndef typedef_emxArray_boolean_T
#define typedef_emxArray_boolean_T

typedef struct emxArray_boolean_T emxArray_boolean_T;

#endif                                 /*typedef_emxArray_boolean_T*/

#ifndef struct_emxArray_char_T_1x0
#define struct_emxArray_char_T_1x0

struct emxArray_char_T_1x0
{
  int32_T size[2];
};

#endif                                 /*struct_emxArray_char_T_1x0*/

#ifndef typedef_emxArray_char_T_1x0
#define typedef_emxArray_char_T_1x0

typedef struct emxArray_char_T_1x0 emxArray_char_T_1x0;

#endif                                 /*typedef_emxArray_char_T_1x0*/

#ifndef struct_emxArray_char_T_1x6
#define struct_emxArray_char_T_1x6

struct emxArray_char_T_1x6
{
  char_T data[6];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_char_T_1x6*/

#ifndef typedef_emxArray_char_T_1x6
#define typedef_emxArray_char_T_1x6

typedef struct emxArray_char_T_1x6 emxArray_char_T_1x6;

#endif                                 /*typedef_emxArray_char_T_1x6*/

#ifndef struct_emxArray_char_T_1x7
#define struct_emxArray_char_T_1x7

struct emxArray_char_T_1x7
{
  char_T data[7];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_char_T_1x7*/

#ifndef typedef_emxArray_char_T_1x7
#define typedef_emxArray_char_T_1x7

typedef struct emxArray_char_T_1x7 emxArray_char_T_1x7;

#endif                                 /*typedef_emxArray_char_T_1x7*/

#ifndef struct_emxArray_int32_T
#define struct_emxArray_int32_T

struct emxArray_int32_T
{
  int32_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_int32_T*/

#ifndef typedef_emxArray_int32_T
#define typedef_emxArray_int32_T

typedef struct emxArray_int32_T emxArray_int32_T;

#endif                                 /*typedef_emxArray_int32_T*/

#ifndef struct_emxArray_real_T_1x2
#define struct_emxArray_real_T_1x2

struct emxArray_real_T_1x2
{
  real_T data[2];
  int32_T size[2];
};

#endif                                 /*struct_emxArray_real_T_1x2*/

#ifndef typedef_emxArray_real_T_1x2
#define typedef_emxArray_real_T_1x2

typedef struct emxArray_real_T_1x2 emxArray_real_T_1x2;

#endif                                 /*typedef_emxArray_real_T_1x2*/

#ifndef struct_emxArray_uint8_T
#define struct_emxArray_uint8_T

struct emxArray_uint8_T
{
  uint8_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_uint8_T*/

#ifndef typedef_emxArray_uint8_T
#define typedef_emxArray_uint8_T

typedef struct emxArray_uint8_T emxArray_uint8_T;

#endif                                 /*typedef_emxArray_uint8_T*/

#ifndef struct_sd12NPd4F33WnOQfJWxBMLE_tag
#define struct_sd12NPd4F33WnOQfJWxBMLE_tag

struct sd12NPd4F33WnOQfJWxBMLE_tag
{
  emxArray_char_T_1x6 Class;
  emxArray_real_T_1x2 Dims;
  boolean_T Varsize;
  emxArray_char_T_1x0 NumericType;
  emxArray_char_T_1x0 Fimath;
  emxArray_uint8_T *Data;
  uint32_T DataSize;
};

#endif                                 /*struct_sd12NPd4F33WnOQfJWxBMLE_tag*/

#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct sd12NPd4F33WnOQfJWxBMLE_tag struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef struct_c_emxArray_sd12NPd4F33WnOQfJWxB
#define struct_c_emxArray_sd12NPd4F33WnOQfJWxB

struct c_emxArray_sd12NPd4F33WnOQfJWxB
{
  struct0_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_c_emxArray_sd12NPd4F33WnOQfJWxB*/

#ifndef typedef_emxArray_struct0_T
#define typedef_emxArray_struct0_T

typedef struct c_emxArray_sd12NPd4F33WnOQfJWxB emxArray_struct0_T;

#endif                                 /*typedef_emxArray_struct0_T*/

#ifndef struct_sBuuLb0HYEyEHoBRteARoLC_tag
#define struct_sBuuLb0HYEyEHoBRteARoLC_tag

struct sBuuLb0HYEyEHoBRteARoLC_tag
{
  uint32_T ActualIndex;
  emxArray_char_T_1x7 FieldNames;
};

#endif                                 /*struct_sBuuLb0HYEyEHoBRteARoLC_tag*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct sBuuLb0HYEyEHoBRteARoLC_tag struct1_T;

#endif                                 /*typedef_struct1_T*/

#ifndef struct_c_emxArray_sBuuLb0HYEyEHoBRteAR
#define struct_c_emxArray_sBuuLb0HYEyEHoBRteAR

struct c_emxArray_sBuuLb0HYEyEHoBRteAR
{
  struct1_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_c_emxArray_sBuuLb0HYEyEHoBRteAR*/

#ifndef typedef_emxArray_struct1_T
#define typedef_emxArray_struct1_T

typedef struct c_emxArray_sBuuLb0HYEyEHoBRteAR emxArray_struct1_T;

#endif                                 /*typedef_emxArray_struct1_T*/
#endif

/* End of code generation (Inverse_float_mex_types.h) */
