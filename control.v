`timescale 1ns / 1ps

module control (opcode, RegWrite, RegDst, ALUSrc, MemRead, MemWrite, MemtoReg, 
                Branch, Br_Op, ALU_Op, Jump, Jal, Jr, Signex, Lui);
                
    input [5:0] opcode;
    output RegWrite, RegDst, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, Jump, Jal, Jr, Signex, Lui;
    output [2:0] Br_Op;
    output [2:0] ALU_Op;
    
    reg [17:0] controls;
    
    assign {RegWrite, RegDst, ALUSrc, Branch, Br_Op,
            MemRead, MemWrite, MemtoReg, Jump, Jal, Jr, Signex, Lui, ALU_Op} = controls;
            
    always@(*)begin
        case(opcode)
            6'b000000: controls = 18'b110000000000010010; //Rtype
            
            6'b100011: controls = 18'b101000010100010000; //LW
            6'b101011: controls = 18'b001000001000010000; //SW
            6'b001111: controls = 18'b101000000000001000; //LUI
            
            6'b001000: controls = 18'b101000000000010000; //ADDI
            6'b001001: controls = 18'b101000000000010000; //ADDIU
            6'b001100: controls = 18'b101000000000000100; //ANDI
            6'b001101: controls = 18'b101000000000000101; //ORI
            6'b001110: controls = 18'b101000000000000110; //XORI
            6'b001010: controls = 18'b101000000000010011; //SLTI
            6'b001011: controls = 18'b101000000000010111; //SEQ
            
            6'b000100: controls = 18'b000100000000010001; //BEQ
            6'b000101: controls = 18'b000100100000010001; //BNE
            6'b000110: controls = 18'b000101000000010001; //BLE
            6'b000111: controls = 18'b000101100000010001; //BLEQ
            6'b011100: controls = 18'b000110000000010001; //BGT
            6'b011101: controls = 18'b000110100000010001; //BGTE
            6'b011110: controls = 18'b000111000000010001; //BLEU
            6'b011111: controls = 18'b000111100000010001; //BGTU
            
            6'b000010: controls = 18'b000000000010000000; //J
            6'b000011: controls = 18'b100000000011000000; //JAL
            6'b111111: controls = 18'b000000000010100000; //JR
        endcase
    end
    
endmodule
