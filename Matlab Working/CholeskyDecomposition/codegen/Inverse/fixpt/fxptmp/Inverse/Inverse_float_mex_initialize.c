/*
 * Inverse_float_mex_initialize.c
 *
 * Code generation for function 'Inverse_float_mex_initialize'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "Inverse_float_mex_initialize.h"
#include "custom_mex_logger.h"
#include "_coder_Inverse_float_mex_mex.h"
#include "Inverse_float_mex_data.h"

/* Variable Definitions */
static const volatile char_T *emlrtBreakCheckR2012bFlagVar = NULL;

/* Function Declarations */
static void Inverse_float_mex_once(const emlrtStack *sp);

/* Function Definitions */
static void Inverse_float_mex_once(const emlrtStack *sp)
{
  covrtInstanceData *t2_data = NULL;
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  emlrtCoverageInstance.data = t2_data;
  st.site = NULL;
  pInit_not_empty_init();
  st.site = NULL;

  /* Allocate instance data */
  covrtAllocateInstanceData(&emlrtCoverageInstance);

  /* Initialize Coverage Information */
  covrtScriptInit(&emlrtCoverageInstance,
                  "C:\\Users\\Sudhanshu Sharma\\Documents\\GitHub\\MMRFIC\\Matlab Working\\CholeskyDecomposition\\Inverse.m",
                  0U, 1U, 1U, 0U, 0U, 0U, 0U, 0U, 0U, 0U, 0U);

  /* Initialize Function Information */
  covrtFcnInit(&emlrtCoverageInstance, 0U, 0U, "Inverse", 0, -1, 115);

  /* Initialize Basic Block Information */
  covrtBasicBlockInit(&emlrtCoverageInstance, 0U, 0U, 73, -1, 110);

  /* Initialize If Information */
  /* Initialize MCDC Information */
  /* Initialize For Information */
  /* Initialize While Information */
  /* Initialize Switch Information */
  /* Start callback for coverage engine */
  covrtScriptStart(&emlrtCoverageInstance, 0U);
  st.site = NULL;
  indexMapper_init(&st);
  st.site = NULL;
  buffers_init(&st);
  st.site = NULL;
  customCoderEnableLog_init(&st);
}

void Inverse_float_mex_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2012b();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    Inverse_float_mex_once(&st);
  }
}

/* End of code generation (Inverse_float_mex_initialize.c) */
