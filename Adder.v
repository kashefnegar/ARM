module Adder(input[31:0] PC,output[31:0] PC_out);
  assign PC_out = 32'd4 + PC;
endmodule

