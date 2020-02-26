#include <stdio.h>
#include "NT1065config.h"

NT_CONFIG initData ;
void NT1065config(float targetFreqMHz)
{	unsigned short N;
	unsigned short R;
	unsigned short TCXOfreq;
	// if (targetFreqMHz>10){TCXOfreq=1;}
	// else {TCXOfreq=0;}
	initData.TCXOfreq = TCXOfreq;
	initData.N = N;
	initData.R = R;





}