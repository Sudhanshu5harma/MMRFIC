/*
 * Inverse.c
 *
 * Code generation for function 'Inverse'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "custom_mex_logger.h"
#include "xtrsm.h"
#include "warning.h"
#include "xgetrf.h"
#include "Inverse_float_mex_mexutil.h"
#include "Inverse_float_mex_data.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = { 4,     /* lineNo */
  "Inverse",                           /* fcnName */
  "C:\\Users\\Sudhanshu Sharma\\Documents\\GitHub\\MMRFIC\\Matlab Working\\CholeskyDecomposition\\Inverse.m"/* pathName */
};

static emlrtRSInfo b_emlrtRSI = { 5,   /* lineNo */
  "Inverse",                           /* fcnName */
  "C:\\Users\\Sudhanshu Sharma\\Documents\\GitHub\\MMRFIC\\Matlab Working\\CholeskyDecomposition\\Inverse.m"/* pathName */
};

static emlrtRSInfo c_emlrtRSI = { 1,   /* lineNo */
  "Inverse",                           /* fcnName */
  "C:\\Users\\Sudhanshu Sharma\\Documents\\GitHub\\MMRFIC\\Matlab Working\\CholeskyDecomposition\\Inverse.m"/* pathName */
};

static emlrtRSInfo d_emlrtRSI = { 1,   /* lineNo */
  "mldivide",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\ops\\mldivide.p"/* pathName */
};

static emlrtRSInfo e_emlrtRSI = { 42,  /* lineNo */
  "lusolve",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\lusolve.m"/* pathName */
};

static emlrtRSInfo f_emlrtRSI = { 103, /* lineNo */
  "lusolve",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\lusolve.m"/* pathName */
};

static emlrtRSInfo g_emlrtRSI = { 101, /* lineNo */
  "lusolve",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\lusolve.m"/* pathName */
};

static emlrtRSInfo o_emlrtRSI = { 76,  /* lineNo */
  "lusolve",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\lusolve.m"/* pathName */
};

/* Function Declarations */
static void b_emlrt_update_log_1(const creal_T in[16],
  emlrtLocationLoggingDataType table[], int32_T b_index);
static void b_emlrt_update_log_2(const real_T in[4],
  emlrtLocationLoggingDataType table[], int32_T b_index);
static void emlrt_update_log_1(const creal_T in[16],
  emlrtLocationLoggingDataType table[], int32_T b_index, creal_T out[16]);
static void emlrt_update_log_2(const real_T in[4], emlrtLocationLoggingDataType
  table[], int32_T b_index, real_T out[4]);
static void emlrt_update_log_3(const creal_T in[4], emlrtLocationLoggingDataType
  table[], int32_T b_index);

/* Function Definitions */
static void b_emlrt_update_log_1(const creal_T in[16],
  emlrtLocationLoggingDataType table[], int32_T b_index)
{
  emlrtLocationLoggingDataType *b_table;
  real_T localMin;
  real_T localMax;
  int32_T i;
  if (b_index >= 0) {
    b_table = (emlrtLocationLoggingDataType *)&table[b_index];
    localMin = b_table[0U].SimMin;
    localMax = b_table[0U].SimMax;
    for (i = 0; i < 16; i++) {
      /* Simulation Min-Max logging. */
      if (in[i].re < localMin) {
        localMin = in[i].re;
      }

      if (in[i].re > localMax) {
        localMax = in[i].re;
      }

      if (in[i].im < localMin) {
        localMin = in[i].im;
      }

      if (in[i].im > localMax) {
        localMax = in[i].im;
      }
    }

    b_table[0U].SimMin = localMin;
    b_table[0U].SimMax = localMax;

    /* IsAlwaysInteger logging. */
    i = 0;
    while (b_table[0U].IsAlwaysInteger && (i < 16)) {
      if ((in[i].re != muDoubleScalarFloor(in[i].re)) || (in[i].im !=
           muDoubleScalarFloor(in[i].im))) {
        b_table[0U].IsAlwaysInteger = false;
      }

      i++;
    }
  }
}

static void b_emlrt_update_log_2(const real_T in[4],
  emlrtLocationLoggingDataType table[], int32_T b_index)
{
  emlrtLocationLoggingDataType *b_table;
  real_T localMin;
  real_T localMax;
  int32_T i;
  if (b_index >= 0) {
    b_table = (emlrtLocationLoggingDataType *)&table[b_index];
    localMin = b_table[0U].SimMin;
    localMax = b_table[0U].SimMax;
    for (i = 0; i < 4; i++) {
      /* Simulation Min-Max logging. */
      if (in[i] < localMin) {
        localMin = in[i];
      }

      if (in[i] > localMax) {
        localMax = in[i];
      }
    }

    b_table[0U].SimMin = localMin;
    b_table[0U].SimMax = localMax;

    /* IsAlwaysInteger logging. */
    i = 0;
    while (b_table[0U].IsAlwaysInteger && (i < 4)) {
      if (in[i] != muDoubleScalarFloor(in[i])) {
        b_table[0U].IsAlwaysInteger = false;
      }

      i++;
    }
  }
}

static void emlrt_update_log_1(const creal_T in[16],
  emlrtLocationLoggingDataType table[], int32_T b_index, creal_T out[16])
{
  memcpy(&out[0], &in[0], sizeof(creal_T) << 4);
  b_emlrt_update_log_1(out, table, b_index);
}

static void emlrt_update_log_2(const real_T in[4], emlrtLocationLoggingDataType
  table[], int32_T b_index, real_T out[4])
{
  int32_T i;
  for (i = 0; i < 4; i++) {
    out[i] = in[i];
  }

  b_emlrt_update_log_2(out, table, b_index);
}

static void emlrt_update_log_3(const creal_T in[4], emlrtLocationLoggingDataType
  table[], int32_T b_index)
{
  emlrtLocationLoggingDataType *b_table;
  real_T localMin;
  real_T localMax;
  int32_T i;
  if (b_index >= 0) {
    b_table = (emlrtLocationLoggingDataType *)&table[b_index];
    localMin = b_table[0U].SimMin;
    localMax = b_table[0U].SimMax;
    for (i = 0; i < 4; i++) {
      /* Simulation Min-Max logging. */
      if (in[i].re < localMin) {
        localMin = in[i].re;
      }

      if (in[i].re > localMax) {
        localMax = in[i].re;
      }

      if (in[i].im < localMin) {
        localMin = in[i].im;
      }

      if (in[i].im > localMax) {
        localMax = in[i].im;
      }
    }

    b_table[0U].SimMin = localMin;
    b_table[0U].SimMax = localMax;

    /* IsAlwaysInteger logging. */
    i = 0;
    while (b_table[0U].IsAlwaysInteger && (i < 4)) {
      if ((in[i].re != muDoubleScalarFloor(in[i].re)) || (in[i].im !=
           muDoubleScalarFloor(in[i].im))) {
        b_table[0U].IsAlwaysInteger = false;
      }

      i++;
    }
  }
}

void Inverse(const emlrtStack *sp, const creal_T L[16], const creal_T D[16],
             creal_T x[4])
{
  creal_T unusedExpr[16];
  creal_T b_unusedExpr[16];
  static const real_T B[4] = { 1.0, 3.0, 4.0, 3.0 };

  real_T c_unusedExpr[4];
  creal_T A[16];
  int32_T ipiv[4];
  int32_T i;
  int32_T k;
  real_T temp_re;
  int32_T kAcol;
  real_T temp_im;
  boolean_T b_x;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  emlrtInitVarDataTables(emlrtLocationLoggingDataTables);

  /* logging input variable 'L' for function 'Inverse' */
  emlrt_update_log_1(L, emlrtLocationLoggingDataTables, 0, unusedExpr);

  /* logging input variable 'D' for function 'Inverse' */
  emlrt_update_log_1(D, emlrtLocationLoggingDataTables, 1, b_unusedExpr);
  st.site = &c_emlrtRSI;
  b_custom_mex_logger(&st, 2U, L);
  st.site = &c_emlrtRSI;
  b_custom_mex_logger(&st, 3U, D);
  covrtLogFcn(&emlrtCoverageInstance, 0U, 0U);
  covrtLogBasicBlock(&emlrtCoverageInstance, 0U, 0U);

  /* This function solve a lower triangular system. */
  emlrt_update_log_2(B, emlrtLocationLoggingDataTables, 2, c_unusedExpr);
  st.site = &emlrtRSI;
  b_st.site = &d_emlrtRSI;
  c_st.site = &e_emlrtRSI;
  memcpy(&A[0], &L[0], sizeof(creal_T) << 4);
  d_st.site = &g_emlrtRSI;
  xgetrf(&d_st, A, ipiv, &i);
  if (i > 0) {
    d_st.site = &f_emlrtRSI;
    e_st.site = &o_emlrtRSI;
    warning(&e_st);
  }

  for (i = 0; i < 4; i++) {
    x[i].re = B[i];
    x[i].im = 0.0;
  }

  for (i = 0; i < 3; i++) {
    if (ipiv[i] != i + 1) {
      temp_re = x[i].re;
      temp_im = x[i].im;
      x[i] = x[ipiv[i] - 1];
      x[ipiv[i] - 1].re = temp_re;
      x[ipiv[i] - 1].im = temp_im;
    }
  }

  for (k = 0; k < 4; k++) {
    kAcol = k << 2;
    b_x = ((x[k].re != 0.0) || (x[k].im != 0.0));
    if (b_x) {
      for (i = k + 1; i + 1 < 5; i++) {
        temp_re = x[k].re * A[i + kAcol].re - x[k].im * A[i + kAcol].im;
        temp_im = x[k].re * A[i + kAcol].im + x[k].im * A[i + kAcol].re;
        x[i].re -= temp_re;
        x[i].im -= temp_im;
      }
    }
  }

  xtrsm(A, x);
  emlrt_update_log_3(x, emlrtLocationLoggingDataTables, 3);
  for (i = 0; i < 4; i++) {
    for (k = 0; k < 4; k++) {
      A[i + (k << 2)].re = 0.0;
      A[i + (k << 2)].im = 0.0;
      for (kAcol = 0; kAcol < 4; kAcol++) {
        temp_re = L[k + (kAcol << 2)].re;
        temp_im = -L[k + (kAcol << 2)].im;
        A[i + (k << 2)].re += D[i + (kAcol << 2)].re * temp_re - D[i + (kAcol <<
          2)].im * temp_im;
        A[i + (k << 2)].im += D[i + (kAcol << 2)].re * temp_im + D[i + (kAcol <<
          2)].im * temp_re;
      }
    }
  }

  b_emlrt_update_log_1(A, emlrtLocationLoggingDataTables, 5);
  st.site = &b_emlrtRSI;
  b_st.site = &d_emlrtRSI;
  c_st.site = &e_emlrtRSI;
  d_st.site = &g_emlrtRSI;
  xgetrf(&d_st, A, ipiv, &i);
  if (i > 0) {
    d_st.site = &f_emlrtRSI;
    e_st.site = &o_emlrtRSI;
    warning(&e_st);
  }

  for (i = 0; i < 3; i++) {
    if (ipiv[i] != i + 1) {
      temp_re = x[i].re;
      temp_im = x[i].im;
      x[i] = x[ipiv[i] - 1];
      x[ipiv[i] - 1].re = temp_re;
      x[ipiv[i] - 1].im = temp_im;
    }
  }

  for (k = 0; k < 4; k++) {
    kAcol = k << 2;
    b_x = ((x[k].re != 0.0) || (x[k].im != 0.0));
    if (b_x) {
      for (i = k + 1; i + 1 < 5; i++) {
        temp_re = x[k].re * A[i + kAcol].re - x[k].im * A[i + kAcol].im;
        temp_im = x[k].re * A[i + kAcol].im + x[k].im * A[i + kAcol].re;
        x[i].re -= temp_re;
        x[i].im -= temp_im;
      }
    }
  }

  xtrsm(A, x);
  emlrt_update_log_3(x, emlrtLocationLoggingDataTables, 4);
  st.site = &c_emlrtRSI;
  custom_mex_logger(&st, 4U, x);
}

/* End of code generation (Inverse.c) */
