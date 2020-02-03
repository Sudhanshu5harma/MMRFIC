/*
 * custom_mex_logger.c
 *
 * Code generation for function 'custom_mex_logger'
 *
 */

/* Include files */
#include <string.h>
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "custom_mex_logger.h"
#include "Inverse_float_mex_emxutil.h"
#include "assertValidSizeArg.h"

/* Type Definitions */
#include <stddef.h>

/* Variable Definitions */
static emxArray_struct1_T *pIndexMap;
static boolean_T pIndexMap_not_empty;
static uint32_T pBufferLen;
static emxArray_struct0_T *pBuffers;
static boolean_T pBuffers_not_empty;
static boolean_T pInit_not_empty;
static emxArray_boolean_T *pEnabled;
static emlrtRSInfo q_emlrtRSI = { 1,   /* lineNo */
  "custom_mex_logger",                 /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p"/* pathName */
};

static emlrtRSInfo r_emlrtRSI = { 12,  /* lineNo */
  "nullAssignment",                    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pathName */
};

static emlrtRSInfo s_emlrtRSI = { 22,  /* lineNo */
  "repmat",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

static emlrtMCInfo c_emlrtMCI = { 1,   /* lineNo */
  1,                                   /* colNo */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p"/* pName */
};

static emlrtMCInfo d_emlrtMCI = { 41,  /* lineNo */
  5,                                   /* colNo */
  "repmat",                            /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pName */
};

static emlrtRTEInfo emlrtRTEI = { 1,   /* lineNo */
  1,                                   /* colNo */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p"/* pName */
};

static emlrtRTEInfo b_emlrtRTEI = { 1, /* lineNo */
  4,                                   /* colNo */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p"/* pName */
};

static emlrtRTEInfo c_emlrtRTEI = { 1, /* lineNo */
  11,                                  /* colNo */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p"/* pName */
};

static emlrtRTEInfo d_emlrtRTEI = { 160,/* lineNo */
  9,                                   /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtBCInfo emlrtBCI = { -1,    /* iFirst */
  -1,                                  /* iLast */
  1,                                   /* lineNo */
  1,                                   /* colNo */
  "",                                  /* aName */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p",/* pName */
  0                                    /* checkKind */
};

static emlrtRTEInfo g_emlrtRTEI = { 84,/* lineNo */
  27,                                  /* colNo */
  "nullAssignment",                    /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\nullAssignment.m"/* pName */
};

static emlrtECInfo emlrtECI = { -1,    /* nDims */
  1,                                   /* lineNo */
  1,                                   /* colNo */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p"/* pName */
};

static emlrtDCInfo emlrtDCI = { 1,     /* lineNo */
  1,                                   /* colNo */
  "custom_mex_logger",                 /* fName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\custom_mex_logger.p",/* pName */
  1                                    /* checkKind */
};

static emlrtRSInfo v_emlrtRSI = { 41,  /* lineNo */
  "repmat",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\elmat\\repmat.m"/* pathName */
};

/* Function Declarations */
static void b_buffers(const emlrtStack *sp, uint32_T idx, const char_T
                      arg_Class_data[], const int32_T arg_Class_size[2], const
                      real_T arg_Dims_data[], boolean_T arg_Varsize, const
                      emxArray_uint8_T *arg_Data, uint32_T arg_DataSize);
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y);
static void b_generic_logger_impl_val(const emlrtStack *sp, uint32_T idx_in,
  const real_T val_in[16]);
static uint32_T b_indexMapper(const emlrtStack *sp, uint32_T staticIdx);
static boolean_T buffers(const emlrtStack *sp, uint32_T idx);
static void c_buffers(const emlrtStack *sp, uint32_T idx, const uint8_T
                      arg_data[], const int32_T arg_size[2]);
static boolean_T customCoderEnableLog(const emlrtStack *sp, uint32_T buffId);
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *b_horzcat,
  const char_T *identifier, emxArray_boolean_T *y);
static void error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location);
static const mxArray *f2fCustomCoderEnableLogState(const emlrtStack *sp,
  emlrtMCInfo *location);
static void generic_logger_impl_val(const emlrtStack *sp, uint32_T idx_in, const
  real_T val_in[4]);
static const mxArray *horzcat(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location);
static boolean_T indexMapper(const emlrtStack *sp, uint32_T staticIdx);

/* Function Definitions */
static void b_buffers(const emlrtStack *sp, uint32_T idx, const char_T
                      arg_Class_data[], const int32_T arg_Class_size[2], const
                      real_T arg_Dims_data[], boolean_T arg_Varsize, const
                      emxArray_uint8_T *arg_Data, uint32_T arg_DataSize)
{
  struct0_T S;
  emxArray_struct0_T *hoistedGlobal;
  int32_T i9;
  struct0_T expl_temp;
  static const char_T valClass[5] = { 'u', 'i', 'n', 't', '8' };

  int32_T loop_ub;
  real_T d1;
  uint32_T varargin_2;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInitStruct_struct0_T(sp, &S, &c_emlrtRTEI, true);
  if (!pBuffers_not_empty) {
    S.Class.size[0] = 1;
    S.Class.size[1] = 5;
    for (i9 = 0; i9 < 5; i9++) {
      S.Class.data[i9] = valClass[i9];
    }

    S.Dims.size[0] = 1;
    S.Dims.size[1] = 2;
    for (i9 = 0; i9 < 2; i9++) {
      S.Dims.data[i9] = 1.0;
    }

    S.Varsize = false;
    S.NumericType.size[0] = 1;
    S.NumericType.size[1] = 0;
    S.Fimath.size[0] = 1;
    S.Fimath.size[1] = 0;
    i9 = S.Data->size[0] * S.Data->size[1];
    S.Data->size[0] = 1;
    S.Data->size[1] = 1;
    emxEnsureCapacity_uint8_T(sp, S.Data, i9, &c_emlrtRTEI);
    S.Data->data[0] = 0U;
    S.DataSize = 1U;
    i9 = pBuffers->size[0] * pBuffers->size[1];
    pBuffers->size[0] = 1;
    pBuffers->size[1] = 1;
    emxEnsureCapacity_struct0_T(sp, pBuffers, i9, &c_emlrtRTEI);
    emxCopyStruct_struct0_T(sp, &pBuffers->data[0], &S, &emlrtRTEI);
    pBuffers_not_empty = true;
  }

  if ((real_T)idx > pBuffers->size[1]) {
    emxInit_struct0_T(sp, &hoistedGlobal, 2, &c_emlrtRTEI, true);
    i9 = hoistedGlobal->size[0] * hoistedGlobal->size[1];
    hoistedGlobal->size[0] = 1;
    hoistedGlobal->size[1] = pBuffers->size[1];
    emxEnsureCapacity_struct0_T(sp, hoistedGlobal, i9, &c_emlrtRTEI);
    loop_ub = pBuffers->size[0] * pBuffers->size[1];
    for (i9 = 0; i9 < loop_ub; i9++) {
      emxCopyStruct_struct0_T(sp, &hoistedGlobal->data[i9], &pBuffers->data[i9],
        &emlrtRTEI);
    }

    st.site = &q_emlrtRSI;
    emxCopyStruct_struct0_T(&st, &S, &pBuffers->data[0], &c_emlrtRTEI);
    d1 = (real_T)idx - (real_T)pBuffers->size[1];
    if (d1 < 4.294967296E+9) {
      if (d1 >= 0.0) {
        varargin_2 = (uint32_T)d1;
      } else {
        varargin_2 = 0U;
      }
    } else {
      varargin_2 = MAX_uint32_T;
    }

    b_st.site = &s_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_2);
    i9 = pBuffers->size[0] * pBuffers->size[1];
    pBuffers->size[0] = 1;
    pBuffers->size[1] = hoistedGlobal->size[1] + (int32_T)varargin_2;
    emxEnsureCapacity_struct0_T(sp, pBuffers, i9, &c_emlrtRTEI);
    loop_ub = hoistedGlobal->size[1];
    for (i9 = 0; i9 < loop_ub; i9++) {
      emxCopyStruct_struct0_T(sp, &pBuffers->data[pBuffers->size[0] * i9],
        &hoistedGlobal->data[hoistedGlobal->size[0] * i9], &c_emlrtRTEI);
    }

    loop_ub = (int32_T)varargin_2;
    for (i9 = 0; i9 < loop_ub; i9++) {
      emxCopyStruct_struct0_T(sp, &pBuffers->data[pBuffers->size[0] * (i9 +
        hoistedGlobal->size[1])], &S, &c_emlrtRTEI);
    }

    emxFree_struct0_T(sp, &hoistedGlobal);
    pBuffers_not_empty = true;
  }

  emxFreeStruct_struct0_T(sp, &S);
  emxInitStruct_struct0_T(sp, &expl_temp, &emlrtRTEI, true);
  expl_temp.Class.size[0] = 1;
  expl_temp.Class.size[1] = arg_Class_size[1];
  loop_ub = arg_Class_size[0] * arg_Class_size[1];
  if (0 <= loop_ub - 1) {
    memcpy(&expl_temp.Class.data[0], &arg_Class_data[0], (uint32_T)(loop_ub *
            (int32_T)sizeof(char_T)));
  }

  expl_temp.Dims.size[0] = 1;
  expl_temp.Dims.size[1] = 2;
  for (i9 = 0; i9 < 2; i9++) {
    expl_temp.Dims.data[i9] = arg_Dims_data[i9];
  }

  expl_temp.Varsize = arg_Varsize;
  expl_temp.NumericType.size[0] = 1;
  expl_temp.NumericType.size[1] = 0;
  expl_temp.Fimath.size[0] = 1;
  expl_temp.Fimath.size[1] = 0;
  i9 = expl_temp.Data->size[0] * expl_temp.Data->size[1];
  expl_temp.Data->size[0] = 1;
  expl_temp.Data->size[1] = arg_Data->size[1];
  emxEnsureCapacity_uint8_T(sp, expl_temp.Data, i9, &c_emlrtRTEI);
  loop_ub = arg_Data->size[0] * arg_Data->size[1];
  for (i9 = 0; i9 < loop_ub; i9++) {
    expl_temp.Data->data[i9] = arg_Data->data[i9];
  }

  expl_temp.DataSize = arg_DataSize;
  i9 = pBuffers->size[1];
  loop_ub = (int32_T)idx;
  if (!((loop_ub >= 1) && (loop_ub <= i9))) {
    emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i9, &emlrtBCI, sp);
  }

  emxCopyStruct_struct0_T(sp, &pBuffers->data[loop_ub - 1], &expl_temp,
    &emlrtRTEI);
  emxFreeStruct_struct0_T(sp, &expl_temp);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, emxArray_boolean_T *y)
{
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static void b_generic_logger_impl_val(const emlrtStack *sp, uint32_T idx_in,
  const real_T val_in[16])
{
  int32_T t0_Class_size[2];
  real_T val_in_data[16];
  int32_T i17;
  int32_T bytes_size[2];
  char_T t0_Class_data[6];
  static const char_T valClass[6] = { 'd', 'o', 'u', 'b', 'l', 'e' };

  uint8_T bytes_data[128];
  emxArray_uint8_T *t0_Data;
  real_T t0_Dims_data[2];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (idx_in > 1U) {
    st.site = &q_emlrtRSI;
    if (!buffers(&st, idx_in)) {
      t0_Class_size[0] = 1;
      t0_Class_size[1] = 6;
      for (i17 = 0; i17 < 6; i17++) {
        t0_Class_data[i17] = valClass[i17];
      }

      for (i17 = 0; i17 < 2; i17++) {
        t0_Dims_data[i17] = 4.0;
      }

      emxInit_uint8_T(sp, &t0_Data, 2, &c_emlrtRTEI, true);
      i17 = t0_Data->size[0] * t0_Data->size[1];
      t0_Data->size[0] = 1;
      t0_Data->size[1] = 1;
      emxEnsureCapacity_uint8_T(sp, t0_Data, i17, &c_emlrtRTEI);
      t0_Data->data[0] = 0U;
      st.site = &q_emlrtRSI;
      b_buffers(&st, idx_in, t0_Class_data, t0_Class_size, t0_Dims_data, false,
                t0_Data, 1U);
      emxFree_uint8_T(sp, &t0_Data);
    }

    st.site = &q_emlrtRSI;
    memcpy(&val_in_data[0], &val_in[0], sizeof(real_T) << 4);
    bytes_size[0] = 1;
    bytes_size[1] = 128;
    memcpy((void *)&bytes_data[0], (void *)&val_in_data[0], (uint32_T)((size_t)
            128 * sizeof(uint8_T)));
    st.site = &q_emlrtRSI;
    c_buffers(&st, idx_in, bytes_data, bytes_size);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static uint32_T b_indexMapper(const emlrtStack *sp, uint32_T staticIdx)
{
  uint32_T actualIdx;
  struct1_T S;
  int32_T i4;
  emxArray_struct1_T *hoistedGlobal;
  int32_T loop_ub;
  real_T d0;
  uint32_T varargin_2;
  const mxArray *y;
  int32_T i5;
  const mxArray *m2;
  static const int32_T iv3[2] = { 1, 15 };

  static const char_T u[15] = { 'M', 'A', 'T', 'L', 'A', 'B', ':', 'p', 'm', 'a',
    'x', 's', 'i', 'z', 'e' };

  static const char_T fieldNames[7] = { '_', 'r', 'e', ':', '_', 'i', 'm' };

  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (!pIndexMap_not_empty) {
    S.ActualIndex = 0U;
    S.FieldNames.size[0] = 1;
    S.FieldNames.size[1] = 0;
    i4 = pIndexMap->size[0] * pIndexMap->size[1];
    pIndexMap->size[0] = 1;
    pIndexMap->size[1] = 1;
    emxEnsureCapacity_struct1_T(sp, pIndexMap, i4, &c_emlrtRTEI);
    pIndexMap->data[0] = S;
    pIndexMap_not_empty = true;
    pBufferLen = 1U;
  }

  actualIdx = pBufferLen + 1U;
  if (actualIdx < pBufferLen) {
    actualIdx = MAX_uint32_T;
  }

  if ((real_T)staticIdx > pIndexMap->size[1]) {
    emxInit_struct1_T(sp, &hoistedGlobal, 2, &c_emlrtRTEI, true);
    i4 = hoistedGlobal->size[0] * hoistedGlobal->size[1];
    hoistedGlobal->size[0] = 1;
    hoistedGlobal->size[1] = pIndexMap->size[1];
    emxEnsureCapacity_struct1_T(sp, hoistedGlobal, i4, &c_emlrtRTEI);
    loop_ub = pIndexMap->size[0] * pIndexMap->size[1];
    for (i4 = 0; i4 < loop_ub; i4++) {
      hoistedGlobal->data[i4] = pIndexMap->data[i4];
    }

    st.site = &q_emlrtRSI;
    S = pIndexMap->data[0];
    d0 = (real_T)staticIdx - (real_T)pIndexMap->size[1];
    if (d0 < 4.294967296E+9) {
      if (d0 >= 0.0) {
        varargin_2 = (uint32_T)d0;
      } else {
        varargin_2 = 0U;
      }
    } else {
      varargin_2 = MAX_uint32_T;
    }

    b_st.site = &s_emlrtRSI;
    assertValidSizeArg(&b_st, varargin_2);
    if ((int8_T)varargin_2 != (int32_T)varargin_2) {
      y = NULL;
      m2 = emlrtCreateCharArray(2, iv3);
      emlrtInitCharArrayR2013a(&st, 15, m2, &u[0]);
      emlrtAssign(&y, m2);
      b_st.site = &v_emlrtRSI;
      error(&b_st, y, &d_emlrtMCI);
    }

    i4 = pIndexMap->size[0] * pIndexMap->size[1];
    pIndexMap->size[0] = 1;
    pIndexMap->size[1] = hoistedGlobal->size[1] + (int8_T)varargin_2;
    emxEnsureCapacity_struct1_T(sp, pIndexMap, i4, &c_emlrtRTEI);
    loop_ub = hoistedGlobal->size[1];
    for (i4 = 0; i4 < loop_ub; i4++) {
      pIndexMap->data[pIndexMap->size[0] * i4] = hoistedGlobal->
        data[hoistedGlobal->size[0] * i4];
    }

    loop_ub = (int8_T)varargin_2;
    for (i4 = 0; i4 < loop_ub; i4++) {
      pIndexMap->data[pIndexMap->size[0] * (i4 + hoistedGlobal->size[1])] = S;
    }

    emxFree_struct1_T(sp, &hoistedGlobal);
    pIndexMap_not_empty = true;
  }

  i4 = pIndexMap->size[1];
  loop_ub = (int32_T)staticIdx;
  if (!((loop_ub >= 1) && (loop_ub <= i4))) {
    emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i4, &emlrtBCI, sp);
  }

  pIndexMap->data[loop_ub - 1].ActualIndex = actualIdx;
  i4 = pIndexMap->size[1];
  loop_ub = (int32_T)staticIdx;
  if (!((loop_ub >= 1) && (loop_ub <= i4))) {
    emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i4, &emlrtBCI, sp);
  }

  pIndexMap->data[loop_ub - 1].FieldNames.size[0] = 1;
  i4 = pIndexMap->size[1];
  loop_ub = (int32_T)staticIdx;
  if (!((loop_ub >= 1) && (loop_ub <= i4))) {
    emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i4, &emlrtBCI, sp);
  }

  pIndexMap->data[loop_ub - 1].FieldNames.size[1] = 7;
  i4 = pIndexMap->size[1];
  loop_ub = pIndexMap->size[1];
  i5 = (int32_T)staticIdx;
  if (!((i5 >= 1) && (i5 <= loop_ub))) {
    emlrtDynamicBoundsCheckR2012b(i5, 1, loop_ub, &emlrtBCI, sp);
  }

  loop_ub = pIndexMap->size[1];
  i5 = (int32_T)staticIdx;
  if (!((i5 >= 1) && (i5 <= loop_ub))) {
    emlrtDynamicBoundsCheckR2012b(i5, 1, loop_ub, &emlrtBCI, sp);
  }

  for (loop_ub = 0; loop_ub < 7; loop_ub++) {
    i5 = (int32_T)staticIdx;
    if (!((i5 >= 1) && (i5 <= i4))) {
      emlrtDynamicBoundsCheckR2012b(i5, 1, i4, &emlrtBCI, sp);
    }

    pIndexMap->data[i5 - 1].FieldNames.data[loop_ub] = fieldNames[loop_ub];
  }

  varargin_2 = pBufferLen + 2U;
  if (varargin_2 < pBufferLen) {
    varargin_2 = MAX_uint32_T;
  }

  pBufferLen = varargin_2;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return actualIdx;
}

static boolean_T buffers(const emlrtStack *sp, uint32_T idx)
{
  boolean_T out;
  struct0_T S;
  int32_T i7;
  int32_T i8;
  static const char_T valClass[5] = { 'u', 'i', 'n', 't', '8' };

  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (!pBuffers_not_empty) {
    emxInitStruct_struct0_T(sp, &S, &c_emlrtRTEI, true);
    S.Class.size[0] = 1;
    S.Class.size[1] = 5;
    for (i7 = 0; i7 < 5; i7++) {
      S.Class.data[i7] = valClass[i7];
    }

    S.Dims.size[0] = 1;
    S.Dims.size[1] = 2;
    for (i7 = 0; i7 < 2; i7++) {
      S.Dims.data[i7] = 1.0;
    }

    S.Varsize = false;
    S.NumericType.size[0] = 1;
    S.NumericType.size[1] = 0;
    S.Fimath.size[0] = 1;
    S.Fimath.size[1] = 0;
    i7 = S.Data->size[0] * S.Data->size[1];
    S.Data->size[0] = 1;
    S.Data->size[1] = 1;
    emxEnsureCapacity_uint8_T(sp, S.Data, i7, &c_emlrtRTEI);
    S.Data->data[0] = 0U;
    S.DataSize = 1U;
    i7 = pBuffers->size[0] * pBuffers->size[1];
    pBuffers->size[0] = 1;
    pBuffers->size[1] = 1;
    emxEnsureCapacity_struct0_T(sp, pBuffers, i7, &c_emlrtRTEI);
    emxCopyStruct_struct0_T(sp, &pBuffers->data[0], &S, &emlrtRTEI);
    pBuffers_not_empty = true;
    emxFreeStruct_struct0_T(sp, &S);
  }

  if ((real_T)idx <= pBuffers->size[1]) {
    i7 = pBuffers->size[1];
    i8 = (int32_T)idx;
    if (!((i8 >= 1) && (i8 <= i7))) {
      emlrtDynamicBoundsCheckR2012b(i8, 1, i7, &emlrtBCI, sp);
    }

    if (pBuffers->data[i8 - 1].DataSize > 1U) {
      out = true;
    } else {
      out = false;
    }
  } else {
    out = false;
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return out;
}

static void c_buffers(const emlrtStack *sp, uint32_T idx, const uint8_T
                      arg_data[], const int32_T arg_size[2])
{
  struct0_T S;
  int32_T i10;
  int32_T i11;
  uint32_T size;
  static const char_T valClass[5] = { 'u', 'i', 'n', 't', '8' };

  real_T d2;
  uint32_T varargin_2;
  real_T varargin_1;
  emxArray_uint8_T *r0;
  uint32_T b_varargin_1;
  uint32_T qY;
  int32_T i12;
  emxArray_int32_T *r1;
  int32_T unnamed_idx_1;
  int32_T i13;
  int32_T loop_ub;
  int32_T i14;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (!pBuffers_not_empty) {
    emxInitStruct_struct0_T(sp, &S, &c_emlrtRTEI, true);
    S.Class.size[0] = 1;
    S.Class.size[1] = 5;
    for (i10 = 0; i10 < 5; i10++) {
      S.Class.data[i10] = valClass[i10];
    }

    S.Dims.size[0] = 1;
    S.Dims.size[1] = 2;
    for (i10 = 0; i10 < 2; i10++) {
      S.Dims.data[i10] = 1.0;
    }

    S.Varsize = false;
    S.NumericType.size[0] = 1;
    S.NumericType.size[1] = 0;
    S.Fimath.size[0] = 1;
    S.Fimath.size[1] = 0;
    i10 = S.Data->size[0] * S.Data->size[1];
    S.Data->size[0] = 1;
    S.Data->size[1] = 1;
    emxEnsureCapacity_uint8_T(sp, S.Data, i10, &c_emlrtRTEI);
    S.Data->data[0] = 0U;
    S.DataSize = 1U;
    i10 = pBuffers->size[0] * pBuffers->size[1];
    pBuffers->size[0] = 1;
    pBuffers->size[1] = 1;
    emxEnsureCapacity_struct0_T(sp, pBuffers, i10, &c_emlrtRTEI);
    emxCopyStruct_struct0_T(sp, &pBuffers->data[0], &S, &emlrtRTEI);
    pBuffers_not_empty = true;
    emxFreeStruct_struct0_T(sp, &S);
  }

  i10 = pBuffers->size[1];
  i11 = (int32_T)idx;
  if (!((i11 >= 1) && (i11 <= i10))) {
    emlrtDynamicBoundsCheckR2012b(i11, 1, i10, &emlrtBCI, sp);
  }

  size = pBuffers->data[i11 - 1].DataSize;
  i10 = pBuffers->size[1];
  i11 = (int32_T)idx;
  if (!((i11 >= 1) && (i11 <= i10))) {
    emlrtDynamicBoundsCheckR2012b(i11, 1, i10, &emlrtBCI, sp);
  }

  d2 = (real_T)pBuffers->data[(int32_T)idx - 1].DataSize + (real_T)arg_size[1];
  if (d2 < 4.294967296E+9) {
    if (d2 >= 0.0) {
      varargin_2 = (uint32_T)d2;
    } else {
      varargin_2 = 0U;
    }
  } else {
    varargin_2 = MAX_uint32_T;
  }

  if ((real_T)varargin_2 > pBuffers->data[(int32_T)idx - 1].Data->size[1]) {
    varargin_1 = (real_T)pBuffers->data[(int32_T)idx - 1].Data->size[1] * 2.0;
    d2 = (real_T)pBuffers->data[(int32_T)idx - 1].DataSize + (real_T)arg_size[1];
    if (d2 < 4.294967296E+9) {
      if (d2 >= 0.0) {
        varargin_2 = (uint32_T)d2;
      } else {
        varargin_2 = 0U;
      }
    } else {
      varargin_2 = MAX_uint32_T;
    }

    emxInit_uint8_T(sp, &r0, 2, &c_emlrtRTEI, true);
    i10 = pBuffers->size[1];
    i11 = pBuffers->data[(int32_T)idx - 1].Data->size[1];
    if (varargin_1 < varargin_2) {
      b_varargin_1 = varargin_2;
    } else {
      b_varargin_1 = (uint32_T)varargin_1;
    }

    d2 = (real_T)b_varargin_1 - (real_T)i11;
    if (d2 < 4.294967296E+9) {
      if (d2 >= 0.0) {
        varargin_2 = (uint32_T)d2;
      } else {
        varargin_2 = 0U;
      }
    } else {
      varargin_2 = MAX_uint32_T;
    }

    if ((real_T)varargin_2 != (int32_T)varargin_2) {
      emlrtIntegerCheckR2012b(varargin_2, &emlrtDCI, sp);
    }

    unnamed_idx_1 = (int32_T)varargin_2;
    i11 = pBuffers->size[1];
    i12 = r0->size[0] * r0->size[1];
    r0->size[0] = 1;
    i13 = (int32_T)idx;
    if (!((i13 >= 1) && (i13 <= i10))) {
      emlrtDynamicBoundsCheckR2012b(i13, 1, i10, &emlrtBCI, sp);
    }

    r0->size[1] = pBuffers->data[i13 - 1].Data->size[1] + unnamed_idx_1;
    emxEnsureCapacity_uint8_T(sp, r0, i12, &c_emlrtRTEI);
    i12 = (int32_T)idx;
    if (!((i12 >= 1) && (i12 <= i10))) {
      emlrtDynamicBoundsCheckR2012b(i12, 1, i10, &emlrtBCI, sp);
    }

    loop_ub = pBuffers->data[i12 - 1].Data->size[1];
    for (i12 = 0; i12 < loop_ub; i12++) {
      i13 = (int32_T)idx;
      if (!((i13 >= 1) && (i13 <= i10))) {
        emlrtDynamicBoundsCheckR2012b(i13, 1, i10, &emlrtBCI, sp);
      }

      i14 = (int32_T)idx;
      if (!((i14 >= 1) && (i14 <= i10))) {
        emlrtDynamicBoundsCheckR2012b(i14, 1, i10, &emlrtBCI, sp);
      }

      r0->data[r0->size[0] * i12] = pBuffers->data[i13 - 1].Data->data
        [pBuffers->data[i14 - 1].Data->size[0] * i12];
    }

    for (i12 = 0; i12 < unnamed_idx_1; i12++) {
      i13 = (int32_T)idx;
      if (!((i13 >= 1) && (i13 <= i10))) {
        emlrtDynamicBoundsCheckR2012b(i13, 1, i10, &emlrtBCI, sp);
      }

      r0->data[r0->size[0] * (i12 + pBuffers->data[i13 - 1].Data->size[1])] = 0U;
    }

    i10 = (int32_T)idx;
    if (!((i10 >= 1) && (i10 <= i11))) {
      emlrtDynamicBoundsCheckR2012b(i10, 1, i11, &emlrtBCI, sp);
    }

    i10 = pBuffers->data[(int32_T)idx - 1].Data->size[0] * pBuffers->data
      [(int32_T)idx - 1].Data->size[1];
    pBuffers->data[(int32_T)idx - 1].Data->size[0] = 1;
    i12 = (int32_T)idx;
    if (!((i12 >= 1) && (i12 <= i11))) {
      emlrtDynamicBoundsCheckR2012b(i12, 1, i11, &emlrtBCI, sp);
    }

    pBuffers->data[(int32_T)idx - 1].Data->size[1] = r0->size[1];
    emxEnsureCapacity_uint8_T(sp, pBuffers->data[(int32_T)idx - 1].Data, i10,
      &c_emlrtRTEI);
    loop_ub = r0->size[1];
    for (i10 = 0; i10 < loop_ub; i10++) {
      i12 = (int32_T)idx;
      if (!((i12 >= 1) && (i12 <= i11))) {
        emlrtDynamicBoundsCheckR2012b(i12, 1, i11, &emlrtBCI, sp);
      }

      i13 = (int32_T)idx;
      if (!((i13 >= 1) && (i13 <= i11))) {
        emlrtDynamicBoundsCheckR2012b(i13, 1, i11, &emlrtBCI, sp);
      }

      pBuffers->data[i12 - 1].Data->data[pBuffers->data[i13 - 1].Data->size[0] *
        i10] = r0->data[r0->size[0] * i10];
    }

    emxFree_uint8_T(sp, &r0);
  }

  i10 = pBuffers->size[1];
  i11 = (int32_T)idx;
  if (!((i11 >= 1) && (i11 <= i10))) {
    emlrtDynamicBoundsCheckR2012b(i11, 1, i10, &emlrtBCI, sp);
  }

  i10 = i11 - 1;
  d2 = (real_T)size + (real_T)arg_size[1];
  if (d2 < 4.294967296E+9) {
    if (d2 >= 0.0) {
      varargin_2 = (uint32_T)d2;
    } else {
      varargin_2 = 0U;
    }
  } else {
    varargin_2 = MAX_uint32_T;
  }

  qY = varargin_2 - 1U;
  if (qY > varargin_2) {
    qY = 0U;
  }

  if (size > qY) {
    i12 = 1;
    i11 = 1;
  } else {
    i11 = pBuffers->data[(int32_T)idx - 1].Data->size[1];
    i12 = (int32_T)size;
    if (!((i12 >= 1) && (i12 <= i11))) {
      emlrtDynamicBoundsCheckR2012b(i12, 1, i11, &emlrtBCI, sp);
    }

    i11 = pBuffers->data[(int32_T)idx - 1].Data->size[1];
    i13 = (int32_T)qY;
    if (!((i13 >= 1) && (i13 <= i11))) {
      emlrtDynamicBoundsCheckR2012b(i13, 1, i11, &emlrtBCI, sp);
    }

    i11 = i13 + 1;
  }

  emxInit_int32_T(sp, &r1, 2, &c_emlrtRTEI, true);
  i13 = i11 - i12;
  if (i13 != arg_size[1]) {
    emlrtSubAssignSizeCheck1dR2017a(i13, arg_size[1], &emlrtECI, sp);
  }

  i13 = r1->size[0] * r1->size[1];
  r1->size[0] = 1;
  r1->size[1] = i11 - i12;
  emxEnsureCapacity_int32_T(sp, r1, i13, &c_emlrtRTEI);
  loop_ub = i11 - i12;
  for (i11 = 0; i11 < loop_ub; i11++) {
    r1->data[r1->size[0] * i11] = (i12 + i11) - 1;
  }

  loop_ub = r1->size[0] * r1->size[1] - 1;
  for (i11 = 0; i11 <= loop_ub; i11++) {
    pBuffers->data[i10].Data->data[r1->data[i11]] = arg_data[i11];
  }

  emxFree_int32_T(sp, &r1);
  i10 = pBuffers->size[1];
  i11 = (int32_T)idx;
  if (!((i11 >= 1) && (i11 <= i10))) {
    emlrtDynamicBoundsCheckR2012b(i11, 1, i10, &emlrtBCI, sp);
  }

  d2 = (real_T)size + (real_T)arg_size[1];
  if (d2 < 4.294967296E+9) {
    if (d2 >= 0.0) {
      varargin_2 = (uint32_T)d2;
    } else {
      varargin_2 = 0U;
    }
  } else {
    varargin_2 = MAX_uint32_T;
  }

  pBuffers->data[i11 - 1].DataSize = varargin_2;
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static boolean_T customCoderEnableLog(const emlrtStack *sp, uint32_T buffId)
{
  boolean_T out;
  emxArray_boolean_T *x;
  int32_T i1;
  int32_T loop_ub;
  const mxArray *y;
  const mxArray *m1;
  boolean_T p;
  int32_T nxin;
  emlrtStack st;
  emlrtStack b_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (!pInit_not_empty) {
    emxInit_boolean_T(sp, &x, 2, &c_emlrtRTEI, true);
    pInit_not_empty = true;
    i1 = pEnabled->size[0] * pEnabled->size[1];
    pEnabled->size[0] = 1;
    pEnabled->size[1] = 1;
    emxEnsureCapacity_boolean_T(sp, pEnabled, i1, &c_emlrtRTEI);
    pEnabled->data[0] = false;
    y = NULL;
    m1 = emlrtCreateLogicalArray(2, *(int32_T (*)[2])pEnabled->size);
    emlrtInitLogicalArray(pEnabled->size[1], m1, pEnabled->data);
    emlrtAssign(&y, m1);
    st.site = &q_emlrtRSI;
    emlrt_marshallIn(sp, horzcat(&st, y, f2fCustomCoderEnableLogState(&st,
      &c_emlrtMCI), &c_emlrtMCI), "horzcat", pEnabled);
    st.site = &q_emlrtRSI;
    i1 = x->size[0] * x->size[1];
    x->size[0] = 1;
    x->size[1] = pEnabled->size[1];
    emxEnsureCapacity_boolean_T(&st, x, i1, &c_emlrtRTEI);
    loop_ub = pEnabled->size[0] * pEnabled->size[1];
    for (i1 = 0; i1 < loop_ub; i1++) {
      x->data[i1] = pEnabled->data[i1];
    }

    b_st.site = &r_emlrtRSI;
    p = true;
    if (1 > pEnabled->size[1]) {
      p = false;
    }

    if (!p) {
      emlrtErrorWithMessageIdR2018a(&b_st, &g_emlrtRTEI,
        "MATLAB:subsdeldimmismatch", "MATLAB:subsdeldimmismatch", 0);
    }

    nxin = x->size[1] - 1;
    for (loop_ub = 1; loop_ub <= nxin; loop_ub++) {
      x->data[loop_ub - 1] = x->data[loop_ub];
    }

    i1 = x->size[0] * x->size[1];
    if (1 > nxin) {
      x->size[1] = 0;
    } else {
      x->size[1] = nxin;
    }

    emxEnsureCapacity_boolean_T(&st, x, i1, &d_emlrtRTEI);
    i1 = pEnabled->size[0] * pEnabled->size[1];
    pEnabled->size[0] = 1;
    pEnabled->size[1] = x->size[1];
    emxEnsureCapacity_boolean_T(sp, pEnabled, i1, &c_emlrtRTEI);
    loop_ub = x->size[0] * x->size[1];
    for (i1 = 0; i1 < loop_ub; i1++) {
      pEnabled->data[i1] = x->data[i1];
    }

    emxFree_boolean_T(sp, &x);
  }

  if ((real_T)buffId > pEnabled->size[1]) {
    out = false;
  } else {
    i1 = pEnabled->size[1];
    loop_ub = (int32_T)buffId;
    if (!((loop_ub >= 1) && (loop_ub <= i1))) {
      emlrtDynamicBoundsCheckR2012b(loop_ub, 1, i1, &emlrtBCI, sp);
    }

    out = pEnabled->data[loop_ub - 1];
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return out;
}

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, emxArray_boolean_T *ret)
{
  static const int32_T dims[2] = { 1, -1 };

  const boolean_T bv0[2] = { false, true };

  int32_T iv8[2];
  int32_T i21;
  emlrtCheckVsBuiltInR2012b(sp, msgId, src, "logical", false, 2U, dims, &bv0[0],
    iv8);
  i21 = ret->size[0] * ret->size[1];
  ret->size[0] = iv8[0];
  ret->size[1] = iv8[1];
  emxEnsureCapacity_boolean_T(sp, ret, i21, (emlrtRTEInfo *)NULL);
  emlrtImportArrayR2015b(sp, src, ret->data, 1, false);
  emlrtDestroyArray(&src);
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *b_horzcat,
  const char_T *identifier, emxArray_boolean_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(b_horzcat), &thisId, y);
  emlrtDestroyArray(&b_horzcat);
}

static void error(const emlrtStack *sp, const mxArray *b, emlrtMCInfo *location)
{
  const mxArray *pArray;
  pArray = b;
  emlrtCallMATLABR2012b(sp, 0, NULL, 1, &pArray, "error", true, location);
}

static const mxArray *f2fCustomCoderEnableLogState(const emlrtStack *sp,
  emlrtMCInfo *location)
{
  const mxArray *m9;
  return emlrtCallMATLABR2012b(sp, 1, &m9, 0, NULL,
    "f2fCustomCoderEnableLogState", true, location);
}

static void generic_logger_impl_val(const emlrtStack *sp, uint32_T idx_in, const
  real_T val_in[4])
{
  int32_T t1_Class_size[2];
  int32_T i6;
  real_T val_in_data[16];
  char_T t1_Class_data[6];
  static const char_T valClass[6] = { 'd', 'o', 'u', 'b', 'l', 'e' };

  int32_T bytes_size[2];
  emxArray_uint8_T *t1_Data;
  real_T t1_Dims_data[2];
  uint8_T bytes_data[128];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  if (idx_in > 1U) {
    st.site = &q_emlrtRSI;
    if (!buffers(&st, idx_in)) {
      t1_Class_size[0] = 1;
      t1_Class_size[1] = 6;
      for (i6 = 0; i6 < 6; i6++) {
        t1_Class_data[i6] = valClass[i6];
      }

      for (i6 = 0; i6 < 2; i6++) {
        t1_Dims_data[i6] = 4.0 + -3.0 * (real_T)i6;
      }

      emxInit_uint8_T(sp, &t1_Data, 2, &c_emlrtRTEI, true);
      i6 = t1_Data->size[0] * t1_Data->size[1];
      t1_Data->size[0] = 1;
      t1_Data->size[1] = 1;
      emxEnsureCapacity_uint8_T(sp, t1_Data, i6, &c_emlrtRTEI);
      t1_Data->data[0] = 0U;
      st.site = &q_emlrtRSI;
      b_buffers(&st, idx_in, t1_Class_data, t1_Class_size, t1_Dims_data, false,
                t1_Data, 1U);
      emxFree_uint8_T(sp, &t1_Data);
    }

    st.site = &q_emlrtRSI;
    for (i6 = 0; i6 < 4; i6++) {
      val_in_data[i6] = val_in[i6];
    }

    bytes_size[0] = 1;
    bytes_size[1] = 32;
    memcpy((void *)&bytes_data[0], (void *)&val_in_data[0], (uint32_T)((size_t)
            32 * sizeof(uint8_T)));
    st.site = &q_emlrtRSI;
    c_buffers(&st, idx_in, bytes_data, bytes_size);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

static const mxArray *horzcat(const emlrtStack *sp, const mxArray *b, const
  mxArray *c, emlrtMCInfo *location)
{
  const mxArray *pArrays[2];
  const mxArray *m10;
  pArrays[0] = b;
  pArrays[1] = c;
  return emlrtCallMATLABR2012b(sp, 1, &m10, 2, pArrays, "horzcat", true,
    location);
}

static boolean_T indexMapper(const emlrtStack *sp, uint32_T staticIdx)
{
  boolean_T actualIdx;
  struct1_T S;
  int32_T i2;
  int32_T i3;
  if (!pIndexMap_not_empty) {
    S.ActualIndex = 0U;
    S.FieldNames.size[0] = 1;
    S.FieldNames.size[1] = 0;
    i2 = pIndexMap->size[0] * pIndexMap->size[1];
    pIndexMap->size[0] = 1;
    pIndexMap->size[1] = 1;
    emxEnsureCapacity_struct1_T(sp, pIndexMap, i2, &c_emlrtRTEI);
    pIndexMap->data[0] = S;
    pIndexMap_not_empty = true;
    pBufferLen = 1U;
  }

  if ((real_T)staticIdx > pIndexMap->size[1]) {
    actualIdx = false;
  } else {
    i2 = pIndexMap->size[1];
    i3 = (int32_T)staticIdx;
    if (!((i3 >= 1) && (i3 <= i2))) {
      emlrtDynamicBoundsCheckR2012b(i3, 1, i2, &emlrtBCI, sp);
    }

    actualIdx = (pIndexMap->data[i3 - 1].ActualIndex != 0U);
  }

  return actualIdx;
}

void b_custom_mex_logger(const emlrtStack *sp, uint32_T idx_in, const creal_T
  val_in[16])
{
  uint32_T actualIdx;
  struct1_T S;
  int32_T i15;
  int32_T i16;
  real_T b_val_in[16];
  uint32_T qY;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &q_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if (customCoderEnableLog(&st, idx_in)) {
    st.site = &q_emlrtRSI;
    b_st.site = &q_emlrtRSI;
    if (!indexMapper(&b_st, idx_in)) {
      b_st.site = &q_emlrtRSI;
      actualIdx = b_indexMapper(&b_st, idx_in);
    } else {
      b_st.site = &q_emlrtRSI;
      if (!pIndexMap_not_empty) {
        S.ActualIndex = 0U;
        S.FieldNames.size[0] = 1;
        S.FieldNames.size[1] = 0;
        i15 = pIndexMap->size[0] * pIndexMap->size[1];
        pIndexMap->size[0] = 1;
        pIndexMap->size[1] = 1;
        emxEnsureCapacity_struct1_T(&b_st, pIndexMap, i15, &b_emlrtRTEI);
        pIndexMap->data[0] = S;
        pIndexMap_not_empty = true;
        pBufferLen = 1U;
      }

      i15 = pIndexMap->size[1];
      i16 = (int32_T)idx_in;
      if (!((i16 >= 1) && (i16 <= i15))) {
        emlrtDynamicBoundsCheckR2012b(i16, 1, i15, &emlrtBCI, &b_st);
      }

      actualIdx = pIndexMap->data[i16 - 1].ActualIndex;
    }

    b_st.site = &q_emlrtRSI;
    for (i15 = 0; i15 < 16; i15++) {
      b_val_in[i15] = val_in[i15].re;
    }

    c_st.site = &q_emlrtRSI;
    b_generic_logger_impl_val(&c_st, actualIdx, b_val_in);
    for (i15 = 0; i15 < 16; i15++) {
      b_val_in[i15] = val_in[i15].im;
    }

    qY = actualIdx + 1U;
    if (qY < actualIdx) {
      qY = MAX_uint32_T;
    }

    c_st.site = &q_emlrtRSI;
    b_generic_logger_impl_val(&c_st, qY, b_val_in);
  }
}

void buffers_free(const emlrtStack *sp)
{
  emxFree_struct0_T(sp, &pBuffers);
}

void buffers_init(const emlrtStack *sp)
{
  emxInit_struct0_T(sp, &pBuffers, 2, &emlrtRTEI, false);
  pBuffers_not_empty = false;
}

void c_custom_mex_logger(const emlrtStack *sp, emxArray_struct0_T *data,
  emxArray_struct1_T *bufferInfo)
{
  struct0_T S;
  int32_T i18;
  static const char_T valClass[5] = { 'u', 'i', 'n', 't', '8' };

  int32_T loop_ub;
  struct1_T b_S;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  st.site = &q_emlrtRSI;
  emxInitStruct_struct0_T(&st, &S, &b_emlrtRTEI, true);
  if (!pBuffers_not_empty) {
    S.Class.size[0] = 1;
    S.Class.size[1] = 5;
    for (i18 = 0; i18 < 5; i18++) {
      S.Class.data[i18] = valClass[i18];
    }

    S.Dims.size[0] = 1;
    S.Dims.size[1] = 2;
    for (i18 = 0; i18 < 2; i18++) {
      S.Dims.data[i18] = 1.0;
    }

    S.Varsize = false;
    S.NumericType.size[0] = 1;
    S.NumericType.size[1] = 0;
    S.Fimath.size[0] = 1;
    S.Fimath.size[1] = 0;
    i18 = S.Data->size[0] * S.Data->size[1];
    S.Data->size[0] = 1;
    S.Data->size[1] = 1;
    emxEnsureCapacity_uint8_T(&st, S.Data, i18, &b_emlrtRTEI);
    S.Data->data[0] = 0U;
    S.DataSize = 1U;
    i18 = pBuffers->size[0] * pBuffers->size[1];
    pBuffers->size[0] = 1;
    pBuffers->size[1] = 1;
    emxEnsureCapacity_struct0_T(&st, pBuffers, i18, &b_emlrtRTEI);
    emxCopyStruct_struct0_T(&st, &pBuffers->data[0], &S, &emlrtRTEI);
    pBuffers_not_empty = true;
  }

  i18 = data->size[0] * data->size[1];
  data->size[0] = 1;
  data->size[1] = pBuffers->size[1];
  emxEnsureCapacity_struct0_T(&st, data, i18, &b_emlrtRTEI);
  loop_ub = pBuffers->size[0] * pBuffers->size[1];
  for (i18 = 0; i18 < loop_ub; i18++) {
    emxCopyStruct_struct0_T(&st, &data->data[i18], &pBuffers->data[i18],
      &emlrtRTEI);
  }

  emxCopyStruct_struct0_T(&st, &S, &pBuffers->data[0], &b_emlrtRTEI);
  i18 = pBuffers->size[0] * pBuffers->size[1];
  pBuffers->size[0] = 1;
  pBuffers->size[1] = 1;
  emxEnsureCapacity_struct0_T(&st, pBuffers, i18, &b_emlrtRTEI);
  emxCopyStruct_struct0_T(&st, &pBuffers->data[0], &S, &emlrtRTEI);
  pBuffers_not_empty = true;
  st.site = &q_emlrtRSI;
  emxFreeStruct_struct0_T(&st, &S);
  if (!pIndexMap_not_empty) {
    b_S.ActualIndex = 0U;
    b_S.FieldNames.size[0] = 1;
    b_S.FieldNames.size[1] = 0;
    i18 = pIndexMap->size[0] * pIndexMap->size[1];
    pIndexMap->size[0] = 1;
    pIndexMap->size[1] = 1;
    emxEnsureCapacity_struct1_T(&st, pIndexMap, i18, &b_emlrtRTEI);
    pIndexMap->data[0] = b_S;
    pIndexMap_not_empty = true;
    pBufferLen = 1U;
  }

  i18 = bufferInfo->size[0] * bufferInfo->size[1];
  bufferInfo->size[0] = 1;
  bufferInfo->size[1] = pIndexMap->size[1];
  emxEnsureCapacity_struct1_T(&st, bufferInfo, i18, &b_emlrtRTEI);
  loop_ub = pIndexMap->size[0] * pIndexMap->size[1];
  for (i18 = 0; i18 < loop_ub; i18++) {
    bufferInfo->data[i18] = pIndexMap->data[i18];
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
}

void customCoderEnableLog_free(const emlrtStack *sp)
{
  emxFree_boolean_T(sp, &pEnabled);
}

void customCoderEnableLog_init(const emlrtStack *sp)
{
  emxInit_boolean_T(sp, &pEnabled, 2, &emlrtRTEI, false);
}

void custom_mex_logger(const emlrtStack *sp, uint32_T idx_in, const creal_T
  val_in[4])
{
  uint32_T actualIdx;
  struct1_T S;
  int32_T i;
  int32_T i0;
  real_T b_val_in[4];
  uint32_T qY;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &q_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  if (customCoderEnableLog(&st, idx_in)) {
    st.site = &q_emlrtRSI;
    b_st.site = &q_emlrtRSI;
    if (!indexMapper(&b_st, idx_in)) {
      b_st.site = &q_emlrtRSI;
      actualIdx = b_indexMapper(&b_st, idx_in);
    } else {
      b_st.site = &q_emlrtRSI;
      if (!pIndexMap_not_empty) {
        S.ActualIndex = 0U;
        S.FieldNames.size[0] = 1;
        S.FieldNames.size[1] = 0;
        i = pIndexMap->size[0] * pIndexMap->size[1];
        pIndexMap->size[0] = 1;
        pIndexMap->size[1] = 1;
        emxEnsureCapacity_struct1_T(&b_st, pIndexMap, i, &b_emlrtRTEI);
        pIndexMap->data[0] = S;
        pIndexMap_not_empty = true;
        pBufferLen = 1U;
      }

      i = pIndexMap->size[1];
      i0 = (int32_T)idx_in;
      if (!((i0 >= 1) && (i0 <= i))) {
        emlrtDynamicBoundsCheckR2012b(i0, 1, i, &emlrtBCI, &b_st);
      }

      actualIdx = pIndexMap->data[i0 - 1].ActualIndex;
    }

    b_st.site = &q_emlrtRSI;
    for (i = 0; i < 4; i++) {
      b_val_in[i] = val_in[i].re;
    }

    c_st.site = &q_emlrtRSI;
    generic_logger_impl_val(&c_st, actualIdx, b_val_in);
    for (i = 0; i < 4; i++) {
      b_val_in[i] = val_in[i].im;
    }

    qY = actualIdx + 1U;
    if (qY < actualIdx) {
      qY = MAX_uint32_T;
    }

    c_st.site = &q_emlrtRSI;
    generic_logger_impl_val(&c_st, qY, b_val_in);
  }
}

void indexMapper_free(const emlrtStack *sp)
{
  emxFree_struct1_T(sp, &pIndexMap);
}

void indexMapper_init(const emlrtStack *sp)
{
  emxInit_struct1_T(sp, &pIndexMap, 2, &emlrtRTEI, false);
  pIndexMap_not_empty = false;
}

void pInit_not_empty_init(void)
{
  pInit_not_empty = false;
}

/* End of code generation (custom_mex_logger.c) */
