module ID_Stage(input clk, rst, exe_wb_en, mem_wb_en, wb_en_in, exe_mem_read, forward_en, input [3:0] exe_dest, mem_dest, wb_dest, NZCV,
            input[31:0] instruction, result_wb,
            output[31:0] valRn, valR2, 
            output b, s, wb_en, mem_read, mem_write, imm, hazard,
            output[3:0] exe_cmd, dest, src1, src2, output[11:0] shift_operand, output[23:0] signed_imm);

    wire cond_out, mem_read_inter, mem_write_inter, wb_en_inter, b_inter, nop, two_src, zero_src;

    assign src1 = instruction[19:16];
    assign nop = (instruction[28:0] == 29'b0) ? 1'b1 : 1'b0;
    assign imm = instruction[25];
    assign dest = instruction[15:12];
    assign shift_operand = instruction[11:0];
    assign signed_imm = instruction[23:0];
    assign two_src = ~instruction[25] | mem_write_inter;
    assign zero_src = ({instruction[27:26], instruction[24:23], instruction[21]} == 5'b00111) ? 1'b1 : 1'b0;
    assign {b, wb_en, mem_read, mem_write, s} = (~cond_out | hazard | nop) ? 5'b0 : {b_inter, wb_en_inter, mem_read_inter, mem_write_inter, instruction[20]};

    Mux#(4) mux(instruction[15:12], instruction[3:0], mem_write_inter, src2);

    RegisterFile regFile(clk, rst, src1, src2, wb_dest, result_wb, wb_en_in, valRn, valR2);

    Condition_Check condCheck(instruction[31:28], NZCV, cond_out);

    Control_Unit contUnit(instruction[27:26], instruction[24:21], instruction[20], mem_read_inter, mem_write_inter, wb_en_inter, b_inter, exe_cmd);

    Hazard_Detection_Unit hazardUnit(exe_wb_en, mem_wb_en, zero_src, two_src, exe_mem_read, forward_en, src1, src2, exe_dest, mem_dest, hazard);
endmodule
