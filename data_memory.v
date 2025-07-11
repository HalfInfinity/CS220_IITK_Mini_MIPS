`timescale 1ns / 1ps

module data_memory(clk,addr,MemRead,MemWrite,write_data,read_data);
    input [31:0] addr;
    input clk, MemRead, MemWrite;
    input [31:0] write_data;
    output reg [31:0] read_data;
    
    reg [31:0] mem [1023:0];
    wire en = (addr[31:12]==20'h10010);
    
    always@(*)begin
        if(MemRead)begin
            read_data = (en) ? mem[addr[11:2]] : 32'd0;
        end
    end
    
    always@(posedge clk)begin
        if(MemWrite)begin
            mem[addr[11:2]]<= write_data;
        end
    end
    
    integer i;
    initial begin
        for(i=0; i<1024; i=i+1)begin
            mem[i] = 32'b0;
        end       
    end
    
endmodule
