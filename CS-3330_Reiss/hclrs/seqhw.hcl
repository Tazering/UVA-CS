#An example file in our custom HCL variant, with lots of comments

register pP {  
    # our own internal register. P_pc is its output, p_pc is its input.
	pc:64 = 0; # 64-bits wide; 0 is its default value.
	
	# we could add other registers to the P register bank
	# register bank should be a lower-case letter and an upper-case letter, in that order.
	
	# there are also two other signals we can optionally use:
	# "bubble_P = true" resets every register in P to its default value
	# "stall_P = true" causes P_pc not to change, ignoring p_pc's value
} 

# "pc" is a pre-defined input to the instruction memory and is the 
# address to fetch 10 bytes from (into pre-defined output "i10bytes").
pc = P_pc;

# we can define our own input/output "wires" of any number of 0<bits<=80
wire opcode:8, icode:4, rA: 4, rB: 4, valImmediate:64, ifun : 4, aluOutput : 64, c_SF : 1, c_ZF : 1, conditionsMet : 1, valP : 64;


# the x[i..j] means "just the bits between i and j".  x[0..1] is the 
# low-order bit, similar to what the c code "x&1" does; "x&7" is x[0..3]
opcode = i10bytes[0..8];   # first byte read from instruction memory
icode = opcode[4..8]; # top nibble of that byte
rA = i10bytes[12..16];
rB = i10bytes[8..12];
ifun = i10bytes[0..4];

valImmediate = [
	(icode == IRMOVQ ||
	icode == RMMOVQ ||
	icode == MRMOVQ) : i10bytes[16..80];
	1 : i10bytes[8..72];
];

reg_srcA = rA;

reg_srcB = [
	(icode == PUSHQ || icode == POPQ || icode == CALL) : REG_RSP;
	1 : rB;
]; 


# alu output
aluOutput = [
	(icode == OPQ && ifun == ADDQ) : reg_outputA + reg_outputB;
	(icode == OPQ && ifun == SUBQ) : reg_outputB - reg_outputA;
	(icode == OPQ && ifun == ANDQ) : reg_outputB & reg_outputA;
	(icode == OPQ && ifun == XORQ) : reg_outputA ^ reg_outputB;
	(icode == RMMOVQ || icode == MRMOVQ) : valImmediate + reg_outputB;
	1 : 0;
];

# condition codes
register cC {
	SF : 1 = 0;
	ZF : 1 = 1;
}

# update condition codes
c_ZF = [
	icode == OPQ : (aluOutput == 0);
	1 : C_ZF
];

c_SF = [
	icode == OPQ : (aluOutput >= 0x8000000000000000);
	1 : C_SF;
];

# conditions for cmovXX
conditionsMet = [
	ifun == ALWAYS : 1;
	ifun == LE : C_SF || C_ZF;
	ifun == LT : C_SF;
	ifun == EQ : C_ZF;
	ifun == NE : !C_ZF;
	ifun == GE : !C_SF;
	ifun == GT : !C_SF && !C_ZF;
	1 : 0;	

];

valP = [
        (icode == HALT ||
        icode == RET ||
        icode == NOP) : 1;
        (icode == CALL ||
        icode == JXX)  : 9;
        (icode == RRMOVQ ||
        icode == OPQ ||
        icode == PUSHQ ||
        icode == POPQ) : 2;
	1 : 10;
];

# handle memory
mem_writebit = [
	(icode == RMMOVQ || icode == PUSHQ || icode == CALL) : 1;
	1 : 0;

];

mem_readbit = [
	(icode == MRMOVQ || icode == POPQ) : 1;
	1 : 0;
];

mem_input = [
	(icode == RMMOVQ || icode == PUSHQ) : reg_outputA;
	(icode == CALL) : P_pc + valP;
	1 : 0;
];

mem_addr = [
	(icode == RMMOVQ || icode == MRMOVQ) : aluOutput;
	(icode == PUSHQ || icode == CALL) : reg_outputB - 8;
	(icode == POPQ) : reg_outputB;
	1 : 0;

];

# for popq
reg_inputM = [
	(icode == POPQ) : mem_output;
	1 : 0;
];

reg_dstM = [
	(icode == POPQ) : rA;
	1 : REG_NONE;
];


reg_inputE = [
        (icode == IRMOVQ) : valImmediate;
        (icode == RRMOVQ) : reg_outputA;
        (icode == OPQ) : aluOutput;
	(icode == MRMOVQ) : mem_output;
	(icode == PUSHQ || icode == CALL) : reg_outputB - 8;
	(icode == POPQ) : reg_outputB + 8;
        1 : 0xF;
];

reg_dstE = [
        (icode == RRMOVQ && conditionsMet) || (icode == OPQ) || (icode == IRMOVQ) : rB;
	(icode == PUSHQ || icode == POPQ || icode == CALL) : REG_RSP;
	(icode == MRMOVQ) : rA;
        1 : REG_NONE;
];



/* we could also have done i10bytes[4..8] directly, but I wanted to
 * demonstrate more bit slicing... and all 3 kinds of comments      */
// this is the third kind of comment

# named constants can help make code readable
const TOO_BIG = 0xC; # the first unused icode in Y86-64

# some named constants are built-in: the icodes, ifuns, STAT_??? and REG_???


# Stat is a built-in output; STAT_HLT means "stop", STAT_AOK means 
# "continue".  The following uses the mux syntax described in the 
# textbook
Stat = [
	icode == HALT : STAT_HLT;
	icode >= TOO_BIG : STAT_INS;
	1             : STAT_AOK;
];

p_pc = [
 	(icode == JXX && conditionsMet) : valImmediate;
	(icode == CALL) : valImmediate;
	1 : P_pc + valP;
];


#p_pc = P_pc + valP; # you may use math ops directly...
