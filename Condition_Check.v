module Condition_Check(input[3:0] cond, NZCV, output reg cond_out);
  always@(*) begin
    case(cond)
      4'b0000: cond_out = NZCV[2];
      4'b0001: cond_out = ~NZCV[2];
      4'b0010: cond_out = NZCV[1];
      4'b0011: cond_out = ~NZCV[1];
      4'b0100: cond_out = NZCV[3];
      4'b0101: cond_out = ~NZCV[3];
      4'b0110: cond_out = NZCV[0];
      4'b0111: cond_out = ~NZCV[0];
      4'b1000: cond_out = NZCV[1] & ~NZCV[2]; 
      4'b1001: cond_out = ~NZCV[1] | NZCV[2];
      4'b1010: cond_out = (NZCV[3] == NZCV[0]);
      4'b1011: cond_out = (NZCV[3] != NZCV[0]);
      4'b1100: cond_out = ~NZCV[2] & (NZCV[3] == NZCV[0]); 
      4'b1101: cond_out = NZCV[2] | (NZCV[3] != NZCV[0]);
      4'b1110: cond_out = 1;
      default: cond_out = 1;      
    endcase
  end
endmodule