/*
 * File: Inverse.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 03-Feb-2020 16:36:02
 */

/* Include Files */
#include <string.h>
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "xtrsm.h"
#include "xgetrf.h"

/* Function Definitions */

/*
 * This function solve a lower triangular system.
 * Arguments    : const creal_T L[16]
 *                const creal_T D[16]
 *                creal_T x[4]
 * Return Type  : void
 */
void Inverse(const creal_T L[16], const creal_T D[16], creal_T x[4])
{
  creal_T A[16];
  int ipiv[4];
  int i;
  static const signed char iv0[4] = { 1, 3, 4, 3 };

  double temp_re;
  double temp_im;
  int i0;
  int i1;
  memcpy(&A[0], &L[0], sizeof(creal_T) << 4);
  xgetrf(A, ipiv, &i);
  for (i = 0; i < 4; i++) {
    x[i].re = iv0[i];
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

  xtrsm(A, x);
  b_xtrsm(A, x);

  /* y = inv(L)*b; */
  for (i = 0; i < 4; i++) {
    for (i0 = 0; i0 < 4; i0++) {
      A[i + (i0 << 2)].re = 0.0;
      A[i + (i0 << 2)].im = 0.0;
      for (i1 = 0; i1 < 4; i1++) {
        temp_re = L[i0 + (i1 << 2)].re;
        temp_im = -L[i0 + (i1 << 2)].im;
        A[i + (i0 << 2)].re += D[i + (i1 << 2)].re * temp_re - D[i + (i1 << 2)].
          im * temp_im;
        A[i + (i0 << 2)].im += D[i + (i1 << 2)].re * temp_im + D[i + (i1 << 2)].
          im * temp_re;
      }
    }
  }

  xgetrf(A, ipiv, &i);
  for (i = 0; i < 3; i++) {
    if (ipiv[i] != i + 1) {
      temp_re = x[i].re;
      temp_im = x[i].im;
      x[i] = x[ipiv[i] - 1];
      x[ipiv[i] - 1].re = temp_re;
      x[ipiv[i] - 1].im = temp_im;
    }
  }

  xtrsm(A, x);
  b_xtrsm(A, x);

  /* x = inv(D*L')*y; */
}

/*
 * File trailer for Inverse.c
 *
 * [EOF]
 */
