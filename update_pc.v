`timescale 1ns / 1ps

module adder(a,b,out);
    input [31:0] a,b;
    output [31:0] out;
    
    assign out = a+b;
endmodule

module sl2_32(in,out);
    input [31:0] in;
    output [31:0] out;
    
    assign out = {in[29:0],2'b00};
endmodule

module sl2_26(in,out);
    input [25:0] in;
    output [27:0] out;
    
    assign out = {in[25:0],2'b00};
endmodule

module update_pc (pc, jump_offset, signex_imm, read_data1, Branch, Br_Op, Zero, lt, ltu, gt, gtu, Jump, Jr, pc_next);

    input [31:0] pc, signex_imm;
    input [25:0] jump_offset;
    input [31:0] read_data1;
    input Branch, Zero, lt, ltu, gt, gtu, Jump, Jr;
    input [2:0] Br_Op;
    output [31:0] pc_next;
    
    wire [31:0] shifted_signex_imm;
    wire [31:0] pcplus4;
    wire [31:0] branch_addr;
    wire [27:0] shifted_jump_offset;
    wire [31:0] jump_addr;
    wire [31:0] mux1_res;
    wire select;
    
    //adders and shift-left-by-2's
    adder   pc_add     (pc,32'd4,pcplus4);
    sl2_32  sl2_imm    (signex_imm, shifted_signex_imm);
    adder   branch_add (shifted_signex_imm, pcplus4, branch_addr);
    
    sl2_26  sl2_jump   (jump_offset, shifted_jump_offset);
    assign  jump_addr = (Jr) ? read_data1 : {pcplus4[31:28],shifted_jump_offset};
    
    //muxes
    mux  mux1 (pcplus4, branch_addr, select, mux1_res);
    
    assign select =
    (Br_Op == 3'b000) ? (Branch &  Zero)       :
    (Br_Op == 3'b001) ? (Branch & ~Zero)       :
    (Br_Op == 3'b010) ? (Branch &  lt)         :
    (Br_Op == 3'b011) ? (Branch & (lt | Zero)) :
    (Br_Op == 3'b100) ? (Branch &  gt)         :
    (Br_Op == 3'b101) ? (Branch & (gt | Zero)) :
    (Br_Op == 3'b110) ? (Branch &  ltu)        :
    (Br_Op == 3'b111) ? (Branch &  gtu)        :
    1'b0;
    
    mux  mux2 (mux1_res, jump_addr, Jump, pc_next);
 
endmodule
