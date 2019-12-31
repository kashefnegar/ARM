module ALU(input[3:0] exec_cmd, input[31:0] in1, in2, input c_in, output reg[31:0] out, output reg[3:0] NZCV);

    always@(*) begin
        NZCV[1] = 1'b0;

        case(exec_cmd)
            4'b0001: out = in2; // MOV
            4'b1001: out = ~in2; // MVN
            4'b0010: {NZCV[1], out} = in1 + in2; // ADD
            4'b0011: {NZCV[1], out} = in1 + in2 + c_in; // ADDC
            4'b0100: {NZCV[1], out} = in1 - in2; // SUB
            4'b0101: {NZCV[1], out} = in1 - in2 - c_in; // SUBC
            4'b0110: out = in1 & in2; // AND
            4'b0111: out = in1 | in2; // ORR
            4'b1000: out = in1 ^ in2; // EOR
            default: out = in1;
        endcase

        if((exec_cmd == 4'b0010 || exec_cmd == 4'b0011) && (in1[31] == in2[31]) && (out[31] != in1[31])) // ADD
            NZCV[0] = 1'b1;
        else if((exec_cmd == 4'b0100 || exec_cmd == 4'b0101) && (in1[31] != in2[31]) && (out[31] == in2[31])) // SUB
            NZCV[0] = 1'b1;
        else
            NZCV[0] = 1'b0;
            
        NZCV[2] = (out == 32'b0) ? 1'b1 : 1'b0;
        NZCV[3] = out[31];

    end
endmodule