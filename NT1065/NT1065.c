//
// Created by Sudhanshu Sharma on 12-02-2020.
//
#include "NT1065.h"
#include "stdio.h"
#include "NT1065config.h"

extern NT_CONFIG initData ;

void NT1065()
{
    r0.defaultval=33;
    r0.val = r0.defaultval;
	NT_REG_STRUCT.R0_VAL = r0.val;


	r1.defaultval=74;
	r1.val = r1.defaultval;
	NT_REG_STRUCT.R1_VAL = r1.val;

	r2.defaultval=0;
	r2.icMODE = initData.PPLSel;//pll_active;
	r2.val = r2.icMODE|r2.defaultval<<2;
	NT_REG_STRUCT.R2_VAL = r2.val;


	r3.defaultval=0;
	r3.tcxo_Sel = freq10p0;
	r3.lo_SOURCE = initData.signalLOConfigA;//pll_a12b34;
	r3.val = r3.lo_SOURCE|r3.tcxo_Sel<<1|r3.defaultval<<2;
	NT_REG_STRUCT.R3_VAL = r3.val;	


	r4.defaultval=0;
	r4.lpf_acs_s = 0; //Status Bit
	r4.lpf_exe = pll_a12b34;
	r4.val = r4.lpf_exe|r4.lpf_acs_s<<1|r4.defaultval<<2; 
	NT_REG_STRUCT.R4_VAL = r4.val;	


	r5.defaultval=0;
	r5.chanSel = ch1;
	r5.unused = 0;
	r5.tempMode = initData.TempMode;//single;
	r5.tempSystem = finish1;
	r5.val = r5.tempSystem|r5.tempMode<<1|r5.unused<<2|r5.chanSel<<3|r5.defaultval<<4;
	NT_REG_STRUCT.R5_VAL = r5.val;	


	r6.defaultval=0;
	r6.lpf_Cali = permit1;
	r6.plla_b = permit2;
	r6.pll_vco = permit3;
	r6.rf_agc = forbid4;
	r6.standby = permit5;
	r6.val = r6.standby|r6.rf_agc<<1|r6.pll_vco<<2|r6.plla_b<<3|r6.lpf_Cali<<4|r6.defaultval<<5;
	NT_REG_STRUCT.R6_VAL = r6.val;


	r7.defaultval=0;
	r7.status_Indicator = 0 ; //status Bit
	r7.temp_val = 0 ; //status Bit
	r7.unused = 0 ; //status Bit
	r7.val = r7.temp_val|r7.unused<<2|r7.status_Indicator<<3|r7.defaultval<<5;
	NT_REG_STRUCT.R7_VAL = r7.val;

	r8.val = r7.val;
	NT_REG_STRUCT.R8_VAL = r8.val;  // r8 is same as r7

	r9.defaultval=0;
	r9.AGC_indicator = 00 ; //status Bit
	r9.gain_value = 0000 ; //status Bit
	r9.val = r9.gain_value|r9.AGC_indicator<<4|r9.defaultval<<6;
	NT_REG_STRUCT.R9_VAL = r9.val;

	r10.Gain_Values = 00000 ; //status Bit
	r10.val = r10.Gain_Values|r10.defaultval<<5;
	NT_REG_STRUCT.R9_VAL = r9.val;

	r11.defaultval =0;
	r11.clckratio = initData.C;//15;
	r11.val = r11.clckratio|r11.defaultval<<5;
	NT_REG_STRUCT.R11_VAL = r11.val;

	r12.defaultval=0;
	r12.clk_freqSource = initData.PPLSel;//plla;
	r12.clk_type = Lvds;
	r12.clk_amp = Amp3;
	r12.clk_type1 = type1;
	r12.val = r12.clk_type1|r12.clk_amp<<2|r12.clk_type<<4|r12.clk_freqSource<<5|r12.defaultval<<6;
	NT_REG_STRUCT.R12_VAL = r12.val;

	r13.defaultval=0;
	r13.chLSB = lsb; 
	r13.chEN = enb;
	r13.val = r13.chEN|r13.chLSB<<1|r13.defaultval<<2;
	NT_REG_STRUCT.R13_VAL = r13.val;

	r14.defaultval=0;
	r14.if_pass_band=initData.LPFCali;//passband14;
	r14.val = r14.if_pass_band|r14.defaultval<<7;
	NT_REG_STRUCT.R14_VAL = r14.val;

	r15.defaultval=0;
	r15.ifaAmp = threshold400;
	r15.ifaRes = mount;
	r15.rfGain = manGain;
	r15.ifaGc = autoGainCon;
	r15.ifaOp = DC1p75;
	r15.ifaOt = initData.ADCoutput;//Interface1;
	r15.val = r15.ifaOt|r15.ifaOp<<1|r15.ifaGc<<3|r15.rfGain<<4|r15.ifaRes<<5|r15.ifaAmp<<6|r15.defaultval<<7;
	NT_REG_STRUCT.R15_VAL = r15.val;

	r16.defaultval =0;
	r16.ub_agc = ubM42;
	r16.lb_agc = lbM46;
	r16.val = r16.lb_agc|r16.unused<<3|r16.ub_agc<<4|r16.defaultval<<7;
	NT_REG_STRUCT.R16_VAL = r16.val;

	r17.unused = 0;
	r17.rfgainMan =initData.rfAgc;// rcG1;
	r17.ManuGain = 1;
	r17.val = r17.ManuGain|r17.unused<<2|r17.rfgainMan<<4;
	NT_REG_STRUCT.R17_VAL = r17.val;

	r18.IfaManGain = 7;
	r18.IfaGain = 10;
	r18.val = r18.IfaGain|r18.IfaManGain<<5;
	NT_REG_STRUCT.R18_VAL = r18.val;

	r19.unused=0;
	r19.adc_clk = initData.Adctype;//adcty3; 
	r19.adc_ol = adc3 ;
	r19.val = r19.adc_ol|r19.adc_clk<<2|r19.unused<<4;
	NT_REG_STRUCT.R19_VAL = r19.val;

	r20.defaultval=0;
	r20.ch2LSB = usbch2; 
	r20.ch2EN = enbch2;
	r20.val = r20.ch2EN|r20.ch2LSB<<1|r20.defaultval<<2;
	NT_REG_STRUCT.R20_VAL = r20.val;

	r21.defaultval=0;
	r21.LPF_codech2 = 72;
	r21.val = r21.LPF_codech2|r21.defaultval<<7;
	NT_REG_STRUCT.R21_VAL = r21.val;

	r22.val = r15.val;
	NT_REG_STRUCT.R22_VAL = r22.val;

	r23.val = r16.val;
	NT_REG_STRUCT.R23_VAL = r23.val;

	r24.val = r17.val;
	NT_REG_STRUCT.R24_VAL = r24.val;

	r25.val = r18.val;
	NT_REG_STRUCT.R25_VAL = r25.val;

	r26.val = r19.val;
	NT_REG_STRUCT.R26_VAL = r26.val;

	r27.defaultval=0;
	r27.ch3LSB = usbch3; 
	r27.ch3EN = enbch3;
	r27.val = r27.ch3EN|r27.ch3LSB<<1|r27.defaultval<<2;
	NT_REG_STRUCT.R27_VAL = r27.val;

	r28.defaultval=0;
	r28.LPF_codech3 = 62;
	r28.val = r28.LPF_codech3 |r28.defaultval<<7;
	NT_REG_STRUCT.R28_VAL = r28.val;

	r29.val = r15.val;
	NT_REG_STRUCT.R29_VAL = r29.val;

	r30.val = r16.val;
	NT_REG_STRUCT.R30_VAL = r30.val;

	r31.val = r17.val;
	NT_REG_STRUCT.R23_VAL = r31.val;

	r32.val = r18.val;
	NT_REG_STRUCT.R32_VAL = r32.val;

	r33.val = r19.val;
	NT_REG_STRUCT.R33_VAL = r33.val;

	r34.defaultval=0;
	r34.ch4LSB = lsbch4; 
	r34.ch4EN = enbch4;
	r34.val = r34.ch4EN|r34.ch4LSB<<1|r34.defaultval<<2;
	NT_REG_STRUCT.R34_VAL = r34.val;

	r35.defaultval=0;
	r35.LPF_codech4 = 32;
	r35.val = r35.LPF_codech4|r35.defaultval<<7;
	NT_REG_STRUCT.R35_VAL = r35.val;

	r36.val = r15.val;
	NT_REG_STRUCT.R36_VAL = r36.val;

	r37.val = r16.val;
	NT_REG_STRUCT.R37_VAL = r37.val;

	r38.val = r17.val;
	NT_REG_STRUCT.R23_VAL = r38.val;

	r39.val = r18.val;
	NT_REG_STRUCT.R39_VAL = r39.val;

	r40.val = r19.val;
	NT_REG_STRUCT.R40_VAL = r40.val;

	r41.unused=0;
	r41.freqBandA = initData.PllBand;//PllaFreq2;
	r41.enablePllA = EnableA ;
	r41.val = r41.enablePllA|r41.freqBandA<<1|r41.unused<<2;
	NT_REG_STRUCT.R41_VAL = r41.val;

	r42.NdivA = initData.N1;
	r42.val = r42.NdivA;
	NT_REG_STRUCT.R42_VAL = r42.val;

	r43.unused = 0;
	r43.RDivA = initData.R;//1;
	r43.NdivRA = initData.N2;//1;
	r43.pllATuning= startA ;
	r43.val = r43.pllATuning|r43.unused<<1|r43.RDivA<<3|r43.NdivRA<<7;
	NT_REG_STRUCT.R43_VAL = r43.val;

	r44.unused=0;
	r44.VCOAip = upperThA; // status 
	r44.pllal1 = lockedA ; // status
	r44.val = r44.pllal1|r44.VCOAip<<1|r44.unused<<3;
	NT_REG_STRUCT.R44_VAL = r44.val;

	r45.unused=0;
	r45.freqBandB = PllbFreq1;
	r45.enablePllB = initData.signalLOConfigB ;//EnableB ;
	r45.val = r45.enablePllB|r45.freqBandB<<1|r45.unused<<2;
	NT_REG_STRUCT.R45_VAL = r45.val;

	r46.NdivB = 123;
	r46.val = r46.NdivB;
	NT_REG_STRUCT.R46_VAL = r46.val;	

	r47.unused = 0;
	r47.RDivB = 2;
	r47.NdivRB = 1;
	r47.pllBTuning= startB ;
	r47.val = r47.pllBTuning|r47.unused<<1|r47.RDivB<<3|r47.NdivRB<<7;
	NT_REG_STRUCT.R47_VAL = r47.val;

	r48.unused=0;
	r48.VCOBip = upperThB; // status 
	r48.pllbl1 = lockedB ; // status
	r48.val = r48.pllbl1|r48.VCOBip<<1|r48.unused<<3;
	NT_REG_STRUCT.R48_VAL = r48.val;

	NT_REG_STRUCT.R67_VAL = initData.valueofREG67;

	NT_REG_STRUCT.R68_VAL = initData.valueofREG68;

	// printf("r31:%d\n",r31.val);
	// printf("r32:%d\n",r32.val);
	// printf("r33:%d\n",r33.val);
	// printf("r34:%d\n",r34.val);
	// printf("r35:%d\n",r35.val);
	// printf("r36:%d\n",r36.val);
	// printf("r37:%d\n",r37.val);
	// printf("r38:%d\n",r38.val);
	// printf("r39:%d\n",r39.val);
	// printf("r40:%d\n",r40.val);

	// printf("r41:%d\n",r41.val);
	// printf("r42:%d\n",r42.val);
	// printf("r43:%d\n",r43.val);
	// printf("r44:%d\n",r44.val);
	// printf("r45:%d\n",r45.val);
	// printf("r46:%d\n",r46.val);
	// printf("r47:%d\n",r47.val);
	// printf("r48:%d\n",r48.val);

}
