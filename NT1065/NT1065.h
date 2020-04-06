//
// Created by Sudhanshu Sharma on 12-02-2020.
//

 #ifndef UNTITLED_NT1066_H
 #define UNTITLED_NT1065_H

struct {
    unsigned short R0_VAL;
    unsigned short R1_VAL;
    unsigned short R2_VAL;
    unsigned short R3_VAL;
    unsigned short R4_VAL;
    unsigned short R5_VAL;
    unsigned short R6_VAL;
    unsigned short R7_VAL;
    unsigned short R8_VAL;
    unsigned short R9_VAL;
    unsigned short R10_VAL;
    unsigned short R11_VAL;
    unsigned short R12_VAL;
    unsigned short R13_VAL;
    unsigned short R14_VAL;
    unsigned short R15_VAL;
    unsigned short R16_VAL;
    unsigned short R17_VAL;
    unsigned short R18_VAL;
    unsigned short R19_VAL;
    unsigned short R20_VAL;
    unsigned short R21_VAL;
    unsigned short R22_VAL;
    unsigned short R23_VAL;
    unsigned short R24_VAL;
    unsigned short R25_VAL;
    unsigned short R26_VAL;
    unsigned short R27_VAL;
    unsigned short R28_VAL;
    unsigned short R29_VAL;
    unsigned short R30_VAL;
    unsigned short R31_VAL;
    unsigned short R32_VAL;
    unsigned short R33_VAL;
    unsigned short R34_VAL;
    unsigned short R35_VAL;
    unsigned short R36_VAL;
    unsigned short R37_VAL;
    unsigned short R38_VAL;
    unsigned short R39_VAL;
    unsigned short R40_VAL;
    unsigned short R41_VAL;
    unsigned short R42_VAL;
    unsigned short R43_VAL;
    unsigned short R44_VAL;
    unsigned short R45_VAL;
    unsigned short R46_VAL;
    unsigned short R47_VAL;
    unsigned short R48_VAL;
    unsigned short R67_VAL;
    unsigned short R68_VAL;
}NT_REG_STRUCT;

typedef enum {
    R0_ADDR = 0,
    R1_ADDR ,
    R2_ADDR ,
    R3_ADDR ,
    R4_ADDR ,
    R5_ADDR ,
    R6_ADDR ,
    R7_ADDR ,
    R8_ADDR ,
    R9_ADDR ,
    R10_ADDR ,
    R11_ADDR ,
    R12_ADDR ,
    R13_ADDR ,
    R14_ADDR ,
    R15_ADDR ,
    R16_ADDR ,
    R17_ADDR ,
    R18_ADDR ,
    R19_ADDR ,
    R20_ADDR ,
    R21_ADDR ,
    R22_ADDR ,
    R23_ADDR ,
    R24_ADDR ,
    R25_ADDR ,
    R26_ADDR ,
    R27_ADDR ,
    R28_ADDR ,
    R29_ADDR ,
    R30_ADDR ,
    R31_ADDR ,
    R32_ADDR ,
    R33_ADDR ,
    R34_ADDR ,
    R35_ADDR ,
    R36_ADDR ,
    R37_ADDR ,
    R38_ADDR ,
    R39_ADDR ,
    R40_ADDR ,
    R41_ADDR ,
    R42_ADDR ,
    R43_ADDR ,
    R44_ADDR ,
    R45_ADDR ,
    R46_ADDR ,
    R47_ADDR ,
    R48_ADDR ,
    R67_ADDR = 67 ,
    R68_ADDR ,
}NT_ADDR_STRUCT;

//Structure and enum for REG0
struct {
    unsigned short defaultval;
    unsigned short val;
}r0;

//Structure and enum for REG1
struct {
    unsigned short defaultval;
    unsigned short val;
}r1;

//Structure and enum for REG2
typedef enum{
	standby =0,
	pll_a_only,
	pll_b_only,
	pll_active,
}IC_mode;
struct{
	IC_mode icMODE;
	unsigned short defaultval;
	unsigned short val;
}r2;

//Structure and enum for REG3
typedef enum{
	freq10p0 = 0,
	freq24p84 ,
}TCXO_sel;
typedef enum{
	pll_allch = 0,
	pll_a12b34 ,
}LO_source;
struct{
	TCXO_sel tcxo_Sel;
	LO_source lo_SOURCE;
	unsigned short defaultval;
	unsigned short val;
}r3;

//Structure and enum for REG4
typedef enum{
	error = 0,
	success ,
}LPF_ACS_S;
typedef enum{
	finish = 0,
	start ,
}LPF_EXE;
struct{
	LPF_ACS_S lpf_acs_s;
	LPF_EXE lpf_exe;
	unsigned short defaultval;
	unsigned short val;
}r4;

//Structure and enum for REG5
typedef enum{
	ch1 = 0,
	ch2 ,
	ch3 ,
	ch4 ,
}CH_StNumSel;
typedef enum{
	single = 0,
	continuous ,
}TS_MD;
typedef enum{
	finish1 = 0,
	start1 ,
}TS_EXE;
struct{
	CH_StNumSel chanSel;
	TS_MD tempMode;
	TS_EXE tempSystem;
	unsigned short defaultval;
	unsigned short unused;
	unsigned short val;
}r5;

//Structure and enum for REG6
typedef enum{
	forbid1=0,
	permit1 ,
}LPF_ACS_AOK;
typedef enum{
	forbid2=0,
	permit2 ,
}PLL_LI_AOK ;
typedef enum{
	forbid3=0,
	permit3 ,
}PLL_VCO_AOK;
typedef enum{
	forbid4=0,
	permit4 ,
}RF_AGC_AOK ;
typedef enum{
	forbid5=0,
	permit5 ,
}StdBy_AOK;
struct{
	LPF_ACS_AOK lpf_Cali;
	PLL_LI_AOK plla_b;
	PLL_VCO_AOK pll_vco;
	RF_AGC_AOK rf_agc;
	StdBy_AOK standby;
	unsigned short defaultval;
	unsigned short val;
}r6;

//Structure and enum for REG7
typedef enum{
	fail=0,
	valid ,
}AOK ;
struct{
	AOK status_Indicator;
	unsigned short defaultval;
	unsigned short unused;
	unsigned short val;
	unsigned short temp_val;
}r7;

//Structure and enum for REG8
struct{
	unsigned short val;
}r8;

//Structure and enum for REG9
typedef enum{
	val1=00,
	val2 ,
	val3 ,
	val4 ,
}RF_AG;
typedef enum{
	Gval1 = 0000,
	Gval2 = 1111 ,
}RF_GainS ;
struct{
	RF_AG AGC_indicator;
	RF_GainS gain_value;
	unsigned short defaultval;
	unsigned short val;
}r9;

//Structure and enum for REG10
typedef enum{
	GainvalT0 = 00000,
	GainvalT3 = 00011,
	GainvalT7 = 00111,
	GainvalT10 = 01010,
	GainvalT14 = 01110,
	GainvalT17 = 10001,
	GainvalT21 = 10101,
	GainvalT23 = 10111,
	GainvalT24 = 11000,
	GainvalT31 = 11111,
}IFA_GainSt; // ----------------------want to get reviewed-----------------------------------
struct{
	IFA_GainSt Gain_Values;
	unsigned short defaultval;
	unsigned short val;
}r10;

//Structure and enum for REG11
typedef enum{
	ratio1 = 01000,
	ratio2 = 11111, 
}CDIV_R; // ----------------------want to get reviewed-----------------------------------
struct{
	CDIV_R clckratio;
	unsigned short defaultval;
	unsigned short val;
}r11;

//Structure and enum for REG12
typedef enum{
	plla=0,
	pllb ,
}CLK_Source;
typedef enum{
	Cmos =0,
	Lvds ,
}CLK_TP;
typedef enum{
	Amp1=0,
	Amp2 ,
	Amp3 ,
	Amp4,
}CLK_CC ;
typedef enum{
	type1=0,
	type2 ,
	type3 ,
	type4,
}CLK_OL;// ----------------------want to get reviewed-----------------------------------
struct{
	CLK_Source clk_freqSource;
	CLK_TP clk_type;
	CLK_CC clk_amp;
	CLK_OL clk_type1;
	unsigned short defaultval;
	unsigned short val;
}r12;

//Structure and enum for REG13
typedef enum{
	usb = 0,
	lsb,
}CH_LSB ;
typedef enum{
	dis = 0,
	enb ,
}CH_EN;
struct{
	CH_LSB chLSB;
	CH_EN chEN;
	unsigned short defaultval;
	unsigned short val;
}r13; 

//Structure and enum for REG14
typedef	enum{
	passband11p22 = 0,
    passband14p83 = 21,
    passband15p12 = 22,
    passband15p69 = 24,
    passband16p59 = 27,
    passband17p60 = 30,
    passband18p33 = 33,
    passband19p36 = 36,
    passband20p31 = 39,
    passband21p13 = 42,
    passband21p92 = 45,
    passband22p89 = 48,
    passband23p82 = 51,
    passband24p94 = 54,
    passband25p45 = 57,
    passband26p50 = 60,
    passband27p38 = 63,
    passband28p31 = 66,
    passband29p02 = 69,
    passband29p64 = 72,
    passband30p47 = 75,
    passband31p19 = 77,
    passband31p55 = 78,
    passband43p41 = 127,
}LPF_code;
struct{
	LPF_code if_pass_band;
	unsigned short defaultval;
	unsigned short val;
}r14;

//Structure and enum for REG15
typedef enum{
	threshold200 = 0,
	threshold400,
}IFA_Amp;
typedef enum{
	not_mount = 0,
	mount ,
}IFA_Res;
typedef enum{
	manGain = 0,
	autoGain,
}RF_GC;
typedef enum{
	manGainCon = 0,
	autoGainCon,
}IFA_GC;
typedef enum{
	DC1p55 = 0,
	DC1p75 ,
	DC1p90 ,
	DC2p00 ,
}IFA_OP;
typedef enum{
	Interface1 = 0,
	Interface2 ,
}IFA_OT;
struct{
	IFA_Amp ifaAmp;
	IFA_Res ifaRes;
	RF_GC rfGain;
	IFA_GC ifaGc;
	IFA_OP ifaOp;
	IFA_OT ifaOt;
	unsigned short defaultval;
	unsigned short val;
}r15; 

//Structure and enum for REG16
typedef enum{
	ubM47 = 000,
	ubM45 ,
	ubM43 ,
	ubM42 ,
	ubM41 ,
	ubM40 ,
	ubNVR1 ,
	ubNVR2 ,
}RF_AGC_UB ;
typedef enum{
	lbNVR1 = 000,
	lbNVR2 ,
	lbNVR3 ,
	lbM49 ,
	lbM46 ,
	lbM45 ,
	lbM43 ,
	lbM42 ,
}RF_AGC_LB;
struct{
	RF_AGC_UB ub_agc;
	RF_AGC_LB lb_agc;
	unsigned short defaultval;
	unsigned short unused;
	unsigned short val;
}r16; 

//Structure and enum for REG17
typedef enum{
	rcG12p00 = 0,
	rcG12p95,
	rcG13p90,
	rcG14p85,
	rcG15p80,
	rcG16p75,
	rcG17p70,
	rcG18p65,
	rcG19p60,
	rcG21p50,
	rcG22p45,
	rcG23p40,
	rcG24p35,
	rcG25p30,
	rcG26p25,
	rcG26p50,    
}RF_Gain ;
struct{
	RF_Gain rfgainMan;
	unsigned short ManuGain;
	unsigned short unused;
	unsigned short val;
}r17; 

//Structure and enum for REG18
struct{
	unsigned short IfaManGain;
	unsigned short IfaGain;
	unsigned short val;
}r18; // --------------------------- Review ones as i am just taking the values and puting in .c file

//Structure and enum for REG19
typedef enum{
	adcty1=0,
	adcty2 , 
	adcty3 , 
	adcty4 ,
}IFA_ADC_CLK;
typedef enum{
	adc1=0,
	adc2 , 
	adc3 ,
	adc4 ,
}IFA_ADC_OL;
struct{
	IFA_ADC_CLK adc_clk;
	IFA_ADC_OL adc_ol;
	unsigned short unused;
	unsigned short val;
}r19; 

//Structure and enum for REG20
typedef enum{
	usbch2 = 0,
	lsbch2,
}CH2_LSB ;
typedef enum{
	disch2 = 0,
	enbch2 ,
}CH2_EN;
struct{
	CH2_LSB ch2LSB;
	CH2_EN ch2EN;
	unsigned short defaultval;
	unsigned short val;
}r20; 

//Structure and enum for REG21
struct{
	unsigned short defaultval;
	unsigned short LPF_codech2;
	unsigned short val;
}r21;

//Structure and enum for REG22
struct{
	unsigned val; // same as r15
}r22;

//Structure and enum for REG23
struct{
	unsigned val; // same as r16
}r23;

//Structure and enum for REG24
struct{
	unsigned val; // same as r17
}r24;

//Structure and enum for REG25
struct{
	unsigned val; // same as r18
}r25;

//Structure and enum for REG26
struct{
	unsigned val; // same as r19
}r26;

//Structure and enum for REG27
typedef enum{
	usbch3 = 0,
	lsbch3,
}CH3_LSB ;
typedef enum{
	disch3 = 0,
	enbch3 ,
}CH3_EN;
struct{
	CH3_LSB ch3LSB;
	CH3_EN ch3EN;
	unsigned short defaultval;
	unsigned short val;
}r27;

//Structure and enum for REG28
struct{
	unsigned short defaultval;
	unsigned short LPF_codech3;
	unsigned short val;
}r28;

//Structure and enum for REG29
struct{
	unsigned val; // same as r15
}r29;

//Structure and enum for REG30
struct{
	unsigned val; // same as r16
}r30;

//Structure and enum for REG31
struct{
	unsigned val; // same as r17
}r31;

//Structure and enum for REG32
struct{
	unsigned val; // same as r18
}r32;

//Structure and enum for REG33
struct{
	unsigned val; // same as r19
}r33;

//Structure and enum for REG34
typedef enum{
	usbch4 = 0,
	lsbch4,
}CH4_LSB ;
typedef enum{
	disch4 = 0,
	enbch4 ,
}CH4_EN;
struct{
	CH4_LSB ch4LSB;
	CH4_EN ch4EN;
	unsigned short defaultval;
	unsigned short val;
}r34;

//Structure and enum for REG35
struct{
	unsigned short defaultval;
	unsigned short LPF_codech4;
	unsigned short val;
}r35;

//Structure and enum for REG36
struct{
	unsigned val; // same as r15
}r36;

//Structure and enum for REG37
struct{
	unsigned val; // same as r16
}r37;

//Structure and enum for REG38
struct{
	unsigned val; // same as r17
}r38;

//Structure and enum for REG39
struct{
	unsigned val; // same as r18
}r39;

//Structure and enum for REG40
struct{
	unsigned val; // same as r19
}r40;

//Structure and enum for REG41
typedef enum{
	PllaFreq1 =0,
	PllaFreq2 ,
}PLL_bandA;
typedef enum{
	DisableA =0,
	EnableA ,
}PLL_enA;
struct{
	PLL_bandA freqBandA;
	PLL_enA enablePllA;
	unsigned short unused;
	unsigned short val;
}r41;

//Structure and enum for REG42
struct{
	unsigned short NdivA;
	unsigned short unused;
	unsigned short val;
}r42;

//Structure and enum for REG43
typedef enum{
	finA=0,
	startA ,
}PLLA_exe;
struct{
	PLLA_exe pllATuning;
	unsigned short RDivA;
	unsigned short NdivRA; 
	unsigned short unused;
	unsigned short val;
}r43;

//Structure and enum for REG44
typedef enum{
	NotlockedA =0 ,
	lockedA ,
}PLLA_L1;
typedef enum{
	validA = 0,
	upperThA ,
	LowerThA ,
	unUSEA ,
}Vco_CVA;
struct{
	Vco_CVA VCOAip ;
	PLLA_L1 pllal1 ;
	unsigned short unused;
	unsigned short val;
}r44;

//Structure and enum for REG45
typedef enum{
	PllbFreq1 =0,
	PllbFreq2 ,
}PLL_bandB;
typedef enum{
	DisableB =0,
	EnableB ,
}PLL_enB;
struct{
	PLL_bandA freqBandB;
	PLL_enA enablePllB;
	unsigned short unused;
	unsigned short val;
}r45;

//Structure and enum for REG46
struct{
	unsigned short NdivB;
	unsigned short unused;
	unsigned short val;
}r46;

//Structure and enum for REG47
typedef enum{
	finB=0,
	startB ,
}PLLB_exe;
struct{
	PLLB_exe pllBTuning ;
	unsigned short RDivB;
	unsigned short NdivRB; 
	unsigned short unused;
	unsigned short val;
}r47;

//Structure and enum for REG48
typedef enum{
	NotlockedB =0 ,
	lockedB ,
}PLLB_L1;
typedef enum{
	validB = 0,
	upperThB ,
	LowerThB ,
	unUSEB ,
}Vco_CVB;
struct{
	Vco_CVB VCOBip ;
	PLLB_L1 pllbl1 ;
	unsigned short unused;
	unsigned short val;
}r48;

#endif //UNTITLED_NT1065_H