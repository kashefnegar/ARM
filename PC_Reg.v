module PC_Reg(input [31:0] in, input freeze, rst, clk, output reg [31:0] out);

    always@(posedge clk, posedge rst)begin
        if(rst)
            out <= 32'b0;
        else if(!freeze)
            out <= in;
    end
endmodule



