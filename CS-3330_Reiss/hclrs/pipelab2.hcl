# -*-sh-*- # this line enables partial syntax highlighting in emacs

######### The PC #############
register fF { pc:64 = 0; }


########## Fetch #############
pc = F_pc;

wire ifun:4, loadUse : 1;

f_icode = i10bytes[4..8];
ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

f_valC = [
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

f_Stat = [
         f_icode == HALT : STAT_HLT;
         f_icode > 0xb : STAT_INS;
         1 : STAT_AOK;
];


########## Decode #############

stall_D = loadUse;
bubble_E = loadUse;
stall_F = loadUse || f_Stat != STAT_AOK;

# fetch --> decode
register fD {
	Stat : 3 = 0;
	icode : 4 = 0;
	rA : 4 = 0;
	rB : 4 = 0;
	valC : 64 = 0;
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
	D_icode in {MRMOVQ} : D_rA;
	1: REG_NONE;
];

d_valA = [
	(reg_srcA == m_dstM) && (reg_srcA != REG_NONE) : m_valM;
	(reg_srcA == W_dstM) && (reg_srcA != REG_NONE) : W_valM;
	1 : reg_outputA;	
];

d_valB = [
	(reg_srcB == m_dstM) && (reg_srcB != REG_NONE) : m_valM;
	(reg_srcB == W_dstM) && (reg_srcB != REG_NONE) : W_valM;
	1 : reg_outputB;
];

d_icode = D_icode;
d_Stat = D_Stat;
d_valC = D_valC;

########## Execute #############

# decode --> execute
register dE {
	Stat : 3 = 0;
	valA : 64 = 0;
	valB : 64 = 0;
	icode : 4 = 0;
	dstM : 4 = REG_NONE;
	valC : 64 = 0;
}

#wire operand1:64, operand2:64;

#operand1 = [
#	E_icode in { MRMOVQ, RMMOVQ } : D_valC;
#	1: 0;
#];
#operand2 = [
#	E_icode in { MRMOVQ, RMMOVQ } : D_valB;
#	1: 0;
#];

loadUse = (E_icode == MRMOVQ) && ((E_dstM == reg_srcA) || (E_dstM == reg_srcB));



e_valE = [
	E_icode in { MRMOVQ, RMMOVQ } : E_valC + E_valB;
	1 : 0;
];

e_Stat = E_Stat;
e_icode = E_icode;
e_valA = E_valA;
e_dstM = E_dstM;


########## Memory #############

# execute --> memory
register eM {
	Stat : 3 = 0;
	icode : 4 = 0;
	valA : 64 = 0;
#	valM : 64 = 0;
	dstM : 4 = REG_NONE;
	valE : 64 = 0;
}

mem_readbit = M_icode in { MRMOVQ };
mem_writebit = M_icode in { RMMOVQ };
mem_addr = [
	M_icode in { MRMOVQ, RMMOVQ } : M_valE;
        1: 0xBADBADBAD;
];
mem_input = [
        1: M_valA;
];

m_Stat = M_Stat;
m_icode = M_icode;
m_dstM  = M_dstM;
m_valM = mem_output;

########## Writeback #############

# memory --> writeback
register mW {
	Stat : 3 = 0;
	icode : 4 = 0;
	dstM : 4 = REG_NONE;
	valM : 64 = 0;
}

reg_dstM = [ 
	1 : W_dstM;
];
reg_inputM = [
	1 : W_valM;
];


Stat = W_Stat;

f_pc = valP;

