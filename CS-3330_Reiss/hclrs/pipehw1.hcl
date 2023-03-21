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
	f_icode in {IRMOVQ} : i10bytes[16..80];
	1 : 0;
];

wire offset:64, valP : 64;
# aluOutput : 64;

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

# fetch --> decode
register fD {
	Stat : 3 = 0;
	icode : 4 = 0;
	rA : 4 = 0;
	valC : 64 = 0;
	rB : 4 = 0;
	ifun : 4 = 0;
}

# source selection
reg_srcA = [
	D_icode in {RRMOVQ, IRMOVQ, OPQ} : D_rA;
	1 : REG_NONE;
];

reg_srcB = [
	D_icode in {OPQ, RRMOVQ, IRMOVQ} : D_rB;
	1 : REG_NONE;
];

d_dstE = D_rB;

d_valA = [
	(reg_srcA == e_dstE) && (reg_srcA != REG_NONE): e_valE;
	(reg_srcA == m_dstE) && (reg_srcA != REG_NONE): m_valE;
	(reg_dstE == reg_srcA) && (reg_srcA != REG_NONE): reg_inputE;
	1: reg_outputA;
];

d_valB = [
	(reg_srcB == e_dstE) && (reg_srcB != REG_NONE): e_valE;
	(reg_srcB == m_dstE) && (reg_srcB != REG_NONE): m_valE;
	(reg_dstE == reg_srcB) && (reg_srcB != REG_NONE) : reg_inputE;
	1 : reg_outputB;
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
	valB : 64 = 0;
	valA : 64 = 0;
	dstE : 4 = 0;
}

# alu
wire aluOutput : 64;
aluOutput = [
        (E_icode == OPQ && E_ifun == ADDQ) : E_valA + E_valB;
        (E_icode == OPQ && E_ifun == SUBQ) : E_valB - E_valA;
        (E_icode == OPQ && E_ifun == ANDQ) : E_valB & E_valA;
        (E_icode == OPQ && E_ifun == XORQ) : E_valA ^ E_valB;
	(E_icode == RRMOVQ) : E_valA;
	(E_icode == IRMOVQ) : E_valC;
        1 : 0;
];

# condition codes
register cC {
         SF : 1 = 0;
         ZF : 1 = 1;
}

c_ZF = [
	E_icode == OPQ : (aluOutput == 0);
	1: C_ZF;
];

c_SF = [
	E_icode == OPQ : (aluOutput >= 0x8000000000000000);
	1 : C_SF;
];

# conditions for cmovXX

wire conditionsMet : 1;

conditionsMet = [
          E_ifun == ALWAYS : 1;
          E_ifun == LE : C_SF || C_ZF;
          E_ifun == LT : C_SF;
          E_ifun == EQ : C_ZF;
          E_ifun == NE : !C_ZF;
          E_ifun == GE : !C_SF;
          E_ifun == GT : !C_SF && !C_ZF;
          1 : 0; 
];


e_Stat = E_Stat;
e_icode = E_icode;
e_dstE =[
	(E_icode == CMOVXX) && (!conditionsMet) : REG_NONE;
	1: E_dstE;
];
	
e_valA = E_valA;
e_valE = aluOutput;
e_ZF = C_ZF;
e_SF = C_SF;

########## Memory #############

# execute --> memory
register eM {
	Stat : 3 = 0;
	icode : 4 = 0;
	valA : 64 = 0;
	dstE : 4 = 0;
	valE : 64 = 0;
	SF : 1 = 0;
	ZF : 1 = 0;
}


m_icode = M_icode;
m_valA = M_valA;
m_dstE = M_dstE;
m_Stat = M_Stat;
m_valE = M_valE;

########## Writeback #############

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
	W_icode in {IRMOVQ, RRMOVQ, OPQ} : W_dstE;
	1 : REG_NONE;
];

reg_inputE = [ # unlike book, we handle the "forwarding" actions (something + 0) here
	W_icode == RRMOVQ : W_valA;
	W_icode in {IRMOVQ, OPQ} : W_valE; # was W_valC
        1: 0xBADBADBAD;
];

########## PC update ########
f_pc = [
	(W_Stat == STAT_HLT) : F_pc; # stalling
	1 : valP;
];

########## Status update ########

Stat = W_Stat;
