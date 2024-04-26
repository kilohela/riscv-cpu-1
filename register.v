`timescale 1ns / 1ps

module register(
        input clk,
        input rst_n,
        input [4:0] a1,
        input [4:0] a2,
        input [4:0] a3,
        input [31:0] WRITE_DATA,
        input WRITE_ENABLE,
        output reg [31:0] READ_DATA_1,
        output reg [31:0] READ_DATA_2
    );
    wire [31:0] r_x0_zero = 32'h00000000;
    reg [31:0] r_x1_ra;
    reg [31:0] r_x2_sp;
    reg [31:0] r_x3_gp;
    reg [31:0] r_x4_tp;
    reg [31:0] r_x5_t0;
    reg [31:0] r_x6_t1;
    reg [31:0] r_x7_t2;
    reg [31:0] r_x8_s0;
    reg [31:0] r_x9_s1;
    reg [31:0] r_x10_a0;
    reg [31:0] r_x11_a1;
    reg [31:0] r_x12_a2;
    reg [31:0] r_x13_a3;
    reg [31:0] r_x14_a4;
    reg [31:0] r_x15_a5;
    reg [31:0] r_x16_a6;
    reg [31:0] r_x17_a7;
    reg [31:0] r_x18_s2;
    reg [31:0] r_x19_s3;
    reg [31:0] r_x20_s4;
    reg [31:0] r_x21_s5;
    reg [31:0] r_x22_s6;
    reg [31:0] r_x23_s7;
    reg [31:0] r_x24_s8;
    reg [31:0] r_x25_s9;
    reg [31:0] r_x26_s10;
    reg [31:0] r_x27_s11;
    reg [31:0] r_x28_t3;
    reg [31:0] r_x29_t4;
    reg [31:0] r_x30_t5;
    reg [31:0] r_x31_t6;

always @ (posedge clk) begin
    if (!rst_n) begin
        r_x1_ra        <= 32'h000000FF;
        r_x2_sp        <= 32'h000000F0;
        r_x3_gp        <= 32'h00000000;
        r_x4_tp        <= 32'h00000000;
        r_x5_t0        <= 32'h00000000;
        r_x6_t1        <= 32'h00000000;
        r_x7_t2        <= 32'h00000000;
        r_x8_s0        <= 32'h00000000;
        r_x9_s1        <= 32'h00000000;
        r_x10_a0       <= 32'h00000000;
        r_x11_a1       <= 32'h00000000;
        r_x12_a2       <= 32'h00000000;
        r_x13_a3       <= 32'h00000000;
        r_x14_a4       <= 32'h00000000;
        r_x15_a5       <= 32'h00000000;
        r_x16_a6       <= 32'h00000000;
        r_x17_a7       <= 32'h00000000;
        r_x18_s2       <= 32'h00000000;
        r_x19_s3       <= 32'h00000000;
        r_x20_s4       <= 32'h00000000;
        r_x21_s5       <= 32'h00000000;
        r_x22_s6       <= 32'h00000000;
        r_x23_s7       <= 32'h00000000;
        r_x24_s8       <= 32'h00000000;
        r_x25_s9       <= 32'h00000000;
        r_x26_s10      <= 32'h00000000;
        r_x27_s11      <= 32'h00000000;
        r_x28_t3       <= 32'h00000000;
        r_x29_t4       <= 32'h00000000;
        r_x30_t5       <= 32'h00000000;
        r_x31_t6       <= 32'h00000000;
    end
    else if (WRITE_ENABLE) begin
        case(a3)
            5'd1:  r_x1_ra    <= WRITE_DATA;
            5'd2:  r_x2_sp    <= WRITE_DATA;
            5'd3:  r_x3_gp    <= WRITE_DATA;
            5'd4:  r_x4_tp    <= WRITE_DATA;
            5'd5:  r_x5_t0    <= WRITE_DATA;
            5'd6:  r_x6_t1    <= WRITE_DATA;
            5'd7:  r_x7_t2    <= WRITE_DATA;
            5'd8:  r_x8_s0    <= WRITE_DATA;
            5'd9:  r_x9_s1    <= WRITE_DATA;
            5'd10: r_x10_a0   <= WRITE_DATA;
            5'd11: r_x11_a1   <= WRITE_DATA;
            5'd12: r_x12_a2   <= WRITE_DATA;
            5'd13: r_x13_a3   <= WRITE_DATA;
            5'd14: r_x14_a4   <= WRITE_DATA;
            5'd15: r_x15_a5   <= WRITE_DATA;
            5'd16: r_x16_a6   <= WRITE_DATA;
            5'd17: r_x17_a7   <= WRITE_DATA;
            5'd18: r_x18_s2   <= WRITE_DATA;
            5'd19: r_x19_s3   <= WRITE_DATA;
            5'd20: r_x20_s4   <= WRITE_DATA;
            5'd21: r_x21_s5   <= WRITE_DATA;
            5'd22: r_x22_s6   <= WRITE_DATA;
            5'd23: r_x23_s7   <= WRITE_DATA;
            5'd24: r_x24_s8   <= WRITE_DATA;
            5'd25: r_x25_s9   <= WRITE_DATA;
            5'd26: r_x26_s10  <= WRITE_DATA;
            5'd27: r_x27_s11  <= WRITE_DATA;
            5'd28: r_x28_t3   <= WRITE_DATA;
            5'd29: r_x29_t4   <= WRITE_DATA;
            5'd30: r_x30_t5   <= WRITE_DATA;
            5'd31: r_x31_t6   <= WRITE_DATA;
        endcase
    end
end

always @ (*) begin
    case(a1)
        5'd0:  READ_DATA_1 <= r_x0_zero;
        5'd1:  READ_DATA_1 <= r_x1_ra;
        5'd2:  READ_DATA_1 <= r_x2_sp;
        5'd3:  READ_DATA_1 <= r_x3_gp;
        5'd4:  READ_DATA_1 <= r_x4_tp;
        5'd5:  READ_DATA_1 <= r_x5_t0;
        5'd6:  READ_DATA_1 <= r_x6_t1;
        5'd7:  READ_DATA_1 <= r_x7_t2;
        5'd8:  READ_DATA_1 <= r_x8_s0;
        5'd9:  READ_DATA_1 <= r_x9_s1;
        5'd10: READ_DATA_1 <= r_x10_a0;
        5'd11: READ_DATA_1 <= r_x11_a1;
        5'd12: READ_DATA_1 <= r_x12_a2;
        5'd13: READ_DATA_1 <= r_x13_a3;
        5'd14: READ_DATA_1 <= r_x14_a4;
        5'd15: READ_DATA_1 <= r_x15_a5;
        5'd16: READ_DATA_1 <= r_x16_a6;
        5'd17: READ_DATA_1 <= r_x17_a7;
        5'd18: READ_DATA_1 <= r_x18_s2;
        5'd19: READ_DATA_1 <= r_x19_s3;
        5'd20: READ_DATA_1 <= r_x20_s4;
        5'd21: READ_DATA_1 <= r_x21_s5;
        5'd22: READ_DATA_1 <= r_x22_s6;
        5'd23: READ_DATA_1 <= r_x23_s7;
        5'd24: READ_DATA_1 <= r_x24_s8;
        5'd25: READ_DATA_1 <= r_x25_s9;
        5'd26: READ_DATA_1 <= r_x26_s10;
        5'd27: READ_DATA_1 <= r_x27_s11;
        5'd28: READ_DATA_1 <= r_x28_t3;
        5'd29: READ_DATA_1 <= r_x29_t4;
        5'd30: READ_DATA_1 <= r_x30_t5;
        5'd31: READ_DATA_1 <= r_x31_t6;
    endcase

    case(a2)
        5'd0:  READ_DATA_2 <= r_x0_zero;
        5'd1:  READ_DATA_2 <= r_x1_ra;
        5'd2:  READ_DATA_2 <= r_x2_sp;
        5'd3:  READ_DATA_2 <= r_x3_gp;
        5'd4:  READ_DATA_2 <= r_x4_tp;
        5'd5:  READ_DATA_2 <= r_x5_t0;
        5'd6:  READ_DATA_2 <= r_x6_t1;
        5'd7:  READ_DATA_2 <= r_x7_t2;
        5'd8:  READ_DATA_2 <= r_x8_s0;
        5'd9:  READ_DATA_2 <= r_x9_s1;
        5'd10: READ_DATA_2 <= r_x10_a0;
        5'd11: READ_DATA_2 <= r_x11_a1;
        5'd12: READ_DATA_2 <= r_x12_a2;
        5'd13: READ_DATA_2 <= r_x13_a3;
        5'd14: READ_DATA_2 <= r_x14_a4;
        5'd15: READ_DATA_2 <= r_x15_a5;
        5'd16: READ_DATA_2 <= r_x16_a6;
        5'd17: READ_DATA_2 <= r_x17_a7;
        5'd18: READ_DATA_2 <= r_x18_s2;
        5'd19: READ_DATA_2 <= r_x19_s3;
        5'd20: READ_DATA_2 <= r_x20_s4;
        5'd21: READ_DATA_2 <= r_x21_s5;
        5'd22: READ_DATA_2 <= r_x22_s6;
        5'd23: READ_DATA_2 <= r_x23_s7;
        5'd24: READ_DATA_2 <= r_x24_s8;
        5'd25: READ_DATA_2 <= r_x25_s9;
        5'd26: READ_DATA_2 <= r_x26_s10;
        5'd27: READ_DATA_2 <= r_x27_s11;
        5'd28: READ_DATA_2 <= r_x28_t3;
        5'd29: READ_DATA_2 <= r_x29_t4;
        5'd30: READ_DATA_2 <= r_x30_t5;
        5'd31: READ_DATA_2 <= r_x31_t6;
    endcase
end
endmodule
