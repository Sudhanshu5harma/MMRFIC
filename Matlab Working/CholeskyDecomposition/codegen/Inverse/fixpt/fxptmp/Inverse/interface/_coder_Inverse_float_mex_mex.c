/*
 * _coder_Inverse_float_mex_mex.c
 *
 * Code generation for function '_coder_Inverse_float_mex_mex'
 *
 */

/* Include files */
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "_coder_Inverse_float_mex_mex.h"
#include "Inverse_float_mex_terminate.h"
#include "_coder_Inverse_float_mex_api.h"
#include "Inverse_float_mex_initialize.h"
#include "Inverse_float_mex_data.h"

/* Variable Definitions */
static const char * emlrtEntryPoints[4] = { "Inverse", "logStmts",
  "customFetchLoggedData", "forcePushIntoCloud" };

/* Function Declarations */
static void Inverse_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[2]);
static void c_customFetchLoggedData_mexFunc(int32_T nlhs, mxArray *plhs[4],
  int32_T nrhs);
static void forcePushIntoCloud_mexFunction(int32_T nlhs, int32_T nrhs);
static void logStmts_mexFunction(int32_T nlhs, int32_T nrhs);

/* Function Definitions */
static void Inverse_mexFunction(int32_T nlhs, mxArray *plhs[1], int32_T nrhs,
  const mxArray *prhs[2])
{
  const mxArray *outputs[1];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 2, 4, 7,
                        "Inverse");
  }

  if (nlhs > 1) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 7,
                        "Inverse");
  }

  /* Call the function. */
  Inverse_api(prhs, nlhs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  Inverse_float_mex_terminate();
}

static void c_customFetchLoggedData_mexFunc(int32_T nlhs, mxArray *plhs[4],
  int32_T nrhs)
{
  const mxArray *outputs[4];
  int32_T b_nlhs;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 0, 4,
                        21, "customFetchLoggedData");
  }

  if (nlhs > 4) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 21,
                        "customFetchLoggedData");
  }

  /* Call the function. */
  customFetchLoggedData_api(nlhs, outputs);

  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    b_nlhs = 1;
  } else {
    b_nlhs = nlhs;
  }

  emlrtReturnArrays(b_nlhs, plhs, outputs);

  /* Module termination. */
  Inverse_float_mex_terminate();
}

static void forcePushIntoCloud_mexFunction(int32_T nlhs, int32_T nrhs)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 0, 4,
                        18, "forcePushIntoCloud");
  }

  if (nlhs > 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 18,
                        "forcePushIntoCloud");
  }

  /* Call the function. */
  forcePushIntoCloud_api(nlhs);

  /* Module termination. */
  Inverse_float_mex_terminate();
}

static void logStmts_mexFunction(int32_T nlhs, int32_T nrhs)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;

  /* Check for proper number of arguments. */
  if (nrhs != 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 0, 4, 8,
                        "logStmts");
  }

  if (nlhs > 0) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 8,
                        "logStmts");
  }

  /* Call the function. */
  logStmts_api(nlhs);

  /* Module termination. */
  Inverse_float_mex_terminate();
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs, const mxArray
                 *prhs[])
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexAtExit(Inverse_float_mex_atexit);

  /* Initialize the memory manager. */
  /* Module initialization. */
  Inverse_float_mex_initialize();
  st.tls = emlrtRootTLSGlobal;

  /* Dispatch the entry-point. */
  switch (emlrtGetEntryPointIndexR2016a(&st, nrhs, prhs, emlrtEntryPoints, 4)) {
   case 0:
    Inverse_mexFunction(nlhs, plhs, nrhs - 1, *(const mxArray *(*)[2])&prhs[1]);
    break;

   case 1:
    logStmts_mexFunction(nlhs, nrhs - 1);
    break;

   case 2:
    c_customFetchLoggedData_mexFunc(nlhs, plhs, nrhs - 1);
    break;

   case 3:
    forcePushIntoCloud_mexFunction(nlhs, nrhs - 1);
    break;
  }
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLS(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_Inverse_float_mex_mex.c) */
