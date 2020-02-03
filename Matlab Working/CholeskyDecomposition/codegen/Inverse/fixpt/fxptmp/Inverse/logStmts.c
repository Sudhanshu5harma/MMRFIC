/*
 * logStmts.c
 *
 * Code generation for function 'logStmts'
 *
 */

/* Include files */
#include <string.h>
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "custom_mex_logger.h"

/* Variable Definitions */
static emlrtRSInfo p_emlrtRSI = { 1,   /* lineNo */
  "logStmts",                          /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\logStmts.p"/* pathName */
};

/* Function Definitions */
void logStmts(const emlrtStack *sp)
{
  creal_T dcv0[4];
  creal_T dcv1[16];
  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  memset(&dcv0[0], 0, sizeof(creal_T) << 2);
  st.site = &p_emlrtRSI;
  custom_mex_logger(&st, 0U, dcv0);
  memset(&dcv1[0], 0, sizeof(creal_T) << 4);
  st.site = &p_emlrtRSI;
  b_custom_mex_logger(&st, 0U, dcv1);
}

/* End of code generation (logStmts.c) */
