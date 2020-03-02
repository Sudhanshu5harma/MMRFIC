#include <stdio.h>
#include "NT1065config.h"
#include "NT1065.h"

NT_CONFIG initData ;
void NT1065config(float targetFreqMHz)
{	unsigned short N1;
	unsigned short N2;
	unsigned short N;
	unsigned short R;
	unsigned short C;
	unsigned short TCXOfreq;
	unsigned short signalLOConfigB;	
	unsigned short signalLOConfigA;
	unsigned short rfAgc;
	unsigned short ADCoutput;
	unsigned short Adctype;
	unsigned short PPLSel;
	unsigned short LPFCali;
	unsigned short PllBand;
	unsigned short X;
	unsigned short freqclk;
	unsigned short TempMode;
	
	PPLSel = 1; // REG2[1-0] 0->standby, 1->PLL"A", 2->PLL"B",3->Active
	initData.PPLSel = PPLSel; //REG12
//7.1
// Default delected to 10MHz Freqtcxo
// Freq =  24.84MHz
	TCXOfreq = 1; //REG3[1] 0->10MHz 1->24.84
	initData.TCXOfreq = TCXOfreq; //REG3[1]
//7.2 calculate value of N and R		
	R = 1; // to assign the value of R(1,15)
	N = targetFreqMHz * R/TCXOfreq; // value of N(48,511)
// PLL"A" write REG41 and for PLL"B" REG45
	PllBand = 1 ; //REG41[1] 0->L2/L3/L5, 1->L1 
	initData.PllBand = PllBand; 
	N2 = N&256; // '100000000' is 256
	N1 = N&255; // '11111111' is 255
	initData.N1 = N1; // REG42[7-0] for PLL"A" and REG46[7-0] for PLL"B"
	initData.N2 = N2; // REG43[7] for PLL"A" and REG47[7] for PLL"B"
	initData.R = R; // REG43[6-3] for PLL"A" and REG47[6-3] for PLL"B"
// DELAY of 1ms to be given to lock PLL
// 7.3 SINGLE LO SOURCE CONFIGURATION
	signalLOConfigA = 0; // REG3[0] feed all mixers from PLL "A" 
	initData.signalLOConfigA =signalLOConfigA;
	signalLOConfigB = 0; // REG45[0] turning off PLL"B"
	initData.signalLOConfigB = signalLOConfigB;
//7.4 RF AGC CONFIGURATION 
	rfAgc = rcG0; // REG17[7-4] see enum for REG17 to assign value 
	initData.rfAgc =rfAgc;	
//7.5 // nothing is needed

//7.6 //nothing is needed 
	LPFCali = passband4; //REG14[6-0] for channel "A" then REG21,REG28,REG35
	initData.LPFCali = LPFCali;
//7.7 // "0" analog differential  "1" 2-bit ADC output R15 
	ADCoutput = 1; // REG15[0]
	X  = 1 ; // give value
	if (ADCoutput==1)
		{
		switch (X)
		{case 1: Adctype = 0; //REG19
		break;case 2: Adctype = 1;
		break;case 3: Adctype = 2;
		break;case 4: Adctype = 3;
		break;
	}
	}

	// 7.8
	freqclk = 12;// give freq
	C = targetFreqMHz/2*freqclk;
	// C can be from value 8 - 31 with step 1 
	// select PPL "A" - 0, PLL "B" - 1
	PPLSel = 0; // REG12

	// 7.9 // Nothing to be done 
  
	// 7.10 
	TempMode = 1; // 1 for continous and 0 for single 

	initData.TempMode = TempMode; // REG15 D[0]
	initData.C=C; //REG11
	initData.PPLSel = PPLSel; //REG12
	initData.Adctype=Adctype; //REG19
	initData.ADCoutput=ADCoutput; // REG15
}