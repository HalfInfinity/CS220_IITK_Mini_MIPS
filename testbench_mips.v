`timescale 1ns / 1ps

module testbench_mips();
    reg clk=0, rst=1;
    wire [31:0] pc_out, instr_out;
    
    always #5 clk = ~clk;
    
    initial begin
        #15 rst = 0;
    end
    
    integer i;
    
    initial begin
        //Instruction memory initialised from imemory.mem
        $readmemb("imemory.mem",uut.imem.mem);
        
        //Initialse the data memory here...
        uut.dmem.mem[0] = 32'd10; // this is n, the size of array
        uut.dmem.mem[1] = 5;      //array begins here
        uut.dmem.mem[2] = 4;
        uut.dmem.mem[3] = 7;
        uut.dmem.mem[4] = 2;
        uut.dmem.mem[5] = 9;
        uut.dmem.mem[6] = 6;
        uut.dmem.mem[7] = 1;
        uut.dmem.mem[8] = 8;
        uut.dmem.mem[9] = 3;
        uut.dmem.mem[10] = 10;
    end
    
    initial begin
        $display("=== Data Memory Before Sorting ===");
        for (i = 1; i <= 10; i = i + 1)begin
            $display("mem[%0d] = %0d", i, uut.dmem.mem[i]);
        end
        
        #2500;
        $display("=== Data Memory After Sorting ===");
        for (i = 1; i <= 10; i = i + 1)begin
            $display("mem[%0d] = %0d", i, uut.dmem.mem[i]);
        end
    end
    
    top uut(clk,rst,pc_out, instr_out);
endmodule
