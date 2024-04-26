`timescale 1ns / 1ps

module data_mem(
    input clk,
    input rst_n,
    input [31:0] address,
    input WRITE_ENABLE,
    input [31:0] WRITE_DATA,
    output reg [31:0] READ_DATA
);
    reg [2047:0] mem_file;
always @(*) begin
    READ_DATA <= mem_file[8*address +: 32];
end
always @ (posedge clk) begin
    if (!rst_n) begin
        mem_file <= 2048'b0;
    end
    else if (WRITE_ENABLE) begin
        mem_file[8*address +: 32] <= WRITE_DATA;
    end
end
endmodule