/*
 * File: xgetrf.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 03-Feb-2020 16:36:02
 */

/* Include Files */
#include <math.h>
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "xgetrf.h"

/* Function Definitions */

/*
 * Arguments    : creal_T A[16]
 *                int ipiv[4]
 *                int *info
 * Return Type  : void
 */
void xgetrf(creal_T A[16], int ipiv[4], int *info)
{
  int i2;
  int j;
  int c;
  int iy;
  int ix;
  double smax;
  int jy;
  double brm;
  int b_j;
  double A_re;
  double A_im;
  double temp_im;
  double b_A_im;
  int ijA;
  for (i2 = 0; i2 < 4; i2++) {
    ipiv[i2] = 1 + i2;
  }

  *info = 0;
  for (j = 0; j < 3; j++) {
    c = j * 5;
    iy = 0;
    ix = c;
    smax = fabs(A[c].re) + fabs(A[c].im);
    for (jy = 2; jy <= 4 - j; jy++) {
      ix++;
      brm = fabs(A[ix].re) + fabs(A[ix].im);
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

      i2 = (c - j) + 4;
      for (iy = c + 1; iy < i2; iy++) {
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
          brm = fabs(temp_im);
          smax = fabs(b_A_im);
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

    iy = c;
    jy = c + 4;
    for (b_j = 1; b_j <= 3 - j; b_j++) {
      if ((A[jy].re != 0.0) || (A[jy].im != 0.0)) {
        smax = -A[jy].re - A[jy].im * 0.0;
        temp_im = A[jy].re * 0.0 + -A[jy].im;
        ix = c + 1;
        i2 = (iy - j) + 8;
        for (ijA = 5 + iy; ijA < i2; ijA++) {
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

/*
 * File trailer for xgetrf.c
 *
 * [EOF]
 */
