module EXE_Stage(input clk, rst, input [1:0] forward1, forward2, input[3:0] exec_cmd, input mem_read, mem_write, imm, s, 
            input[31:0] PC_in, valRn, valRm, exe_result, mem_result, input [11:0] shift_operand, input[23:0] signed_imm,
            output[31:0] ALU_result, branchAddress, output reg[3:0] NZCV);

    wire[3:0] ALU_status;
    wire[31:0] val2, signed_imm32;
    reg [31:0] src1, src2;

    assign signed_imm32 = {{8{signed_imm[23]}}, signed_imm};
    assign branchAddress = PC_in + (signed_imm32 << 2);

    Val2Generator val2generator(src2, shift_operand, imm, mem_read | mem_write, val2);
    ALU alu(exec_cmd, src1, val2, NZCV[1], ALU_result, ALU_status);

    always @(*) begin
        case (forward1)
            2'b01: src1 = mem_result; 
            2'b10: src1 = exe_result; 
            default: src1 = valRn; 
        endcase
        case (forward2)
            2'b01: src2 = mem_result; 
            2'b10: src2 = exe_result; 
            default: src2 = valRm; 
        endcase
    end

    always@(negedge clk, posedge rst) begin
        if(rst)
            NZCV <= 4'b0;
        else if(s)
            NZCV <= ALU_status;
        else
            NZCV <= NZCV;
    end

endmodule
