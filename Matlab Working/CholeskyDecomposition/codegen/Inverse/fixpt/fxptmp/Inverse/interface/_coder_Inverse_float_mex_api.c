/*
 * _coder_Inverse_float_mex_api.c
 *
 * Code generation for function '_coder_Inverse_float_mex_api'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "_coder_Inverse_float_mex_api.h"
#include "Inverse_float_mex_emxutil.h"
#include "Inverse_float_mex_data.h"

/* Variable Definitions */
static emlrtRTEInfo e_emlrtRTEI = { 1, /* lineNo */
  1,                                   /* colNo */
  "_coder_Inverse_float_mex_api",      /* fName */
  ""                                   /* pName */
};

/* Function Declarations */
static const mxArray *b_emlrt_marshallOut(const emlrtStack *sp, const
  emxArray_struct0_T *u);
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *L, const
  char_T *identifier, creal_T y[16]);
static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp, const
  emxArray_struct1_T *u);
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, creal_T y[16]);
static const mxArray *d_emlrt_marshallOut(const emlrtStack *sp, const char_T u
  [140]);
static const mxArray *e_emlrt_marshallOut(const real_T u);
static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const creal_T u[4]);
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, creal_T ret[16]);

/* Function Definitions */
static const mxArray *b_emlrt_marshallOut(const emlrtStack *sp, const
  emxArray_struct0_T *u)
{
  const mxArray *y;
  int32_T i19;
  int32_T iv5[2];
  static const char * sv0[7] = { "Class", "Dims", "Varsize", "NumericType",
    "Fimath", "Data", "DataSize" };

  int32_T i;
  int32_T b_j1;
  emxArray_uint8_T *b_u;
  int32_T u_size[2];
  int32_T b_u_size[2];
  int32_T loop_ub;
  const mxArray *b_y;
  char_T u_data[6];
  const mxArray *m4;
  real_T *pData;
  int32_T c_u_size[2];
  uint8_T *b_pData;
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  y = NULL;
  for (i19 = 0; i19 < 2; i19++) {
    iv5[i19] = u->size[i19];
  }

  emlrtAssign(&y, emlrtCreateStructArray(2, iv5, 7, sv0));
  emlrtCreateField(y, "Class");
  emlrtCreateField(y, "Dims");
  emlrtCreateField(y, "Varsize");
  emlrtCreateField(y, "NumericType");
  emlrtCreateField(y, "Fimath");
  emlrtCreateField(y, "Data");
  emlrtCreateField(y, "DataSize");
  i = 0;
  b_j1 = 0;
  emxInit_uint8_T(sp, &b_u, 2, (emlrtRTEInfo *)NULL, true);
  if (0 < u->size[1U]) {
    u_size[0] = 1;
    b_u_size[0] = 1;
    b_u_size[1] = 2;
  }

  while (b_j1 < u->size[1U]) {
    u_size[1] = u->data[u->size[0] * b_j1].Class.size[1];
    loop_ub = u->data[u->size[0] * b_j1].Class.size[0] * u->data[u->size[0] *
      b_j1].Class.size[1];
    for (i19 = 0; i19 < loop_ub; i19++) {
      u_data[i19] = u->data[u->size[0] * b_j1].Class.data[i19];
    }

    b_y = NULL;
    m4 = emlrtCreateCharArray(2, u_size);
    emlrtInitCharArrayR2013a(sp, u->data[u->size[0] * b_j1].Class.size[1], m4,
      &u_data[0]);
    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "Class", b_y, 0);
    b_y = NULL;
    m4 = emlrtCreateNumericArray(2, b_u_size, mxDOUBLE_CLASS, mxREAL);
    pData = emlrtMxGetPr(m4);
    i19 = 0;
    for (loop_ub = 0; loop_ub < 2; loop_ub++) {
      pData[i19] = u->data[u->size[0] * b_j1].Dims.data[u->data[u->size[0] *
        b_j1].Dims.size[0] * loop_ub];
      i19++;
    }

    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "Dims", b_y, 1);
    b_y = NULL;
    m4 = emlrtCreateLogicalScalar(u->data[u->size[0] * b_j1].Varsize);
    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "Varsize", b_y, 2);
    c_u_size[0] = 1;
    c_u_size[1] = 0;
    b_y = NULL;
    m4 = emlrtCreateCharArray(2, c_u_size);
    emlrtInitCharArrayR2013a(sp, 0, m4, NULL);
    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "NumericType", b_y, 3);
    c_u_size[0] = 1;
    c_u_size[1] = 0;
    b_y = NULL;
    m4 = emlrtCreateCharArray(2, c_u_size);
    emlrtInitCharArrayR2013a(sp, 0, m4, NULL);
    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "Fimath", b_y, 4);
    i19 = b_u->size[0] * b_u->size[1];
    b_u->size[0] = 1;
    b_u->size[1] = u->data[u->size[0] * b_j1].Data->size[1];
    emxEnsureCapacity_uint8_T(sp, b_u, i19, (emlrtRTEInfo *)NULL);
    loop_ub = u->data[u->size[0] * b_j1].Data->size[0] * u->data[u->size[0] *
      b_j1].Data->size[1];
    for (i19 = 0; i19 < loop_ub; i19++) {
      b_u->data[i19] = u->data[u->size[0] * b_j1].Data->data[i19];
    }

    b_y = NULL;
    m4 = emlrtCreateNumericArray(2, *(int32_T (*)[1])b_u->size, mxUINT8_CLASS,
      mxREAL);
    b_pData = (uint8_T *)emlrtMxGetData(m4);
    i19 = 0;
    for (loop_ub = 0; loop_ub < u->data[u->size[0] * b_j1].Data->size[1];
         loop_ub++) {
      b_pData[i19] = u->data[u->size[0] * b_j1].Data->data[u->data[u->size[0] *
        b_j1].Data->size[0] * loop_ub];
      i19++;
    }

    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "Data", b_y, 5);
    b_y = NULL;
    m4 = emlrtCreateNumericMatrix(1, 1, mxUINT32_CLASS, mxREAL);
    *(uint32_T *)emlrtMxGetData(m4) = u->data[u->size[0] * b_j1].DataSize;
    emlrtAssign(&b_y, m4);
    emlrtSetFieldR2017b(y, i, "DataSize", b_y, 6);
    i++;
    b_j1++;
  }

  emxFree_uint8_T(sp, &b_u);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return y;
}

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *L, const
  char_T *identifier, creal_T y[16])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(L), &thisId, y);
  emlrtDestroyArray(&L);
}

static const mxArray *c_emlrt_marshallOut(const emlrtStack *sp, const
  emxArray_struct1_T *u)
{
  const mxArray *y;
  int32_T i20;
  int32_T iv6[2];
  static const char * sv1[2] = { "ActualIndex", "FieldNames" };

  int32_T i;
  int32_T u_size[2];
  int32_T b_j1;
  const mxArray *b_y;
  const mxArray *m5;
  int32_T loop_ub;
  char_T u_data[7];
  y = NULL;
  for (i20 = 0; i20 < 2; i20++) {
    iv6[i20] = u->size[i20];
  }

  emlrtAssign(&y, emlrtCreateStructArray(2, iv6, 2, sv1));
  emlrtCreateField(y, "ActualIndex");
  emlrtCreateField(y, "FieldNames");
  i = 0;
  if (0 < u->size[1U]) {
    u_size[0] = 1;
  }

  for (b_j1 = 0; b_j1 < u->size[1U]; b_j1++) {
    b_y = NULL;
    m5 = emlrtCreateNumericMatrix(1, 1, mxUINT32_CLASS, mxREAL);
    *(uint32_T *)emlrtMxGetData(m5) = u->data[u->size[0] * b_j1].ActualIndex;
    emlrtAssign(&b_y, m5);
    emlrtSetFieldR2017b(y, i, "ActualIndex", b_y, 0);
    u_size[1] = u->data[u->size[0] * b_j1].FieldNames.size[1];
    loop_ub = u->data[u->size[0] * b_j1].FieldNames.size[0] * u->data[u->size[0]
      * b_j1].FieldNames.size[1];
    for (i20 = 0; i20 < loop_ub; i20++) {
      u_data[i20] = u->data[u->size[0] * b_j1].FieldNames.data[i20];
    }

    b_y = NULL;
    m5 = emlrtCreateCharArray(2, u_size);
    emlrtInitCharArrayR2013a(sp, u->data[u->size[0] * b_j1].FieldNames.size[1],
      m5, &u_data[0]);
    emlrtAssign(&b_y, m5);
    emlrtSetFieldR2017b(y, i, "FieldNames", b_y, 1);
    i++;
  }

  return y;
}

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, creal_T y[16])
{
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

static const mxArray *d_emlrt_marshallOut(const emlrtStack *sp, const char_T u
  [140])
{
  const mxArray *y;
  const mxArray *m6;
  static const int32_T iv7[2] = { 1, 140 };

  y = NULL;
  m6 = emlrtCreateCharArray(2, iv7);
  emlrtInitCharArrayR2013a(sp, 140, m6, &u[0]);
  emlrtAssign(&y, m6);
  return y;
}

static const mxArray *e_emlrt_marshallOut(const real_T u)
{
  const mxArray *y;
  const mxArray *m7;
  y = NULL;
  m7 = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m7);
  return y;
}

static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const creal_T u[4])
{
  const mxArray *y;
  const mxArray *m3;
  static const int32_T iv4[1] = { 4 };

  y = NULL;
  m3 = emlrtCreateNumericArray(1, iv4, mxDOUBLE_CLASS, mxCOMPLEX);
  emlrtExportNumericArrayR2013b(sp, m3, (void *)&u[0], 8);
  emlrtAssign(&y, m3);
  return y;
}

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId, creal_T ret[16])
{
  static const int32_T dims[2] = { 4, 4 };

  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", true, 2U, dims);
  emlrtImportArrayR2015b(sp, src, ret, 8, true);
  emlrtDestroyArray(&src);
}

void Inverse_api(const mxArray * const prhs[2], int32_T nlhs, const mxArray
                 *plhs[1])
{
  creal_T L[16];
  creal_T D[16];
  creal_T x[4];
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;

  /* Marshall function inputs */
  c_emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "L", L);
  c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "D", D);

  /* Invoke the target function */
  Inverse(&st, L, D, x);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&st, x);
}

void customFetchLoggedData_api(int32_T nlhs, const mxArray *plhs[4])
{
  emxArray_struct0_T *data;
  emxArray_struct1_T *dataInfo;
  char_T dataExprIdMapping[140];
  real_T numLoggedExpr;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInit_struct0_T(&st, &data, 2, &e_emlrtRTEI, true);
  emxInit_struct1_T(&st, &dataInfo, 2, &e_emlrtRTEI, true);

  /* Invoke the target function */
  customFetchLoggedData(&st, data, dataInfo, dataExprIdMapping, &numLoggedExpr);

  /* Marshall function outputs */
  plhs[0] = b_emlrt_marshallOut(&st, data);
  emxFree_struct0_T(&st, &data);
  if (nlhs > 1) {
    plhs[1] = c_emlrt_marshallOut(&st, dataInfo);
  }

  emxFree_struct1_T(&st, &dataInfo);
  if (nlhs > 2) {
    plhs[2] = d_emlrt_marshallOut(&st, dataExprIdMapping);
  }

  if (nlhs > 3) {
    plhs[3] = e_emlrt_marshallOut(numLoggedExpr);
  }

  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

void forcePushIntoCloud_api(int32_T nlhs)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;

  /* Invoke the target function */
  forcePushIntoCloud(&st);
}

void logStmts_api(int32_T nlhs)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;

  /* Invoke the target function */
  logStmts(&st);
}

/* End of code generation (_coder_Inverse_float_mex_api.c) */
