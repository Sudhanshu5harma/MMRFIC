/*
 * customFetchLoggedData.c
 *
 * Code generation for function 'customFetchLoggedData'
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
static emlrtRSInfo t_emlrtRSI = { 1,   /* lineNo */
  "customFetchLoggedData",             /* fcnName */
  "C:\\Program Files\\MATLAB\\R2018a\\toolbox\\coder\\float2fixed\\custom_logger\\customFetchLoggedData.p"/* pathName */
};

/* Function Definitions */
void customFetchLoggedData(const emlrtStack *sp, emxArray_struct0_T *data,
  emxArray_struct1_T *dataInfo, char_T dataExprIdMapping[140], real_T
  *numLoggedExpr)
{
  static const char_T cv0[140] = { 'I', 'n', 'v', 'e', 'r', 's', 'e', ',', 'C',
    ':', '\\', 'U', 's', 'e', 'r', 's', '\\', 'S', 'u', 'd', 'h', 'a', 'n', 's',
    'h', 'u', ' ', 'S', 'h', 'a', 'r', 'm', 'a', '\\', 'D', 'o', 'c', 'u', 'm',
    'e', 'n', 't', 's', '\\', 'G', 'i', 't', 'H', 'u', 'b', '\\', 'M', 'M', 'R',
    'F', 'I', 'C', '\\', 'M', 'a', 't', 'l', 'a', 'b', ' ', 'W', 'o', 'r', 'k',
    'i', 'n', 'g', '\\', 'C', 'h', 'o', 'l', 'e', 's', 'k', 'y', 'D', 'e', 'c',
    'o', 'm', 'p', 'o', 's', 'i', 't', 'i', 'o', 'n', '\\', 'I', 'n', 'v', 'e',
    'r', 's', 'e', '.', 'm', '$', '$', 'i', 'n', 'p', 'u', 't', 's', '$', '$',
    '<', '>', 'L', ',', '2', '<', '>', 'D', ',', '3', '$', '$', 'o', 'u', 't',
    'p', 'u', 't', 's', '$', '$', '<', '>', 'x', ',', '4' };

  emlrtStack st;
  st.prev = sp;
  st.tls = sp->tls;
  memcpy(&dataExprIdMapping[0], &cv0[0], 140U * sizeof(char_T));
  st.site = &t_emlrtRSI;
  c_custom_mex_logger(&st, data, dataInfo);
  *numLoggedExpr = (real_T)dataInfo->size[1] - 1.0;
}

/* End of code generation (customFetchLoggedData.c) */
