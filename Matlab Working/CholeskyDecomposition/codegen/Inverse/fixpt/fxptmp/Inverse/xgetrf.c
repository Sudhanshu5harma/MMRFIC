/*
 * xgetrf.c
 *
 * Code generation for function 'xgetrf'
 *
 */

/* Include files */
#include "mwmathutil.h"
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "xgetrf.h"
#include "eml_int_forloop_overflow_check.h"

/* Variable Definitions */
static emlrtRSInfo h_emlrtRSI = { 30,  /* lineNo */
  "xgetrf",                            /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+lapack\\xgetrf.m"/* pathName */
};

static emlrtRSInfo i_emlrtRSI = { 50,  /* lineNo */
  "xzgetrf",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+reflapack\\xzgetrf.m"/* pathName */
};

static emlrtRSInfo j_emlrtRSI = { 58,  /* lineNo */
  "xzgetrf",                           /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+reflapack\\xzgetrf.m"/* pathName */
};

static emlrtRSInfo k_emlrtRSI = { 21,  /* lineNo */
  "eml_int_forloop_overflow_check",    /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\lib\\matlab\\eml\\eml_int_forloop_overflow_check.m"/* pathName */
};

static emlrtRSInfo l_emlrtRSI = { 52,  /* lineNo */
  "xgeru",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+blas\\xgeru.m"/* pathName */
};

static emlrtRSInfo m_emlrtRSI = { 15,  /* lineNo */
  "xgeru",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+refblas\\xgeru.m"/* pathName */
};

static emlrtRSInfo n_emlrtRSI = { 54,  /* lineNo */
  "xgerx",                             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\eml\\eml\\+coder\\+internal\\+refblas\\xgerx.m"/* pathName */
};

/* Function Definitions */
void xgetrf(const emlrtStack *sp, creal_T A[16], int32_T ipiv[4], int32_T *info)
{
  int32_T iy;
  int32_T j;
  int32_T c;
  int32_T ix;
  real_T smax;
  int32_T jy;
  real_T brm;
  int32_T b;
  int32_T b_j;
  real_T temp_im;
  real_T A_re;
  real_T A_im;
  real_T b_A_im;
  int32_T ijA;
  emlrtStack st;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  st.prev = sp;
  st.tls = sp->tls;
  st.site = &h_emlrtRSI;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  for (iy = 0; iy < 4; iy++) {
    ipiv[iy] = 1 + iy;
  }

  *info = 0;
  for (j = 0; j < 3; j++) {
    c = j * 5;
    iy = 0;
    ix = c;
    smax = muDoubleScalarAbs(A[c].re) + muDoubleScalarAbs(A[c].im);
    for (jy = 2; jy <= 4 - j; jy++) {
      ix++;
      brm = muDoubleScalarAbs(A[ix].re) + muDoubleScalarAbs(A[ix].im);
      if (brm > smax) {
        iy = jy - 1;
        smax = brm;
      }
    }

    if ((A[c + iy].re != 0.0) || (A[c + iy].im != 0.0)) {
      if (iy != 0) {
        ipiv[j] = (j + iy) + 1;
        ix = j;
        iy += j;
        for (jy = 0; jy < 4; jy++) {
          smax = A[ix].re;
          temp_im = A[ix].im;
          A[ix] = A[iy];
          A[iy].re = smax;
          A[iy].im = temp_im;
          ix += 4;
          iy += 4;
        }
      }

      b = (c - j) + 4;
      b_st.site = &i_emlrtRSI;
      for (iy = c + 1; iy < b; iy++) {
        A_re = A[iy].re;
        A_im = A[iy].im;
        temp_im = A[c].re;
        b_A_im = A[c].im;
        if (b_A_im == 0.0) {
          if (A_im == 0.0) {
            A[iy].re = A_re / temp_im;
            A[iy].im = 0.0;
          } else if (A_re == 0.0) {
            A[iy].re = 0.0;
            A[iy].im = A_im / temp_im;
          } else {
            A[iy].re = A_re / temp_im;
            A[iy].im = A_im / temp_im;
          }
        } else if (temp_im == 0.0) {
          if (A_re == 0.0) {
            A[iy].re = A_im / b_A_im;
            A[iy].im = 0.0;
          } else if (A_im == 0.0) {
            A[iy].re = 0.0;
            A[iy].im = -(A_re / b_A_im);
          } else {
            A[iy].re = A_im / b_A_im;
            A[iy].im = -(A_re / b_A_im);
          }
        } else {
          brm = muDoubleScalarAbs(temp_im);
          smax = muDoubleScalarAbs(b_A_im);
          if (brm > smax) {
            brm = b_A_im / temp_im;
            smax = temp_im + brm * b_A_im;
            A[iy].re = (A_re + brm * A_im) / smax;
            A[iy].im = (A_im - brm * A_re) / smax;
          } else if (smax == brm) {
            if (temp_im > 0.0) {
              temp_im = 0.5;
            } else {
              temp_im = -0.5;
            }

            if (b_A_im > 0.0) {
              smax = 0.5;
            } else {
              smax = -0.5;
            }

            A[iy].re = (A_re * temp_im + A_im * smax) / brm;
            A[iy].im = (A_im * temp_im - A_re * smax) / brm;
          } else {
            brm = temp_im / b_A_im;
            smax = b_A_im + brm * temp_im;
            A[iy].re = (brm * A_re + A_im) / smax;
            A[iy].im = (brm * A_im - A_re) / smax;
          }
        }
      }
    } else {
      *info = j + 1;
    }

    b_st.site = &j_emlrtRSI;
    c_st.site = &l_emlrtRSI;
    d_st.site = &m_emlrtRSI;
    iy = c;
    jy = c + 4;
    for (b_j = 1; b_j <= 3 - j; b_j++) {
      if ((A[jy].re != 0.0) || (A[jy].im != 0.0)) {
        smax = -A[jy].re - A[jy].im * 0.0;
        temp_im = A[jy].re * 0.0 + -A[jy].im;
        ix = c + 1;
        b = (iy - j) + 8;
        e_st.site = &n_emlrtRSI;
        if ((!(iy + 6 > b)) && (b > 2147483646)) {
          f_st.site = &k_emlrtRSI;
          check_forloop_overflow_error(&f_st);
        }

        for (ijA = iy + 5; ijA < b; ijA++) {
          A_im = A[ix].re * temp_im + A[ix].im * smax;
          A[ijA].re += A[ix].re * smax - A[ix].im * temp_im;
          A[ijA].im += A_im;
          ix++;
        }
      }

      jy += 4;
      iy += 4;
    }
  }

  if ((*info == 0) && (!((A[15].re != 0.0) || (A[15].im != 0.0)))) {
    *info = 4;
  }
}

/* End of code generation (xgetrf.c) */
