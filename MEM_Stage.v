module MEM_Stage(input clk, mem_read, mem_write, input [31:0] address, data, output [31:0] result);

    wire [7:0] startAddress = {address[7:2], 2'b0};
    reg [7:0] memory [0:255];

    assign result = {memory[startAddress + 3], memory[startAddress + 2], memory[startAddress + 1], memory[startAddress]};

    always @(posedge clk) begin
        if(mem_write) begin
            memory[startAddress + 3] <= data[31:24];
            memory[startAddress + 2] <= data[23:16];
            memory[startAddress + 1] <= data[15:8];
            memory[startAddress] <= data[7:0];
        end
    end
endmodule