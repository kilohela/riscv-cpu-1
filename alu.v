`timescale 1ns / 1ps

`include "my_defs.v"

module alu(
        input [3:0] OP,
        input [31:0] a_i,
        input [31:0] b_i,
        output reg [31:0] OUT,
        output ZERO_FLAG
    );
    reg [31:16]     shift_right_fill_r;
    reg [31:0]      shift_right_1_r;
    reg [31:0]      shift_right_2_r;
    reg [31:0]      shift_right_4_r;
    reg [31:0]      shift_right_8_r;

    reg [31:0]      shift_left_1_r;
    reg [31:0]      shift_left_2_r;
    reg [31:0]      shift_left_4_r;
    reg [31:0]      shift_left_8_r;
always @(*) begin
    case(OP)
        `ALU_SHIFTL: begin
            if (b_i[0]) 
                shift_left_1_r = {a_i[30:0], 1'b0};
            else shift_left_1_r = a_i;

            if (b_i[1]) 
                shift_left_2_r = {shift_left_1_r[29:0], 2'b00};
            else shift_left_2_r = shift_left_1_r;

            if (b_i[0]) 
                shift_left_4_r = {shift_left_2_r[27:0], 4'h0};
            else shift_left_4_r = shift_left_2_r;

            if (b_i[0]) 
                shift_left_8_r = {shift_left_4_r[23:0], 8'h00};
            else shift_left_8_r = shift_left_4_r;

            if (b_i[0]) 
                OUT = {shift_left_8_r[15:0], 16'h0000};
            else OUT = shift_left_8_r;
        end

        `ALU_SHIFTR, `ALU_SHIFTR_ARITH: begin
            if (a_i[31] == 1'b1 && OP == `ALU_SHIFTR_ARITH)
                shift_right_fill_r = 16'b1111111111111111;
            else
                shift_right_fill_r = 16'b0000000000000000;

            if (b_i[0] == 1'b1)
                shift_right_1_r = {shift_right_fill_r[31], a_i[31:1]};
            else
                shift_right_1_r = a_i;

            if (b_i[1] == 1'b1)
                shift_right_2_r = {shift_right_fill_r[31:30], shift_right_1_r[31:2]};
            else
                shift_right_2_r = shift_right_1_r;

            if (b_i[2] == 1'b1)
                shift_right_4_r = {shift_right_fill_r[31:28], shift_right_2_r[31:4]};
            else
                shift_right_4_r = shift_right_2_r;

            if (b_i[3] == 1'b1)
                shift_right_8_r = {shift_right_fill_r[31:24], shift_right_4_r[31:8]};
            else
                shift_right_8_r = shift_right_4_r;

            if (b_i[4] == 1'b1)
                OUT = {shift_right_fill_r[31:16], shift_right_8_r[31:16]};
            else
                OUT = shift_right_8_r;
        end

        `ALU_ADD: begin
            OUT <= a_i + b_i;
        end
        
        `ALU_SUB: begin
            OUT <= a_i - b_i;
        end

        `ALU_AND: begin
            OUT <= a_i & b_i;
        end

        `ALU_OR: begin
            OUT <= a_i | b_i;
        end

        `ALU_XOR: begin
            OUT <= a_i ^ b_i;
        end

        `ALU_LESS_THAN: begin
            OUT <= (a_i < b_i) ? 32'h1 : 32'h0;
        end

        `ALU_LESS_THAN_SIGNED: begin
            if (a_i[31]==b_i[31]) OUT <= (a_i < b_i) ? 32'h1 : 32'h0;
            else OUT <= a_i[31] ? 32'h1 : 32'h0;
        end

        `ALU_NONE: begin
            OUT <= a_i;
        end

        default: begin
            OUT <= a_i;
        end

    endcase
end

assign ZERO_FLAG = |OUT;

endmodule