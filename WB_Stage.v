module WB_Stage(input[31:0] MEM_result, ALU_result, input mem_read, output[31:0] out);
  assign out = mem_read ? MEM_result : ALU_result;
endmodule