module MEM_Stage_Reg(input clk, rst, mem_read_in, wb_en_in, input[3:0] dest_in, input[31:0] ALU_result_in, MEM_result_in, 
                    output reg mem_read, wb_en, output reg[3:0] dest, output reg[31:0] ALU_result_out, MEM_result);
                    
    always@(posedge clk, posedge rst) begin
        if(rst) begin
            mem_read <= 1'b0;
            wb_en <= 1'b0;
            dest <= 4'bx;
            ALU_result_out <= 32'bx;
            MEM_result <= 32'bx;
        end
        else begin
            mem_read <= mem_read_in;
            wb_en <= wb_en_in;
            dest <= dest_in;
            ALU_result_out <= ALU_result_in;
            MEM_result <= MEM_result_in;
        end
    end
endmodule
