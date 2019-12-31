module Main(input clk , rst, forward_en);

    wire[31:0] PC_IF_Stage, instruction_IF_Stage, PC_IF_Reg, instruction_IF_Reg, 
                valRn_ID_Stage, valRm_ID_Stage, valRn_ID_Reg, valRm_ID_Reg, PC_ID_Reg, 
                PC_EXE_Stage, branchAddress_EXE_Stage, ALU_result_EXE_Stage, ALU_result_EXE_Reg, valRm_EXE_Reg, 
                MEM_result_MEM_Stage, ALU_result_MEM_Reg, MEM_result_MEM_Reg, 
                wb_result_WB_Stage;

    wire[23:0] signed_imm_ID_Stage, signed_imm_ID_Reg;
    wire[11:0] shift_operand_ID_Stage, shift_operand_ID_Reg;
    wire[3:0] src1_ID_Stage, src2_ID_Stage, exe_cmd_ID_Stage, dest_ID_Stage, exe_cmd_ID_Reg, dest_ID_Reg, src1_ID_Reg, src2_ID_Reg, dest_EXE_Reg, dest_MEM_Reg, NZCV;
    wire [1:0] forward1, forward2;
    wire b_ID_Stage, s_ID_Stage, wb_en_ID_Stage, mem_read_ID_Stage, mem_write_ID_Stage, imm_ID_Stage, hazard_ID_Stage,
        b_ID_Reg, s_ID_Reg, wb_en_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, imm_ID_Reg, wb_en_EXE_Reg, mem_read_EXE_Reg, mem_write_EXE_Reg, mem_read_MEM_Reg, wb_en_MEM_Reg;


    IF_Stage ifStage(clk, rst, hazard_ID_Stage, b_ID_Reg, branchAddress_EXE_Stage, PC_IF_Stage, instruction_IF_Stage);

    IF_Stage_Reg ifReg(clk, rst, hazard_ID_Stage, b_ID_Reg, PC_IF_Stage, instruction_IF_Stage, PC_IF_Reg, instruction_IF_Reg);

    ID_Stage idStage(clk, rst, wb_en_ID_Reg, wb_en_EXE_Reg, wb_en_MEM_Reg, mem_read_ID_Reg, forward_en, dest_ID_Reg, dest_EXE_Reg, dest_MEM_Reg, NZCV, instruction_IF_Reg, wb_result_WB_Stage, 
                    valRn_ID_Stage, valRm_ID_Stage, b_ID_Stage, s_ID_Stage, wb_en_ID_Stage, mem_read_ID_Stage, mem_write_ID_Stage, 
                    imm_ID_Stage, hazard_ID_Stage, exe_cmd_ID_Stage, dest_ID_Stage, src1_ID_Stage, src2_ID_Stage, shift_operand_ID_Stage, signed_imm_ID_Stage);

    ID_Stage_Reg idStageReg(clk, rst, b_ID_Reg, b_ID_Stage, s_ID_Stage, wb_en_ID_Stage, mem_read_ID_Stage, mem_write_ID_Stage, imm_ID_Stage, exe_cmd_ID_Stage, dest_ID_Stage, src1_ID_Stage, src2_ID_Stage,
                            PC_IF_Reg, valRn_ID_Stage, valRm_ID_Stage,shift_operand_ID_Stage, signed_imm_ID_Stage,PC_ID_Reg, valRn_ID_Reg, valRm_ID_Reg, 
                            b_ID_Reg, s_ID_Reg, wb_en_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, imm_ID_Reg, 
                            exe_cmd_ID_Reg, dest_ID_Reg, src1_ID_Reg, src2_ID_Reg, shift_operand_ID_Reg, signed_imm_ID_Reg);

    EXE_Stage exeStage(clk, rst, forward1, forward2, exe_cmd_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, imm_ID_Reg, s_ID_Reg, PC_ID_Reg, valRn_ID_Reg, valRm_ID_Reg, ALU_result_EXE_Reg, wb_result_WB_Stage,
                        shift_operand_ID_Reg, signed_imm_ID_Reg, 
                        ALU_result_EXE_Stage, branchAddress_EXE_Stage, NZCV);

    EXE_Stage_Reg exeStageReg(clk, rst, wb_en_ID_Reg, mem_read_ID_Reg, mem_write_ID_Reg, ALU_result_EXE_Stage, valRm_ID_Reg, dest_ID_Reg, 
                                wb_en_EXE_Reg, mem_read_EXE_Reg, mem_write_EXE_Reg, ALU_result_EXE_Reg, valRm_EXE_Reg, dest_EXE_Reg);

    MEM_Stage memStage(clk, mem_read_EXE_Reg, mem_write_EXE_Reg, ALU_result_EXE_Reg, valRm_EXE_Reg, MEM_result_MEM_Stage);

    MEM_Stage_Reg memStageReg(clk, rst, mem_read_EXE_Reg, wb_en_EXE_Reg, dest_EXE_Reg, ALU_result_EXE_Reg, MEM_result_MEM_Stage, 
                                mem_read_MEM_Reg, wb_en_MEM_Reg, dest_MEM_Reg, ALU_result_MEM_Reg, MEM_result_MEM_Reg);

    WB_Stage wbStage(MEM_result_MEM_Reg, ALU_result_MEM_Reg, mem_read_MEM_Reg, wb_result_WB_Stage);

    Forwarding_Unit forwardingUnit(wb_en_EXE_Reg, wb_en_MEM_Reg, forward_en, src1_ID_Reg, src2_ID_Reg, dest_EXE_Reg, dest_MEM_Reg, forward1, forward2);
endmodule