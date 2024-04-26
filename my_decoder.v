`timescale 1ns / 1ps

`include "my_defs.v"

module my_decoder(
        input [31:0] inst_i,
        input zero_flag_i, // When ALUResult==0, it==0
        output reg [1:0] PCSrc, //00:+=4; 01:PCTarget; 10:ALUResult;
        output reg [2:0] RegWriteDataFrom, //000:ALUResult; 001:Read from Memory; 010:PC+4; 011:ImmExt; 100:PCTarget;
        output reg MemWriteEn,
        output reg [3:0] ALUControl, 
        output reg ALUSrc, //0:rs2; 1:ImmExt
        output reg [2:0] ImmSrc, //I:001; S:010; B:011; U:100; J:101; reserved:000,110,111; 
        output reg RegWriteEn
    );
wire [6:0] opcode = inst_i[6:0];
wire [2:0] func3 = inst_i[14:12];
wire [6:0] func7 = inst_i[31:25];

always @(*) begin
    case(opcode)
        7'b0110111: begin //LUI (Load Upper Immediate)
            PCSrc <= `PC_NOJUMP;
            RegWriteDataFrom <= `RWD_IMM;
            RegWriteEn <= 1'b1;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_NONE;
            ALUSrc <= `ALU_Imm;
            ImmSrc <= `IS_U;           
        end

        7'b0010111: begin //AUIPC (Add Upper Immediate to Program Counter)
            PCSrc <= `PC_NOJUMP;
            RegWriteDataFrom <= `RWD_PCT;
            RegWriteEn <= 1'b1;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_NONE;
            ALUSrc <= `ALU_Imm;
            ImmSrc <= `IS_U;            
        end

        7'b1101111: begin //JAL (Jump And Link)
            PCSrc <= `PC_J_OFFSET;
            RegWriteDataFrom <= `RWD_PC_;
            RegWriteEn <= 1'b1;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_NONE;
            ALUSrc <= `ALU_Imm;
            ImmSrc <= `IS_J;            
        end

        7'b1100111: begin //JALR (Jump And Link Register)
            PCSrc <= `PC_J_ALU;
            RegWriteDataFrom <= `RWD_PC_;
            RegWriteEn <= 1'b1;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_ADD;
            ALUSrc <= `ALU_Imm;
            ImmSrc <= `IS_I;            
        end

        7'b1100011: begin //B-type instructions
            case(func3)
                3'b000: begin //BEQ
                    PCSrc <= zero_flag_i?`PC_NOJUMP:`PC_J_OFFSET;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_XOR;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_B;
                end

                3'b001: begin //BNE
                    PCSrc <= zero_flag_i?`PC_J_OFFSET:`PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_XOR;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_B;
                end

                3'b100: begin //BLT
                    PCSrc <= zero_flag_i?`PC_J_OFFSET:`PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN_SIGNED;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_B;
                end

                3'b101: begin //BGE
                    PCSrc <= zero_flag_i?`PC_NOJUMP:`PC_J_OFFSET;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN_SIGNED;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_B;
                end

                3'b110: begin //BLTU
                    PCSrc <= zero_flag_i?`PC_J_OFFSET:`PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_B;
                end

                3'b111: begin //BGEU
                    PCSrc <= zero_flag_i?`PC_NOJUMP:`PC_J_OFFSET;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_B;
                end

                default: begin //reserved (NOP)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

            endcase
        end

        7'b0000011: begin //I-type load instructions
            case(func3)
                3'b000: begin //LB (Load Byte) ?????????????NOP
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b001: begin //LH (Load Halfword) ?????????????NOP
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b010: begin //LW (Load Word)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_MEM;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_ADD;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b100: begin //LBU (Load Byte Unsigned) ?????????????NOP
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b101: begin //LHU (Load Halfword Unsigned) ?????????????NOP
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                default: begin //reserved (NOP)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

            endcase
        end

        7'b0100011: begin //S-type instructions
            case(func3)
                3'b000: begin //SB ?????????????NOP
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b001: begin //SH ?????????????NOP
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b010: begin //SW 
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_MEM;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b1;
                    ALUControl <= `ALU_ADD;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_S;
                end

                default: begin //reserved (NOP)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

            endcase
        end

        7'b0010011: begin //I-type calculative instructions
            case(func3)
                3'b000: begin //ADDI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_ADD;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b010: begin //SLTI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN_SIGNED;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b011: begin //SLTIU
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b100: begin //XORI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_XOR;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b110: begin //ORI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_OR;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b111: begin //ANDI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_AND;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b001: begin //SLLI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_SHIFTL;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end

                3'b101: begin //SRLI, SRAI
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    if (func7 == 7'b0000000)
                        ALUControl <= `ALU_SHIFTR;
                    else if (func7 == 7'b0100000)
                        ALUControl <= `ALU_SHIFTR_ARITH;
                    else ALUControl <= `ALU_SHIFTR;
                    ALUSrc <= `ALU_Imm;
                    ImmSrc <= `IS_I;
                end


                default: begin //reserved (NOP)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

            endcase
        end

        7'b0110011: begin //R-type instructions
            case(func3)
                3'b000: begin //ADD, SUB
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    if (func7 == 7'b0000000)
                        ALUControl <= `ALU_ADD;
                    else if (func7 == 7'b0100000)
                        ALUControl <= `ALU_SUB;
                    else ALUControl <= `ALU_ADD;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b001: begin //SLL (Shift Left Logical)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_SHIFTL;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b010: begin //SLT (Set Less Than)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN_SIGNED;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b011: begin //SLTU
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_LESS_THAN;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b100: begin //XOR
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_XOR;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b101: begin //SRL, SRA
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    if (func7 == 7'b0000000)
                        ALUControl <= `ALU_SHIFTR;
                    else if (func7 == 7'b0100000)
                        ALUControl <= `ALU_SHIFTR_ARITH;
                    else ALUControl <= `ALU_SHIFTR;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b110: begin //OR
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_OR;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                3'b111: begin //AND
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b1;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_AND;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

                default: begin //reserved (NOP)
                    PCSrc <= `PC_NOJUMP;
                    RegWriteDataFrom <= `RWD_ALU;
                    RegWriteEn <= 1'b0;
                    MemWriteEn <= 1'b0;
                    ALUControl <= `ALU_NONE;
                    ALUSrc <= `ALU_reg;
                    ImmSrc <= `IS_I;
                end

            endcase
        end

        7'b0001111: begin //FENCE ?????????????NOP
            PCSrc <= `PC_NOJUMP;
            RegWriteDataFrom <= `RWD_ALU;
            RegWriteEn <= 1'b0;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_NONE;
            ALUSrc <= `ALU_reg;
            ImmSrc <= `IS_I;
        end

        7'b1110011: begin //ECALL, EBREAK ?????????????NOP
            PCSrc <= `PC_NOJUMP;
            RegWriteDataFrom <= `RWD_ALU;
            RegWriteEn <= 1'b0;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_NONE;
            ALUSrc <= `ALU_reg;
            ImmSrc <= `IS_I;
        end

        default: begin //reserved (NOP)
            PCSrc <= `PC_NOJUMP;
            RegWriteDataFrom <= `RWD_ALU;
            RegWriteEn <= 1'b0;
            MemWriteEn <= 1'b0;
            ALUControl <= `ALU_NONE;
            ALUSrc <= `ALU_reg;
            ImmSrc <= `IS_I;
        end
    endcase

end

endmodule
