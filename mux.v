`timescale 1ns / 1ps

module mux #(parameter W=32)(a,b,sel,out);
    input [W-1:0] a,b;
    input sel;
    output [W-1:0] out;
    
    assign out = sel==0? a:b;
endmodule
