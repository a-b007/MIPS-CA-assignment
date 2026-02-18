OPCODE_FUNCT = {

    "add":  {"opcode":"000000","funct":"100000",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "sub":  {"opcode":"000000","funct":"100010",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "and":  {"opcode":"000000","funct":"100100",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "or":   {"opcode":"000000","funct":"100101",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "slt":  {"opcode":"000000","funct":"101010",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "sltu": {"opcode":"000000","funct":"101011",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "sll":  {"opcode":"000000","funct":"000000",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},

    "srl":  {"opcode":"000000","funct":"000010",
             "RegDst":1,"ALUSrc":0,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"10"},


    "addi": {"opcode":"001000","funct":None,
             "RegDst":0,"ALUSrc":1,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"00"},

    "andi": {"opcode":"001100","funct":None,
             "RegDst":0,"ALUSrc":1,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"11"},

    "ori":  {"opcode":"001101","funct":None,
             "RegDst":0,"ALUSrc":1,"MemtoReg":0,
             "RegWrite":1,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"11"},

    "lw":   {"opcode":"100011","funct":None,
             "RegDst":0,"ALUSrc":1,"MemtoReg":1,
             "RegWrite":1,"MemRead":1,"MemWrite":0,
             "Branch":0,"Jump":0,"ALUOp":"00"},

    "sw":   {"opcode":"101011","funct":None,
             "RegDst":None,"ALUSrc":1,"MemtoReg":None,
             "RegWrite":0,"MemRead":0,"MemWrite":1,
             "Branch":0,"Jump":0,"ALUOp":"00"},


    "beq":  {"opcode":"000100","funct":None,
             "RegDst":None,"ALUSrc":0,"MemtoReg":None,
             "RegWrite":0,"MemRead":0,"MemWrite":0,
             "Branch":1,"Jump":0,"ALUOp":"01"},

    "bne":  {"opcode":"000101","funct":None,
             "RegDst":None,"ALUSrc":0,"MemtoReg":None,
             "RegWrite":0,"MemRead":0,"MemWrite":0,
             "Branch":1,"Jump":0,"ALUOp":"01"},


    "j":    {"opcode":"000010","funct":None,
             "RegDst":None,"ALUSrc":None,"MemtoReg":None,
             "RegWrite":0,"MemRead":0,"MemWrite":0,
             "Branch":0,"Jump":1,"ALUOp":None},
}




def to_signed32(x):
    x &= ((1 << 32) - 1)
    return x if x < (1<<31) else x - (1 << 32)


opcodes = {}



class Register:
    def __init__(self):
        self.t = [0] * 10
        self.s = [0] * 8
        self.pc = 0

        self.zero = 0
        self.ra = 0
        self.v0 = 0
        self.v1 = 0



class Memory:
    
    def __init__(self, file_data = "data.txt",file_instr = "instruction.txt"):
        self.data_memory = file_data
        self.instr_memory = file_instr
        

    def read_data(self, addr):
        with open(self.data_memory, "r") as f:
            for i, line in enumerate(f):
                if i == addr:
                    return to_signed32(int(line.strip(), 2))
        return 0


    def read_instr(self, addr):
        with open(self.instr_memory, "r") as f:
            for i, line in enumerate(f):
                if i == addr:
                    return to_signed32(int(line.strip(), 2))
        return 0

    def write_data(self, addr, value):
        value &= ((1 << 32) - 1)

        with open(self.data_memory, "r") as f:
            lines = f.readlines()

        while len(lines) <= addr:
            lines.append("0".zfill(32) + "\n")

        lines[addr] = format(value, "032b") + "\n"

        with open(self.data_memory, "w") as f:
            f.writelines(lines)


    def write_instr(self, addr, value):
        value &= ((1 << 32) - 1)

        with open(self.instr_memory, "r") as f:
            lines = f.readlines()

        while len(lines) <= addr:
            lines.append("0".zfill(32) + "\n")

        lines[addr] = format(value, "032b") + "\n"

        with open(self.instr_memory, "w") as f:
            f.writelines(lines)



class CPU:
    def __init__(self):
        self.mem = Memory()
        self.reg = Register()
        self.running = True
        self.instr=""
        self.data=""

    def IF_stage(self):
        self.instr = str(self.mem.read_instr(self.reg.pc//4))
        self.reg.pc+=4


    def ID_stage(self):
        opcode = self.instr[0:6]

    


        
        
       
        


