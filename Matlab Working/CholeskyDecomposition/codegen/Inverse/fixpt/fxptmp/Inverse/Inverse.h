/*
 * Inverse.h
 *
 * Code generation for function 'Inverse'
 *
 */

#ifndef INVERSE_H
#define INVERSE_H

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
extern void Inverse(const emlrtStack *sp, const creal_T L[16], const creal_T D
                    [16], creal_T x[4]);

#endif

/* End of code generation (Inverse.h) */
