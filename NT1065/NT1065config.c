#include <stdio.h>
#include "NT1065config.h"

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
	unsigned short 
	
	PPLSel = 1; // REG2 0->standby, 1->PLL"A", 2->PLL"B",3->Active
	initData.PPLSel = PPLSel; //REG12
//7.1
// Default delected to 10MHz Freqtcxo
// Freq =  24.84MHz
	TCXOfreq = 1; //REG3 0->10MHz 1->24.84
	initData.TCXOfreq = TCXOfreq; //REG3
//7.2 calculate value of N and R		
	R = ; // to assign the value of R(1,15)
	N = targetFreqMHz * R/TCXOfreq; // value of N(48,511)
// PLL"A" write REG41 and for PLL"B" REG45
	PllBand = 1 ; //REG41 0->L2/L3/L5, 1->L1 
	initData.PllBand = PllBand; 
	N1 = 
	initData.N1 = N1; // REG42 for PLL"A" and REG46 for PLL"B"
	initData.N2 = N2; // REG43 for PLL"A" and REG47 for PLL"B"
	initData.R = R; // REG
// 7.3
	signalLOConfigA = 0; // REG3
	signalLOConfigB = 0; // REG45

	//7.4
	rfAgc = 11; // REG17 // ask gana
		// need help as acc to me we don't have to assign anything calulated

	//7.5 // nothing is needed

	//7.6 //nothing is needed //table and ask gana too

	//7.7 // "0" analog differential  "1" 2-bit ADC output R15 
	ADCoutput = 1; // REG15
	X  = ; // give value
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
	freqclk = ;// give freq
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
	initData.rfAgc=rfAgc;  // REG17
	initData.signalLOConfigB = signalLOConfigB; // REG45
	initData.signalLOConfigA = signalLOConfigA;// REG3 
	initData.TCXOfreq = TCXOfreq;
	initData.N = N;
	initData.R = R;





}