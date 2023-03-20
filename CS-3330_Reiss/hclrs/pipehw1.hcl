########## the PC and condition codes registers #############
register fF { 
	pc:64 = 0;
}


########## Fetch #############
pc = F_pc;

f_icode = i10bytes[4..8];
f_ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

f_valC = [
	f_icode in { JXX } : i10bytes[8..72];
	1 : i10bytes[16..80];
];

wire offset:64;
offset = [
	f_icode in { HALT, NOP, RET } : 1;
	f_icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	f_icode in { JXX, CALL } : 9;
	1 : 10;
];
f_valP = F_pc + offset;

f_Stat = [
	f_icode == HALT : STAT_HLT;
        f_icode > 0xb : STAT_INS;
        1 : STAT_AOK;
];


########## Decode #############

# fetch --> decode
register fD {
	Stat : 3 = 0;
	icode : 4 = 0;
	rA : 4 = 0;
	valC : 64 = 0;
	valP : 64 = 0;
	rB : 4 = 0;
	ifun : 4 = 0;
}

# source selection
reg_srcA = [
	D_icode in {RRMOVQ} : D_rA;
	1 : REG_NONE;
];


d_dstE = D_rB;

d_valA = [
	(reg_dstE == reg_srcA && reg_srcA != REG_NONE): reg_inputE;
	1: reg_outputA;
];

d_Stat = D_Stat;
d_icode = D_icode;
d_ifun = D_ifun;
d_valC = D_valC;

########## Execute #############

# decode --> execute
register dE {
	Stat : 3 = 0;
	icode : 4 = 0;
	ifun : 4 = 0;
	valC : 64 = 0;
#	valB : 64 = 0;
	valA : 64 = 0;
	dstE : 4 = 0;
	
}

########## Memory #############

e_Stat = E_Stat;
e_icode = E_icode;
e_dstE = E_dstE;
e_valA = E_valA;
e_valE = E_valC;


# execute --> memory
register eM {
	Stat : 3 = 0;
	icode : 4 = 0;
	valA : 64 = 0;
	dstE : 4 = 0;
	valE : 64 = 0;
}


########## Writeback #############

m_icode = M_icode;
m_valA = M_valA;
m_dstE = M_dstE;
m_Stat = M_Stat;
m_valE = M_valE;

# memory --> writeback
register mW {
	icode : 4 = 0;
	valA : 64 = 0;
	dstE : 4 = 0;
	Stat : 3 = 0;
	valE : 64 = 0;
}



# destination selection
reg_dstE = [
	W_icode in {IRMOVQ, RRMOVQ} : W_dstE;
	1 : REG_NONE;
];

reg_inputE = [ # unlike book, we handle the "forwarding" actions (something + 0) here
	W_icode == RRMOVQ : W_valA;
	W_icode in {IRMOVQ} :W_valE; # was W_valC
        1: 0xBADBADBAD;
];




########## PC update ########
f_pc = [
	(W_Stat != STAT_AOK) : F_pc; # stalling
	1 : D_valP;
];

########## Status update ########

Stat = W_Stat;
