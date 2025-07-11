`timescale 1ns / 1ps

module instruction_memory(addr,instruction);
    input [31:0] addr;
    output [31:0] instruction;
    
    reg [31:0] mem [1023:0];
    wire en = (addr[31:12] == 20'h00000);
    
    assign instruction = (en) ?  mem[addr[11:2]] : 32'd0;
    
    integer i;
    initial begin
        for(i=0; i<1024; i=i+1)begin
            mem[i] = 32'd0;
        end
    end
    
endmodule
