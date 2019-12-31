module ID_Stage_Reg(
    input clk, rst, flush, b_in, s_in, wb_en_in, mem_read_in, mem_write_in, imm_in,
    input [3:0] exe_cmd_in, dest_in, src1_in, src2_in,
    input [31:0] PC_in, valRn_in, valRm_in,
    input [11:0] shift_operand_in, 
    input [23:0] signed_imm_in,
    output reg [31:0] PC, valRn, valRm,
    output reg b, s, wb_en, mem_read, mem_write,imm,
    output reg [3:0] exe_cmd, dest, src1, src2,
    output reg [11:0] shift_operand,
    output reg [23:0] signed_imm);

    always@(posedge clk, posedge rst) begin
        if(rst) begin
            PC <= 32'bx;
            {b, s, wb_en, mem_read, mem_write, imm} <= 6'b0;
            exe_cmd <= 4'bx;
            valRn <= 32'bx;
            valRm <= 32'bx;
            dest <= 4'bx;
            src1 <= 4'bx;
            src2 <= 4'bx;
            shift_operand <= 12'bx;
            signed_imm <= 24'bx;
        end
        else if(flush) begin
            PC <= 32'bx;
            {b, s, wb_en, mem_read, mem_write, imm} <= 6'b0;
            exe_cmd <= 4'bx;
            valRn <= 32'bx;
            valRm <= 32'bx;
            dest <= 4'bx;
            src1 <= 4'bx;
            src2 <= 4'bx;
            shift_operand <= 12'bx;
            signed_imm <= 24'bx;
        end
        else begin
            PC <= PC_in;
            {b,s, wb_en, mem_read, mem_write, imm} <= {b_in,s_in, wb_en_in, mem_read_in, mem_write_in, imm_in};
            exe_cmd <= exe_cmd_in;
            valRn <= valRn_in;
            valRm <= valRm_in;
            dest <= dest_in;
            src1 <= src1_in;
            src2 <= src2_in;
            shift_operand <= shift_operand_in;
            signed_imm <= signed_imm_in;
        end
    end
endmodule
