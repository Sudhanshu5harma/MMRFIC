//
// Created by Sudhanshu Sharma on 12-02-2020.
//
#include "NT1065.h"

void NT1065()
{
    r0.defaultval=33;
    r0.val = r0.defaultval;
	NT_REG_STRUCT.R0_VAL = r0.val;

	r1.defaultval=74;
	r1.val = r1.defaultval;
	NT_REG_STRUCT.R1_VAL = r1.val;

	r2.defaultval=0;
	r2.icMODE = pll_a_only;
	r2.val = r2.icMODE|r2.defaultval<<2;
	NT_REG_STRUCT.R2_VAL = r2.val;

	r3.defaultval=0;
	r3.tcxo_Sel = freq1;
	r3.lo_SOURCE = pll_a12b34;
	r3.val = r3.lo_SOURCE|r3.tcxo_Sel<<1|r3.defaultval<<2;
	NT_REG_STRUCT.R3_VAL = r3.val;	

	r4.defaultval=0;
	r4.lpf_acs_s = freq1;
	r4.lpf_exe = pll_a12b34;
	r4.val = r4.lpf_exe|r4.lpf_acs_s<<1|r4.defaultval<<2; //status bit can't be fixed
	NT_REG_STRUCT.R4_VAL = r4.val;	

	r5.defaultval=0;
	r5.chanSel = ch1;
	r5.unused = 0;
	r5.tempMode = single;
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
	NT_REG_STRUCT.R5_VAL = r6.val;

}
