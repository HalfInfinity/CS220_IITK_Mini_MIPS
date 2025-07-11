`timescale 1ns / 1ps

module processor(clk, rst, inst, pc, MemRead, MemWrite, addr, write_data, read_data);
    input clk, rst;
    input [31:0] inst;
    input [31:0] read_data;
    
    output [31:0] pc;
    output MemRead, MemWrite;
    output [31:0] addr;
    output [31:0] write_data;
    
    wire [3:0] operation;
    wire RegWrite, RegDst, ALUSrc, MemtoReg, Branch, Jump, Jal, Jr, Signex, Lui;
    wire [2:0] Br_Op;
    wire [2:0] ALU_Op;
    wire [5:0] opcode;
    wire [5:0] funct;
    
    assign opcode = inst[31:26];
    assign funct  = inst[5:0];
    
    datapath    dp      (clk,rst,inst, operation, read_data, RegWrite, RegDst, ALUSrc, 
                         MemtoReg, Branch, Br_Op, Jump, Jal, Jr, Signex, Lui, pc, write_data, addr);
                         
    control     ctrl    (opcode, RegWrite, RegDst, ALUSrc, MemRead, MemWrite, MemtoReg, 
                         Branch, Br_Op, ALU_Op, Jump, Jal, Jr, Signex, Lui);
                         
    alu_control aluctrl (funct, ALU_Op, operation);
    
endmodule
