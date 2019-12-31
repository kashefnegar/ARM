module IF_Stage(input clk, rst, freeze, branchTaken, input[31:0] branchAddress, output[31:0] PC, instruction);

    wire[31:0] PC_Adder_out, PC_in, PC_out;

    assign PC = PC_Adder_out;

    Mux#(32)mux(branchAddress, PC_Adder_out, branchTaken, PC_in);
    PC_Reg pcReg(PC_in, freeze, rst, clk, PC_out);
    Adder add(PC_out, PC_Adder_out);
    Instruction_Memory instMem(clk, rst, PC_out, instruction);
endmodule