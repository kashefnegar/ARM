module Mux#(parameter w = 32)(input[w-1:0] in1, in2, input sel, output[w-1:0] out);
    assign out = sel ? in1 : in2;
endmodule