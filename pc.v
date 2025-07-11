`timescale 1ns / 1ps

module pc(clk, rst, pc_next, pc);
    input clk,rst;
    input [31:0] pc_next;
    output reg [31:0] pc;
    
    always@(posedge clk) begin
        if(rst)begin
            pc <= 32'd0;
        end
        else pc <= pc_next;
    end
endmodule
