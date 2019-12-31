module EXE_Stage_Reg(input clk, rst, wb_en_in, mem_read_in, mem_write_in, 
                    input[31:0] ALU_result_in, valRm_in,
                    input[3:0] dest_in, output reg wb_en, mem_read, mem_write, 
                    output reg[31:0] ALU_result, valRm, 
                    output reg[3:0] dest);

    always@(posedge clk, posedge rst) begin
        if(rst) begin
            wb_en <= 1'b0;
            mem_read <= 1'b0;
            mem_write <= 1'b0;
            ALU_result <= 32'bx;
            valRm <= 32'bx;
            dest <= 4'bx;
        end
        else begin
            wb_en <= wb_en_in;
            mem_read <= mem_read_in;
            mem_write <= mem_write_in;
            ALU_result <= ALU_result_in;
            valRm <= valRm_in;
            dest <= dest_in;
        end
    end
endmodule
