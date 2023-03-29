# -*-sh-*- # this line enables partial syntax highlighting in emacs

######### The PC #############
register fF { 
	predPC:64 = 0;
}


########## Fetch #############

wire loadUse : 1;

pc = [
	(M_icode == JXX && M_mispredict): m_valP;
	(W_icode == RET): W_valE;	
	1: F_predPC;
];


f_icode = i10bytes[4..8];
f_ifun = i10bytes[0..4];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];

f_valC = [
	f_icode in { JXX , CALL} : i10bytes[8..72];
	f_icode in {IRMOVQ, RMMOVQ, MRMOVQ} : i10bytes[16..80];
	1 : 0;
];

wire offset:64;
offset = [
	f_icode in { HALT, NOP, RET } : 1;
	f_icode in { RRMOVQ, OPQ, PUSHQ, POPQ } : 2;
	f_icode in { JXX, CALL } : 9;
	1 : 10;
];

f_valP = pc + offset;

f_Stat = [
         f_icode == HALT : STAT_HLT;
         f_icode > 0xb : STAT_INS;
         1 : STAT_AOK;
];       

########## Decode #############

stall_D = loadUse;
stall_F = loadUse || f_Stat != STAT_AOK;

# fetch --> decode
register fD {
	Stat : 3 = 0;
	icode : 4 = 0;
	rA : 4 = 0;
	rB : 4 = 0;
	valC : 64 = 0;
	ifun : 4 = 0;
	valP : 64 = 0;
}

# ret bubble
wire need_ret_bubble : 1;
need_ret_bubble = (D_icode == RET || E_icode == RET || M_icode == RET);
bubble_D = mispredict || loadUse || need_ret_bubble;



reg_srcA = [
	D_icode in {RMMOVQ, IRMOVQ, OPQ, RRMOVQ, PUSHQ} : D_rA;
	1 : REG_NONE;
];

reg_srcB = [
	D_icode in {RMMOVQ, MRMOVQ, OPQ} : D_rB;
	D_icode in {PUSHQ, POPQ, CALL, RET} : REG_RSP;
	1 : REG_NONE;
];

# for pop, handles the rA
d_dstE = D_rA;


# for pop and push, handles the register values
d_dstM = [
	D_icode in {MRMOVQ} : D_rA;
	D_icode in {IRMOVQ, RRMOVQ, OPQ}: D_rB;
	D_icode in {PUSHQ, POPQ, CALL, RET} : REG_RSP;
	1: REG_NONE;
];

d_valA = [
	(reg_srcA == e_dstM) && (reg_srcA != REG_NONE): e_valM;
	(reg_srcA == m_dstM) && (reg_srcA != REG_NONE) : m_valM;
	(reg_srcA == reg_dstM) && (reg_srcA != REG_NONE) : reg_inputM;
	1 : reg_outputA;	
];

d_valB = [
	(reg_srcB == e_dstM) && (reg_srcB != REG_NONE): e_valM;
	(reg_srcB == m_dstM) && (reg_srcB != REG_NONE) : m_valM;
	(reg_srcB == reg_dstM) && (reg_srcB != REG_NONE) : reg_inputM;
	1 : reg_outputB;
];

d_icode = D_icode;
d_Stat = D_Stat;
d_valC = D_valC;
d_ifun = D_ifun;
d_valP = D_valP;

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
	valP : 64 = 0;
	dstE : 4 = REG_NONE;
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
        (E_icode in {IRMOVQ, JXX, CALL}) : E_valC;
	(E_icode in {MRMOVQ, RMMOVQ}) : E_valC + E_valB;
	E_icode in {PUSHQ} : E_valB - 8;
	E_icode in {POPQ, RET} : E_valB + 8; 
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

# detect misprediction
wire mispredict : 1;
mispredict = (e_icode == JXX && !conditionsMet);

bubble_E = mispredict || loadUse;


# store values into next register
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
e_valP = E_valP;
e_mispredict = mispredict;
e_dstE = E_dstE;
e_valB = E_valB;

########## Memory #############

# execute --> memory
register eM {
	Stat : 3 = 0;
	icode : 4 = 0;
	valA : 64 = 0;
	valB : 64 = 0;
	dstM : 4 = REG_NONE;
	valM : 64 = 0;
	SF : 1 = 0;
	ZF : 1 = 0;
	valP : 64 = 0;
	mispredict : 1 = 0;
	dstE : 4 = 0;
}

mem_readbit = M_icode in { MRMOVQ, POPQ, RET};
mem_writebit = M_icode in { RMMOVQ, PUSHQ, CALL };
mem_addr = [
	M_icode in { MRMOVQ, RMMOVQ, PUSHQ } : M_valM;
	M_icode in {CALL} : M_valB + 8;
	M_icode in {POPQ, RET} : M_valB;
        1: 0xBADBADBAD;
];
mem_input = [
	M_icode in {CALL} : M_valP;
        1: M_valA;
];

m_Stat = M_Stat;
m_icode = M_icode;
m_dstM  = M_dstM;
m_valM = [
	M_icode in {MRMOVQ} : mem_output;
	1 : M_valM;
]; 
m_valE = [	
	M_icode in {POPQ, RET} : mem_output;
	1: 0;
];
m_valA = M_valA;
m_valP = M_valP;
m_dstE = M_dstE;
m_valB = M_valB;

########## Writeback #############

# memory --> writeback
register mW {
	Stat : 3 = 0;
	icode : 4 = 0;
	dstM : 4 = REG_NONE;
	valM : 64 = 0;
	valA : 64 = 0;
	valP : 64 = 0;
	dstE : 4 = 0;
	valE : 64 = 0;
	valB : 64 = 0;
}

reg_dstM = [ 
	W_icode in {IRMOVQ, RRMOVQ, OPQ, MRMOVQ, PUSHQ, POPQ, CALL, RET} : W_dstM;
	1 : REG_NONE;
];

reg_dstE = [
	W_icode in {POPQ} : W_dstE; 
	1 : REG_NONE
];

reg_inputM = [
	W_icode == RRMOVQ : W_valA;
	W_icode in {IRMOVQ, OPQ, MRMOVQ, PUSHQ, POPQ, RET} : W_valM;
	W_icode in {CALL} : W_valB - 8;
	1 : 0xBADBADBAD;
];

reg_inputE = [
	W_icode in {POPQ} : W_valE;
	1 :  0;
];

Stat = W_Stat;

## Status Update

f_predPC = [
	(f_icode == JXX || f_icode == CALL) : f_valC; # prediction
	(W_Stat == STAT_HLT) : F_predPC; # stalling
	1 : f_valP;
];

