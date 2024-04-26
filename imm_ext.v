`timescale 1ns / 1ps

`include "my_defs.v"

module imm_ext(
        input [31:0] inst_i, //only use [31:7]
        input [2:0] ImmSrc,
        output reg [31:0] ImmExt
    );
    always @(*) begin
        case(ImmSrc) 
            `IS_I: begin
                ImmExt <= {{21{inst_i[31]}}, inst_i[30:25], inst_i[24:21], inst_i[20]};
            end

            `IS_S: begin
                ImmExt <= {{21{inst_i[31]}}, inst_i[30:25], inst_i[11:8], inst_i[7]};
            end

            `IS_B: begin
                ImmExt <= {{20{inst_i[31]}}, inst_i[7], inst_i[30:25], inst_i[11:8], 1'b0};
            end

            `IS_U: begin
                ImmExt <= {inst_i[31], inst_i[30:20], inst_i[19:12], 11'b000_0000_0000};
            end

            `IS_J: begin
                ImmExt <= {{12{inst_i[31]}}, inst_i[19:12], inst_i[20], inst_i[30:25], inst_i[24:21], 1'b0};
            end
            default: ImmExt <= {{21{inst_i[31]}}, inst_i[30:25], inst_i[24:21], inst_i[20]};
        endcase
    end
    
endmodule