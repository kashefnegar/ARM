module IF_Stage_Reg(input clk, rst, freeze, flush, input[31:0] PC_in, instruction_in, output reg[31:0] PC, instruction);
    always@(posedge clk, posedge rst) begin
        if(rst) begin
            PC <= 32'bx;
            instruction <= 32'b11100000000000000000000000000000; // NOP
        end
        else if(flush) begin
            PC <= 32'bx;
            instruction <= 32'b11100000000000000000000000000000; // NOP
        end
        else if(!freeze) begin
            PC <= PC_in;
            instruction <= instruction_in;
        end
    end
endmodule