/*
 * File: main.c
 *
 * MATLAB Coder version            : 4.0
 * C/C++ source code generated on  : 03-Feb-2020 16:36:02
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/
/* Include Files */
#include "rt_nonfinite.h"
#include "Inverse.h"
#include "main.h"
#include "Inverse_terminate.h"
#include "Inverse_initialize.h"

/* Function Declarations */
static void argInit_4x4_creal_T(creal_T result[16]);
static creal_T argInit_creal_T(void);
static double argInit_real_T(void);
static void main_Inverse(void);

/* Function Definitions */

/*
 * Arguments    : creal_T result[16]
 * Return Type  : void
 */
static void argInit_4x4_creal_T(creal_T result[16])
{
  int idx0;
  int idx1;

  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 4; idx0++) {
    for (idx1 = 0; idx1 < 4; idx1++) {
      /* Set the value of the array element.
         Change this value to the value that the application requires. */
      result[idx0 + (idx1 << 2)] = argInit_creal_T();
    }
  }
}

/*
 * Arguments    : void
 * Return Type  : creal_T
 */
static creal_T argInit_creal_T(void)
{
  creal_T result;

  /* Set the value of the complex variable.
     Change this value to the value that the application requires. */
  result.re = argInit_real_T();
  result.im = argInit_real_T();
  return result;
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
static void main_Inverse(void)
{
  creal_T dcv0[16];
  creal_T dcv1[16];
  creal_T x[4];

  /* Initialize function 'Inverse' input arguments. */
  /* Initialize function input argument 'L'. */
  /* Initialize function input argument 'D'. */
  /* Call the entry-point 'Inverse'. */
  argInit_4x4_creal_T(dcv0);
  argInit_4x4_creal_T(dcv1);
  Inverse(dcv0, dcv1, x);
}

/*
 * Arguments    : int argc
 *                const char * const argv[]
 * Return Type  : int
 */
int main(int argc, const char * const argv[])
{
  (void)argc;
  (void)argv;

  /* Initialize the application.
     You do not need to do this more than one time. */
  Inverse_initialize();

  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_Inverse();

  /* Terminate the application.
     You do not need to do this more than one time. */
  Inverse_terminate();
  return 0;
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
