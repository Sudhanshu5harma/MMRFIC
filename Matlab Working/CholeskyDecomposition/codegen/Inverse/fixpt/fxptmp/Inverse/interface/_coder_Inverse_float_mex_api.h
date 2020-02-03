/*
 * _coder_Inverse_float_mex_api.h
 *
 * Code generation for function '_coder_Inverse_float_mex_api'
 *
 */

#ifndef _CODER_INVERSE_FLOAT_MEX_API_H
#define _CODER_INVERSE_FLOAT_MEX_API_H

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
extern void Inverse_api(const mxArray * const prhs[2], int32_T nlhs, const
  mxArray *plhs[1]);
extern void customFetchLoggedData_api(int32_T nlhs, const mxArray *plhs[4]);
extern void forcePushIntoCloud_api(int32_T nlhs);
extern void logStmts_api(int32_T nlhs);

#endif

/* End of code generation (_coder_Inverse_float_mex_api.h) */
