`timescale 1ns / 1ps

module register_file(clk, RegWrite, read_reg1, read_reg2, write_reg, read_data1, read_data2, write_data);
    input clk, RegWrite;
    input [4:0] read_reg1, read_reg2, write_reg;
    input [31:0] write_data;
    output [31:0] read_data1, read_data2;
    
    reg [31:0] registers [31:0];
    
    assign read_data1 = registers[read_reg1];
    assign read_data2 = registers[read_reg2];
    
    always@(posedge clk)begin
        if(RegWrite)begin
            registers[write_reg] <= write_data;
        end
    end
   
    integer i;
    initial begin
        for(i=0; i<32; i=i+1)begin
            registers[i] = 32'd0;
        end
    end
endmodule
