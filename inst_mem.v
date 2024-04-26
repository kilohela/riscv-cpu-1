`timescale 1ns / 1ps

module inst_mem(
    input [31:0] address,
    output reg [31:0] READ_DATA
);
    wire [800:0] mem_file;

    //debug
    assign mem_file [32*0  +: 32] = 32'h00700513;                   //0
    assign mem_file [32*1  +: 32] = 32'h6f100593;                   //4
    assign mem_file [32*2  +: 32] = 32'hfd010113;                   //8
    assign mem_file [32*3  +: 32] = 32'h02812623;                   //c
    assign mem_file [32*4  +: 32] = 32'h03010413;                   //10
    assign mem_file [32*5  +: 32] = 32'hfca42e23;                   //14
    assign mem_file [32*6  +: 32] = 32'hfcb42c23;                   //18
    assign mem_file [32*7  +: 32] = 32'hfe042623;                   //1c
    assign mem_file [32*8  +: 32] = 32'h0140006f;                   //20
    assign mem_file [32*9  +: 32] = 32'hfec42703;                   //24
    assign mem_file [32*10 +: 32] = 32'hfd842783;                   //28
    assign mem_file [32*11 +: 32] = 32'h00f707b3;                   //2c
    assign mem_file [32*12 +: 32] = 32'hfef42623;                   //30
    assign mem_file [32*13 +: 32] = 32'hfdc42783;                   //34
    assign mem_file [32*14 +: 32] = 32'hfff78713;                   //38
    assign mem_file [32*15 +: 32] = 32'hfce42e23;                   //3c
    assign mem_file [32*16 +: 32] = 32'hfe0792e3;                   //40
    assign mem_file [32*17 +: 32] = 32'hfec42783;                   //44
    assign mem_file [32*18 +: 32] = 32'h00078513;                   //48
    assign mem_file [32*19 +: 32] = 32'h02c12403;                   //4c
    assign mem_file [32*20 +: 32] = 32'h03010113;                   //50
    assign mem_file [32*21 +: 32] = 32'h00008067;                   //54
    //debug

always @(*) begin
    READ_DATA <= mem_file[8*address +: 32];
end
endmodule