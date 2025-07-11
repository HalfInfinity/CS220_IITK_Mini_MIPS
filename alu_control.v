`timescale 1ns / 1ps

module alu_control(funct, ALU_Op, operation);

     input [5:0] funct;
     input [2:0] ALU_Op;
     output reg [3:0] operation;
     
     always@(*)begin
         case (ALU_Op)
            3'b000: operation = 4'b0010; //LW/SW/LUI
            3'b001: operation = 4'b0110; //Branch
            3'b011: operation = 4'b0111; //SLTI
            3'b100: operation = 4'b0000; //ANDI
            3'b101: operation = 4'b0001; //ORI
            3'b110: operation = 4'b0011; //XORI
            3'b111: operation = 4'b0101; //SEQ
            3'b010: case(funct)
                        6'b100000: operation = 4'b0010; // ADD
                        6'b100010: operation = 4'b0110; // SUB
                        6'b100001: operation = 4'b0010; //ADDU
                        6'b100011: operation = 4'b0110; //SUBU
                        6'b100100: operation = 4'b0000; // AND
                        6'b100101: operation = 4'b0001; // OR
                        6'b100111: operation = 4'b0100; //NOT
                        6'b100110: operation = 4'b0011; //XOR
                        6'b000000: operation = 4'b1000; //SLL 
                        6'b000001: operation = 4'b1001; //SLA 
                        6'b000010: operation = 4'b1010; //SRL 
                        6'b000011: operation = 4'b1011; //SRA   
                        
                        6'b101010: operation = 4'b0111; // SLT
                        default  : operation = 4'b0000; 
                    endcase
         endcase
     end
endmodule
