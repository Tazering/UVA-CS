# -*-sh-*- # this line enables partial syntax highlighting in emacs

######### The PC #############
register fF { pc:64 = 0; }


########## Fetch #############
pc = F_pc;

wire ifun:4, valC:64;

f_icode = i10bytes[4..8];
ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

valC = [
	f_icode in { JXX } : i10bytes[8..72];
	1 : i10bytes[16..80];
];

wire offset:64, valP:64;
offset = [
	f_icode in { HALT, NOP, RET } : 1;
	f_icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	f_icode in { JXX, CALL } : 9;
	1 : 10;
];
valP = F_pc + offset;

########## Decode #############

# fetch --> decode
register fD {
	icode : 4 = 0;
	rA : 4 = 0;
	rB : 4 = 0;
}

reg_srcA = [
	D_icode in {RMMOVQ} : D_rA;
	1 : REG_NONE;
];

reg_srcB = [
	D_icode in {RMMOVQ, MRMOVQ} : D_rB;
	1 : REG_NONE;
];

d_dstM = [
	D_icode in {NOP, HALT} : REG_NONE;
	1 : D_rB;
];

d_valA = reg_outputA;
d_valB = reg_outputB;
d_icode = D_icode;

########## Execute #############

# decode --> execute
register dE {
	valA : 64 = 0;
	valB : 64 = 0;
	icode : 4 = 0;
	dstM : 4 = 0;

}

wire operand1:64, operand2:64;

operand1 = [
	icode in { MRMOVQ, RMMOVQ } : valC;
	1: 0;
];
operand2 = [
	icode in { MRMOVQ, RMMOVQ } : reg_outputB;
	1: 0;
];

wire valE:64;

valE = [
	icode in { MRMOVQ, RMMOVQ } : operand1 + operand2;
	1 : 0;
];



########## Memory #############

# execute --> memory
register eM {
	icode : 4 = 0;
	
}

mem_readbit = icode in { MRMOVQ };
mem_writebit = icode in { RMMOVQ };
mem_addr = [
	icode in { MRMOVQ, RMMOVQ } : valE;
        1: 0xBADBADBAD;
];
mem_input = [
	icode in { RMMOVQ } : reg_outputA;
        1: 0xBADBADBAD;
];

########## Writeback #############

# memory --> writeback
register mW {
	
}

reg_dstM = [ 
	icode in {MRMOVQ} : rA;
	1: REG_NONE;
];
reg_inputM = [
	icode in {MRMOVQ} : mem_output;
        1: 0xBADBADBAD;
];


Stat = [
	icode == HALT : STAT_HLT;
	icode > 0xb : STAT_INS;
	1 : STAT_AOK;
];

f_pc = valP;

