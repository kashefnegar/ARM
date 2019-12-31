module Control_Unit(input[1:0] mode, input[3:0] opcode, input s, output reg mem_read, mem_write, wb_en, b, output reg [3:0] exe_cmd);

    always@(*) begin
        {mem_read, mem_write, b, wb_en} = 4'b0001;

        casez({mode, opcode, s})
            7'b01_0100_1: begin exe_cmd = 4'b0010; mem_read = 1'b1; end //LDR
            7'b01_0100_0: begin exe_cmd = 4'b0010; mem_write = 1'b1; wb_en= 1'b0; end //STR
            7'b00_1010_1: begin exe_cmd = 4'b0100; wb_en = 1'b0; end //compare
            7'b00_1000_1: begin exe_cmd = 4'b0110; wb_en = 1'b0; end //test
            7'b00_1101_?: begin exe_cmd = 4'b0001; end //move
            7'b00_1111_?: begin exe_cmd = 4'b1001; end //move not
            7'b00_0100_?: begin exe_cmd = 4'b0010; end //add
            7'b00_0101_?: begin exe_cmd = 4'b0011; end //add with carry
            7'b00_0010_?: begin exe_cmd = 4'b0100; end //sub
            7'b00_0110_?: begin exe_cmd = 4'b0101; end //sub with carry
            7'b00_0000_?: begin exe_cmd = 4'b0110; end //and
            7'b00_1100_?: begin exe_cmd = 4'b0111; end //or
            7'b00_0001_?: begin exe_cmd = 4'b1000; end //exclusive or
            7'b10_????_?: begin exe_cmd = 4'bx; b = 1'b1; wb_en= 1'b0; end //branch
            default: begin exe_cmd = 4'bx; wb_en = 1'b0; end
        endcase
    end
endmodule