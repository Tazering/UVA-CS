# -*-sh-*- # this line enables partial syntax highlighting in emacs

######### The PC #############
register fF { pc:64 = 0; }


########## Fetch #############
pc = F_pc;

f_icode = i10bytes[4..8];
f_rA = i10bytes[12..16];
f_rB = i10bytes[8..12];
f_ifun = i10bytes[12..16];

f_valC = [
	f_icode in { JXX, CALL } : i10bytes[8..72];
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
f_pc = valP;


f_stat = [
	f_icode == HALT : STAT_HLT;
	f_icode > 0xb : STAT_INS;
	1 : STAT_AOK;
];

########## Decode #############
# figure 4.56 on page 426

register fD {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	rA:4 = REG_NONE;
	rB:4 = REG_NONE;
	valC:64 = 0;
	ifun : 4 = 0;
}



reg_srcA = [ # send to register file as read port; creates reg_outputA
	D_icode in {RMMOVQ, IRMOVQ, OPQ} : D_rA;
	1 : REG_NONE;
];
reg_srcB = [ # send to register file as read port; creates reg_outputB
	D_icode in {RMMOVQ, MRMOVQ, OPQ} : D_rB;
	1 : REG_NONE;
];

d_dstM = [
	D_icode in { MRMOVQ, IRMOVQ } : D_rA;
	1 : REG_NONE;
];

d_valA = [
	reg_srcA == REG_NONE: 0;
	reg_srcA == m_dstM : m_valM; # forward post-memory
	reg_srcA == W_dstM : W_valM; # forward pre-writeback
	reg_dstM == reg_srcA : reg_inputM;
	1 : reg_outputA; # returned by register file based on reg_srcA
];
d_valB = [
	reg_srcB == REG_NONE: 0;
	# forward from another phase
	reg_srcB == m_dstM : m_valM; # forward post-memory
	reg_srcB == W_dstM : W_valM; # forward pre-writeback
	reg_srcB == reg_dstM : reg_inputM;
	1 : reg_outputB; # returned by register file based on reg_srcA
];



d_stat = D_stat;
d_icode = D_icode;
d_valC = D_valC;
d_ifun = D_ifun;

########## Execute #############

register dE {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	valC:64 = 0;
	valA:64 = 0;
	valB:64 = 0;
	dstM:4 = REG_NONE;
	ifun : 4 = 0;
}

# alue
wire aluOutput : 64;
aluOutput = [
        (E_icode == OPQ && E_ifun == ADDQ) : E_valA + E_valB;
        (E_icode == OPQ && E_ifun == SUBQ) : E_valB - E_valA;
        (E_icode == OPQ && E_ifun == ANDQ) : E_valB & E_valA;
        (E_icode == OPQ && E_ifun == XORQ) : E_valA ^ E_valB;
	(E_icode == RRMOVQ) : E_valA;
	(E_icode == IRMOVQ) : E_valC;
	E_icode in {RMMOVQ, MRMOVQ} : E_valC + E_valB;
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

e_valE = aluOutput;

e_stat =  E_stat;
e_icode = E_icode;
e_valA = E_valA;
e_dstM = E_dstM;
e_ZF = C_ZF;
e_SF = C_SF;

########## Memory #############

register eM {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	valE:64 = 0;
	valA:64 = 0;
	dstM:4 = REG_NONE;
	SF : 1 = 0;
	ZF : 1 = 0;
}


mem_addr = [ # output to memory system
	M_icode in { RMMOVQ, MRMOVQ } : M_valE;
	1 : 0; # Other instructions don't need address
];
mem_readbit =  M_icode in { MRMOVQ }; # output to memory system
mem_writebit = M_icode in { RMMOVQ }; # output to memory system
mem_input = M_valA;

m_stat = M_stat;
m_valM = [
	M_icode in {IRMOVQ} : M_valE;
	1: mem_output; # input from mem_readbit and mem_addr
];
m_dstM = M_dstM;
m_icode = M_icode;
m_valA = M_valA;

########## Writeback #############
register mW {
	stat:3 = STAT_BUB;
	icode:4 = NOP;
	valM:64 = 0;
	valA : 64 = 0;
	dstM:4 = REG_NONE;
}

reg_inputM = [
	W_icode == RRMOVQ : W_valA;
	W_icode in {IRMOVQ, OPQ, MRMOVQ} : W_valM;
	1 : 0;
]; # output: sent to register file

reg_dstM = [
	W_icode in {IRMOVQ, RRMOVQ, OPQ, MRMOVQ, IRMOVQ} : W_dstM;
	1 : REG_NONE;
]; # output: sent to register file

Stat = W_stat; # output; halts execution and reports errors


################ Pipeline Register Control #########################

wire loadUse:1;

loadUse = (E_icode in {MRMOVQ}) && (E_dstM in {reg_srcA, reg_srcB}); 

### Fetch
stall_F = loadUse || f_stat != STAT_AOK;

### Decode
stall_D = loadUse;

### Execute
bubble_E = loadUse;

### Memory

### Writeback

