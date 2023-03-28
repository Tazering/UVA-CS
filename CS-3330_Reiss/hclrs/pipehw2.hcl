# -*-sh-*- # this line enables partial syntax highlighting in emacs

######### The PC #############
register fF { pc:64 = 0; }


########## Fetch #############
pc = F_pc;

wire loadUse : 1;

f_icode = i10bytes[4..8];
f_ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

f_valC = [
	f_icode in { JXX , CALL} : i10bytes[8..72];
	f_icode in {IRMOVQ, RMMOVQ, MRMOVQ} : i10bytes[16..80];
	1 : 0;
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
	ifun : 4 = 0;
}

reg_srcA = [
	D_icode in {RMMOVQ, IRMOVQ, OPQ, RRMOVQ} : D_rA;
	1 : REG_NONE;
];

reg_srcB = [
	D_icode in {RMMOVQ, MRMOVQ, OPQ} : D_rB;
	1 : REG_NONE;
];


d_dstM = [
	D_icode in {MRMOVQ} : D_rA;
	D_icode in {IRMOVQ, RRMOVQ, OPQ}: D_rB;
	1: REG_NONE;
];

d_valA = [
	(reg_srcA == e_dstM) && (reg_srcA != REG_NONE): e_valM;
	(reg_srcA == m_dstM) && (reg_srcA != REG_NONE) : m_valM;
	(reg_srcA == W_dstM) && (reg_srcA != REG_NONE) : W_valM;
	1 : reg_outputA;	
];

d_valB = [
	(reg_srcB == e_dstM) && (reg_srcB != REG_NONE): e_valM;
	(reg_srcB == m_dstM) && (reg_srcB != REG_NONE) : m_valM;
	(reg_srcB == W_dstM) && (reg_srcB != REG_NONE) : W_valM;
	1 : reg_outputB;
];

d_icode = D_icode;
d_Stat = D_Stat;
d_valC = D_valC;
d_ifun = D_ifun;

########## Execute #############

# decode --> execute
register dE {
	Stat : 3 = 0;
	valA : 64 = 0;
	valB : 64 = 0;
	icode : 4 = 0;
	dstM : 4 = REG_NONE;
	valC : 64 = 0;
	ifun : 4 = 0;
}

loadUse = (E_icode == MRMOVQ) && ((E_dstM == reg_srcA) || (E_dstM == reg_srcB));

# alu
wire aluOutput : 64;
aluOutput = [
       	(E_icode == OPQ && E_ifun == ADDQ) : E_valA + E_valB;
        (E_icode == OPQ && E_ifun == SUBQ) : E_valB - E_valA;
        (E_icode == OPQ && E_ifun == ANDQ) : E_valB & E_valA;
        (E_icode == OPQ && E_ifun == XORQ) : E_valA ^ E_valB;
        (E_icode == RRMOVQ) : E_valA;
        (E_icode == IRMOVQ) : E_valC;
	(E_icode in {MRMOVQ, RMMOVQ}) : E_valC + E_valB;
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

e_valM = aluOutput;
e_Stat = E_Stat;
e_icode = E_icode;
e_valA = E_valA;
e_dstM = [

	(E_icode == CMOVXX) && (!conditionsMet) : REG_NONE;
        1: E_dstM;
];
e_ZF = C_ZF;
e_SF = C_SF;


########## Memory #############

# execute --> memory
register eM {
	Stat : 3 = 0;
	icode : 4 = 0;
	valA : 64 = 0;
	dstM : 4 = REG_NONE;
	valM : 64 = 0;
	SF : 1 = 0;
	ZF : 1 = 0;
}

mem_readbit = M_icode in { MRMOVQ };
mem_writebit = M_icode in { RMMOVQ };
mem_addr = [
	M_icode in { MRMOVQ, RMMOVQ } : M_valM;
        1: 0xBADBADBAD;
];
mem_input = [
        1: M_valA;
];

m_Stat = M_Stat;
m_icode = M_icode;
m_dstM  = M_dstM;
m_valM = [
	M_icode in {MRMOVQ} : mem_output;
	1 : M_valM;
]; 
m_valA = M_valA;

########## Writeback #############

# memory --> writeback
register mW {
	Stat : 3 = 0;
	icode : 4 = 0;
	dstM : 4 = REG_NONE;
	valM : 64 = 0;
	valA : 64 = 0;
}

reg_dstM = [ 
	W_icode in {IRMOVQ, RRMOVQ, OPQ, MRMOVQ} : W_dstM;
	1 : REG_NONE;
];
reg_inputM = [
	W_icode == RRMOVQ : W_valA;
	W_icode in {IRMOVQ, OPQ, MRMOVQ} : W_valM;
	1 : 0xBADBADBAD;
];


Stat = W_Stat;

## Status Update

f_pc = [
	(W_Stat == STAT_HLT) : F_pc; # stalling
	1 : valP
];

