`timescale 1ns / 1ps

module datapath(clk,rst,inst, operation, read_data, RegWrite, RegDst, ALUSrc, 
                MemtoReg, Branch, Br_Op, Jump, Jal, Jr, Signex, Lui, pc, write_data, addr);
                
    input clk, rst;
    input [31:0] inst;
    input [3:0] operation;
    input [31:0] read_data;
    input RegWrite, RegDst, ALUSrc, MemtoReg, Branch, Jump, Jal, Jr, Signex, Lui;
    input [2:0] Br_Op;
    
    output [31:0] pc;
    output [31:0] write_data;
    output [31:0] addr;
    
    wire [4:0] rs,rt,rd, shamt;
    wire [15:0] imm;
    wire [31:0] signex_imm;
    wire [31:0] ex_imm;
    wire [31:0] alu_imm;
    wire [4:0] read_reg1, read_reg2, write_reg;
    wire [31:0] read_data1, read_data2, write_reg_data;
    wire Zero, lt, ltu, gt, gtu;
    wire [31:0] ALU_Out;
    wire [31:0] operand1, operand2;
    wire [31:0] pc_next;
    wire [25:0] jump_offset;
    
    //Instruction Field Decoding
    assign rs = inst[25:21];
    assign rt = inst[20:16];
    assign rd = inst[15:11];
    assign shamt = inst[10:6];
    assign imm = inst[15:0];
    
    //Register file connections
    assign read_reg1      = rs;
    assign read_reg2      = rt;
    
    assign write_reg      = (Jal) ? 5'd31 :
                            (RegDst) ? rd : rt;
                       
    assign write_reg_data = (Jal) ? pc+4 :
                            (MemtoReg) ? read_data : ALU_Out;
                            
    //Sign extenion of immediate
    sign_ext se (imm, signex_imm);
    
    //Zero extension of immediate
    zero_ext ze (imm, ex_imm);
    
    //ALU connections
    assign operand1 = read_data1;
    assign alu_imm = (Lui) ? {imm, 16'b0} : (Signex) ? signex_imm : ex_imm; 
    assign operand2 = (ALUSrc) ? alu_imm : read_data2;
    
    //Data Memory connections
    assign write_data = read_data2;
    assign addr = ALU_Out;
    
    //jump offset
    assign jump_offset = inst[25:0];
    
//    always @(inst) begin
//        if (Lui) begin
//            $display("\n=== [LUI DEBUG] Time: %0t ===", $time);
//            $display("inst           = %h", inst);
//            $display("rs             = %h", rs);
//            $display("rt             = %h", rt);
//            $display("rd             = %h", rd);
//            $display("imm            = %h", imm);
//            $display("alu_imm        = %h", alu_imm);
//            $display("write_reg_data = %h", write_reg_data);
//        end
//    end

    pc            PC        (clk,rst,pc_next,pc);
    update_pc     UpdatePC  (pc,jump_offset, signex_imm, read_data1, Branch, Br_Op, Zero, lt, ltu, gt, gtu, 
                             Jump, Jr, pc_next);
    register_file RegFile   (clk, RegWrite, read_reg1, read_reg2, write_reg, read_data1, 
                             read_data2, write_reg_data);
    alu           ALU       (operand1, operand2, operation, ALU_Out, Zero, lt, ltu, gt, gtu);
endmodule
