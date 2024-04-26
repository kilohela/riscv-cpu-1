//--------------------------------------------------------------------
// ALU Operations
//--------------------------------------------------------------------
`define ALU_NONE                                4'b0000
`define ALU_SHIFTL                              4'b0001
`define ALU_SHIFTR                              4'b0010
`define ALU_SHIFTR_ARITH                        4'b0011
`define ALU_ADD                                 4'b0100
`define ALU_SUB                                 4'b0110
`define ALU_AND                                 4'b0111
`define ALU_OR                                  4'b1000
`define ALU_XOR                                 4'b1001
`define ALU_LESS_THAN                           4'b1010
`define ALU_LESS_THAN_SIGNED                    4'b1011


//--------------------------------------------------------------------
// ALU Sources
//--------------------------------------------------------------------
`define ALU_reg                                 1'b0
`define ALU_Imm                                 1'b1



//--------------------------------------------------------------------
// PC Sources
//--------------------------------------------------------------------
`define PC_NOJUMP                               2'b00           // PC += 4
`define PC_J_OFFSET                             2'b01           // PC += offset
`define PC_J_ALU                                2'b10           // PC = ALUResult
`define PC_J_IMM                                2'b11           // PC = imm_ext



`define PC_INITIAL_ADDRESS                      32'b0000_0000_0000_0000 //??????????????????????? 


//--------------------------------------------------------------------
// RegWriteDataFrom
//--------------------------------------------------------------------
`define RWD_ALU                                 3'b000          // from ALU Result
`define RWD_MEM                                 3'b001          // from Memory
`define RWD_PC_                                 3'b010          // PC + 4
`define RWD_IMM                                 3'b011          // ImmExt
`define RWD_PCT                                 3'b100          // PC Target


//--------------------------------------------------------------------
// ImmSrc
//--------------------------------------------------------------------
`define IS_I                                    3'b001
`define IS_S                                    3'b010
`define IS_B                                    3'b011
`define IS_U                                    3'b100
`define IS_J                                    3'b101


//--------------------------------------------------------------------
// ImmSrc
//--------------------------------------------------------------------