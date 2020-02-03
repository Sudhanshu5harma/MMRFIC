/*
 * File: _coder_Inverse_api.h
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 03-Feb-2020 16:36:02
 */

#ifndef _CODER_INVERSE_API_H
#define _CODER_INVERSE_API_H

/* Include Files */
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include <stddef.h>
#include <stdlib.h>
#include "_coder_Inverse_api.h"

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void Inverse(creal_T L[16], creal_T D[16], creal_T x[4]);
extern void Inverse_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1]);
extern void Inverse_atexit(void);
extern void Inverse_initialize(void);
extern void Inverse_terminate(void);
extern void Inverse_xil_terminate(void);

#endif

/*
 * File trailer for _coder_Inverse_api.h
 *
 * [EOF]
 */
