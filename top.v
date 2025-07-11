`timescale 1ns / 1ps

module top(clk,rst,pc_out,instr_out);
    input clk,rst;
    output [31:0] pc_out;
    output [31:0] instr_out;
    wire [31:0] pc;
    wire [31:0] instruction;
    wire MemRead, MemWrite;
    wire [31:0] addr;
    wire [31:0] write_data, read_data;
    
    processor           prc  (clk, rst, instruction, pc, MemRead, MemWrite, addr, 
                              write_data, read_data);
                              
    data_memory         dmem (clk, addr, MemRead, MemWrite, write_data, read_data);
    
    instruction_memory  imem (pc, instruction);
    
    assign pc_out = pc;
    assign instr_out = instruction;
endmodule
