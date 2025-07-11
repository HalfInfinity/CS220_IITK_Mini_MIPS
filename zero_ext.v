`timescale 1ns / 1ps

module zero_ext(a,y);
    input [15:0] a;
    output [31:0] y;
    
    assign y = {{16{1'b0}},a};
endmodule
