`timescale 1ns / 1ps

`include "my_defs.v"

module top(
        input clk,
        input rst_n
    );

    wire [1:0]          pc_src;
    wire [31:0]         inst;
    wire [31:0]         pc;
    wire [31:0]         inst_address = pc;

    wire                reg_write_enable;
    wire [4:0]          reg_write_address = inst[11:7];
    wire [2:0]          reg_write_data_from;
    reg  [31:0]         reg_write_data;
    wire [4:0]          reg_read_address_1 = inst[19:15];
    wire [31:0]         reg_read_data_1;
    wire [4:0]          reg_read_address_2 = inst[24:20];
    wire [31:0]         reg_read_data_2;

    wire                memory_write_enable;
    wire [31:0]         memory_address = alu_o;
    wire [31:0]         memory_write_data = reg_read_data_2;
    wire [31:0]         memory_read_data;

    wire [2:0]          imm_source;
    wire [31:0]         imm_ext;

    wire [31:0]         alu_a = reg_read_data_1;
    reg  [31:0]         alu_b;
    wire                alu_b_source;
    wire [3:0]          alu_op;
    wire [31:0]         alu_o;
    wire                zero_flag;

    wire [31:0]         pc_immext = pc + imm_ext;

    always @ (*) begin
        case(alu_b_source)
            `ALU_reg: alu_b = reg_read_data_2;
            `ALU_Imm: alu_b = imm_ext;
        endcase
    end

    always @ (*) begin
        case(reg_write_data_from)
            `RWD_ALU: reg_write_data = alu_o;
            `RWD_MEM: reg_write_data = memory_read_data;
            `RWD_PC_: reg_write_data = pc + 4;
            `RWD_IMM: reg_write_data = imm_ext;
            `RWD_PCT: reg_write_data = pc_immext;
        endcase
    end

    pc_sys u_pc(
        .clk(clk),
        .rst_n(rst_n),
        .PCSrc(pc_src),
        .PC_J_TARGET(pc_immext),
        .ALUResult(alu_o),
        .PC(pc)
    );

    alu u_alu(
        .OP(alu_op),
        .a_i(alu_a),
        .b_i(alu_b),
        .OUT(alu_o),
        .ZERO_FLAG(zero_flag)
    );

    imm_ext u_imm(
        .inst_i(inst),
        .ImmSrc(imm_source),
        .ImmExt(imm_ext)
    );

    data_mem u_data(
        .clk(clk),
        .rst_n(rst_n),
        .address(memory_address),
        .WRITE_ENABLE(memory_write_enable),
        .WRITE_DATA(memory_write_data),
        .READ_DATA(memory_read_data)
    );

    inst_mem u_inst(
        .address(inst_address),
        .READ_DATA(inst)
    );

    register u_register(
        .clk(clk),
        .rst_n(rst_n),
        .a1(reg_read_address_1),
        .a2(reg_read_address_2),
        .a3(reg_write_address),
        .WRITE_DATA(reg_write_data),
        .WRITE_ENABLE(reg_write_enable),
        .READ_DATA_1(reg_read_data_1),
        .READ_DATA_2(reg_read_data_2)
    );

    my_decoder u_decoder(
        .inst_i(inst),
        .zero_flag_i(zero_flag),
        .PCSrc(pc_src),
        .RegWriteDataFrom(reg_write_data_from),
        .MemWriteEn(memory_write_enable),
        .ALUControl(alu_op),
        .ALUSrc(alu_b_source),
        .ImmSrc(imm_source),
        .RegWriteEn(reg_write_enable)
    );
endmodule
