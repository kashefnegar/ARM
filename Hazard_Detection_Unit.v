module Hazard_Detection_Unit(input exe_wb_en, mem_wb_en, zero_src, two_src, exe_mem_read, forward_en, input [3:0] src1, src2, exe_dest, mem_dest, output reg hazard);

    always @(*) begin
        hazard = 1'b0;

        if(src1 == exe_dest && exe_wb_en && ~zero_src)
            hazard = ~forward_en | exe_mem_read;
        if(src1 == mem_dest && mem_wb_en && ~zero_src)
            hazard = ~forward_en;
        if(src2 == exe_dest && exe_wb_en && two_src && ~zero_src)
            hazard = ~forward_en | exe_mem_read;
        if(src2 == mem_dest && mem_wb_en && two_src && ~zero_src)
            hazard = ~forward_en;
    end
endmodule