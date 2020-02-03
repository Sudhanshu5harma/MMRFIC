/*
 * xgetrf.h
 *
 * Code generation for function 'xgetrf'
 *
 */

#ifndef XGETRF_H
#define XGETRF_H

/* Include files */
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "covrt.h"
#include "rtwtypes.h"
#include "Inverse_float_mex_types.h"

/* Function Declarations */
extern void xgetrf(const emlrtStack *sp, creal_T A[16], int32_T ipiv[4], int32_T
                   *info);

#endif

/* End of code generation (xgetrf.h) */
