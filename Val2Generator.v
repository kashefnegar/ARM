module Val2Generator(input[31:0] in, input [11:0] shift_operand, input imm, mem, output reg[31:0] out);

    integer index;
    reg[31:0] temp32;
    reg temp1;
    wire[4:0] shift = shift_operand[11:8] << 1;

    always@(*) begin
        temp32 = 0;
        temp1 = 1'b0;
        if(mem)
            out = {20'b0, shift_operand};
        else if(imm == 1'b1) begin
            out = {24'b0, shift_operand[7:0]};
            for (index = 0; index < shift; index = index + 1) begin
                temp1 = out[0];
                temp32 = out >> 1;
                temp32 = {temp1, temp32[30:0]};
                out = temp32[31:0];
            end
        end
        else if(imm == 1'b0 & shift_operand[4] == 'b0) begin
            case(shift_operand[6:5])
                2'b00: out = in << shift_operand[11:7]; // LSL
                2'b01: out = in >> shift_operand[11:7]; // LSR
                2'b10: out = in >>> shift_operand[11:7]; // ASR
                2'b11: begin out = in; // ROR
                    for (index = 0; index < shift_operand[11:7]; index = index + 1) begin
                        temp1 = out[0];
                        temp32 = out >> 1;
                        temp32 = {temp1, temp32[30:0]};
                        out = temp32[31:0];
                    end
                end
                default: out = in;
            endcase
        end
        else begin
            out = in;
        end
    end
endmodule