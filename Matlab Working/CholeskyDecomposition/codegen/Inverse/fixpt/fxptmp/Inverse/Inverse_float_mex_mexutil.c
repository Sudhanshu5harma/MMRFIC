/*
 * Inverse_float_mex_mexutil.c
 *
 * Code generation for function 'Inverse_float_mex_mexutil'
 *
 */

/* Include files */
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "customFetchLoggedData.h"
#include "forcePushIntoCloud.h"
#include "logStmts.h"
#include "Inverse_float_mex_mexutil.h"

/* Function Definitions */
void emlrtInitVarDataTables(emlrtLocationLoggingDataType dataTables[6])
{
  int32_T i;
  for (i = 0; i < 6; i++) {
    dataTables[i].SimMin = rtInf;
    dataTables[i].SimMax = rtMinusInf;
    dataTables[i].OverflowWraps = 0;
    dataTables[i].Saturations = 0;
    dataTables[i].IsAlwaysInteger = true;
    dataTables[i].HistogramTable = (emlrtLocationLoggingHistogramType *)NULL;
  }
}

/* End of code generation (Inverse_float_mex_mexutil.c) */
