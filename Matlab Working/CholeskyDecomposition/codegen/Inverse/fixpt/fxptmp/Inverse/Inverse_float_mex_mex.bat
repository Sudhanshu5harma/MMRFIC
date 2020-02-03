@echo off
set MATLAB=C:\PROGRA~1\MATLAB\R2018a
set MATLAB_ARCH=win64
set MATLAB_BIN="C:\Program Files\MATLAB\R2018a\bin"
set ENTRYPOINT=mexFunction
set OUTDIR=.\
set LIB_NAME=Inverse_float_mex
set MEX_NAME=Inverse_float_mex
set MEX_EXT=.mexw64
call "C:\PROGRA~1\MATLAB\R2018a\sys\lcc64\lcc64\mex\lcc64opts.bat"
echo # Make settings for Inverse_float_mex > Inverse_float_mex_mex.mki
echo COMPILER=%COMPILER%>> Inverse_float_mex_mex.mki
echo COMPFLAGS=%COMPFLAGS%>> Inverse_float_mex_mex.mki
echo OPTIMFLAGS=%OPTIMFLAGS%>> Inverse_float_mex_mex.mki
echo DEBUGFLAGS=%DEBUGFLAGS%>> Inverse_float_mex_mex.mki
echo LINKER=%LINKER%>> Inverse_float_mex_mex.mki
echo LINKFLAGS=%LINKFLAGS%>> Inverse_float_mex_mex.mki
echo LINKOPTIMFLAGS=%LINKOPTIMFLAGS%>> Inverse_float_mex_mex.mki
echo LINKDEBUGFLAGS=%LINKDEBUGFLAGS%>> Inverse_float_mex_mex.mki
echo MATLAB_ARCH=%MATLAB_ARCH%>> Inverse_float_mex_mex.mki
echo OMPFLAGS= >> Inverse_float_mex_mex.mki
echo OMPLINKFLAGS= >> Inverse_float_mex_mex.mki
echo EMC_COMPILER=lcc64>> Inverse_float_mex_mex.mki
echo EMC_CONFIG=optim>> Inverse_float_mex_mex.mki
"C:\Program Files\MATLAB\R2018a\bin\win64\gmake" -j 1 -B -f Inverse_float_mex_mex.mk
