module RegisterFile (input clk, rst, input[3:0] src1, src2, dest_wb, input [31:0] result_wb,
  input wb_en, output[31:0] reg1, reg2);
  
  reg [31:0] Regfile [15:0];
  assign reg1 = Regfile[src1];
  assign reg2 = Regfile[src2];

  always@(negedge clk, posedge rst)begin
    if(rst) begin
      Regfile[0] <= 32'd0;
      Regfile[1] <= 32'd1;
      Regfile[2] <= 32'd2;
      Regfile[3] <= 32'd3;
      Regfile[4] <= 32'd4;
      Regfile[5] <= 32'd5;
      Regfile[6] <= 32'd6;
      Regfile[7] <= 32'd7;
      Regfile[8] <= 32'd8;
      Regfile[9] <= 32'd9;
      Regfile[10] <= 32'd10;
      Regfile[11] <= 32'd11;
      Regfile[12] <= 32'd12;
      Regfile[13] <= 32'd13;
      Regfile[14] <= 32'd14;
      Regfile[15] <= 32'd15;
    end
    else if (wb_en)
      Regfile[dest_wb] <= result_wb;
  end
endmodule
