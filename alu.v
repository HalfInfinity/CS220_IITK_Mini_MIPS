`timescale 1ns / 1ps

`define AND   4'b0000
`define OR    4'b0001
`define ADD   4'b0010
`define SUB   4'b0110
`define SEQ   4'b0101
`define SLT   4'b0111
`define SLTU  4'b1111
`define XOR   4'b0011
`define NOT   4'b0100
`define SLL   4'b1000
`define SLA   4'b1001
`define SRL   4'b1010
`define SRA   4'b1011

module alu(a,b,operation,out,zero, lt, ltu, gt, gtu);
    input [31:0] a,b;
    input [3:0] operation;
    output reg [31:0] out;
    output zero, lt, ltu, gt, gtu;
    
    assign zero = (out==0);
    assign lt = $signed(a)<$signed(b);
    assign gt = $signed(a)>$signed(b);
    assign ltu = a<b;
    assign gtu = a>b;
    
    always@(*)begin
        case(operation)
            `AND : out = a & b;
            `OR  : out = a | b;
            `ADD : out = a + b;
            `SUB : out = a - b;
            `SEQ : out = (a==b)? 32'd1:32'd0;
            `SLT : out = ($signed(a)<$signed(b))?32'd1:32'd0;
            `SLTU: out = (a<b)?32'd1:32'd0;
            `XOR : out = a ^ b;
            `NOT : out = ~a ;
            `SLL : out = a << b;
            `SRL : out = a >> b;
            `SLA : out = $signed(a) <<< b;
            `SRA : out = $signed(a) >>> b;
        endcase
    end
endmodule
