`timescale 1ns / 1ps

`include "my_defs.v"

module pc_sys(
        input clk,
        input rst_n,
        input [1:0] PCSrc,
        input [31:0] PC_J_TARGET,
        input [31:0] ALUResult,
        output reg [31:0] PC
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            PC <=  `PC_INITIAL_ADDRESS;
        end
        else if (PCSrc == `PC_J_ALU)PC <= ALUResult;
        else if (PCSrc == `PC_J_OFFSET) PC <= PC_J_TARGET;
        else PC <= PC + 4;
    end
endmodule
