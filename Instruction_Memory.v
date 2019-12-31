
module Instruction_Memory (input clk, rst, input [31:0] PC, output [31:0] instruction);

    reg [7:0] instruction_mem [200:0];
    assign instruction = {instruction_mem[PC + 3], instruction_mem[PC + 2], instruction_mem[PC + 1], instruction_mem[PC]};

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            {instruction_mem[3], instruction_mem[2], instruction_mem[1], instruction_mem[0]} <= 32'b1110_00_1_1101_0_0000_0000_000000010100; //MOV		R0 ,#20 		    //R0 = 20
            {instruction_mem[7], instruction_mem[6], instruction_mem[5], instruction_mem[4]} <= 32'b1110_00_1_1101_0_0000_0001_101000000001; //MOV		R1 ,#4096		    //R1 = 4096
            {instruction_mem[11], instruction_mem[10], instruction_mem[9], instruction_mem[8]} <= 32'b1110_00_1_1101_0_0000_0010_000100000011; //MOV		R2 ,#0xC0000000	    //R2 = -1073741824
            {instruction_mem[15], instruction_mem[14], instruction_mem[13], instruction_mem[12]} <= 32'b1110_00_0_0100_1_0010_0011_000000000010; //ADDS		R3 ,R2,R2		    //R3 = -2147483648 and change status
            {instruction_mem[19], instruction_mem[18], instruction_mem[17], instruction_mem[16]} <= 32'b1110_00_0_0101_0_0000_0100_000000000000; //ADC		R4 ,R0,R0		    //R4 = 41
            {instruction_mem[23], instruction_mem[22], instruction_mem[21], instruction_mem[20]} <= 32'b1110_00_0_0010_0_0100_0101_000100000100; //SUB		R5 ,R4,R4,LSL #2	//R5 = -123
            {instruction_mem[27], instruction_mem[26], instruction_mem[25], instruction_mem[24]} <= 32'b1110_00_0_0110_0_0000_0110_000010100000; //SBC		R6 ,R0,R0,LSR #1	//R6 = 9
            {instruction_mem[31], instruction_mem[30], instruction_mem[29], instruction_mem[28]} <= 32'b1110_00_0_1100_0_0101_0111_000101000010; //ORR		R7 ,R5,R2,ASR #2	//R7 = -123
            {instruction_mem[35], instruction_mem[34], instruction_mem[33], instruction_mem[32]} <= 32'b1110_00_0_0000_0_0111_1000_000000000011; //AND		R8 ,R7,R3		    //R8 = -2147483648
            {instruction_mem[39], instruction_mem[38], instruction_mem[37], instruction_mem[36]} <= 32'b1110_00_0_1111_0_0000_1001_000000000110; //MVN		R9 ,R6			    //R9 = -10
            {instruction_mem[43], instruction_mem[42], instruction_mem[41], instruction_mem[40]} <= 32'b1110_00_0_0001_0_0100_1010_000000000101; //EOR		R10,R4,R5		    //R10 = -84
            {instruction_mem[47], instruction_mem[46], instruction_mem[45], instruction_mem[44]} <= 32'b1110_00_0_1010_1_1000_0000_000000000110; //CMP		R8 ,R6			    //
            {instruction_mem[51], instruction_mem[50], instruction_mem[49], instruction_mem[48]} <= 32'b0001_00_0_0100_0_0001_0001_000000000001; //ADDNE    R1 ,R1,R1	        //R1 = 8192
            {instruction_mem[55], instruction_mem[54], instruction_mem[53], instruction_mem[52]} <= 32'b1110_00_0_1000_1_1001_0000_000000001000; //TST		R9 ,R8			    //
            {instruction_mem[59], instruction_mem[58], instruction_mem[57], instruction_mem[56]} <= 32'b0000_00_0_0100_0_0010_0010_000000000010; //ADDEQ	R2 ,R2,R2           //not change
            {instruction_mem[63], instruction_mem[62], instruction_mem[61], instruction_mem[60]} <= 32'b1110_00_1_1101_0_0000_0000_101100000001; //MOV		R0 ,#1024		    //R0 = 1024
            {instruction_mem[67], instruction_mem[66], instruction_mem[65], instruction_mem[64]} <= 32'b1110_01_0_0100_0_0000_0001_000000000000; //STR		R1 ,[R0],#0		    //MEM[1024] = 8192
            {instruction_mem[71], instruction_mem[70], instruction_mem[69], instruction_mem[68]} <= 32'b1110_01_0_0100_1_0000_1011_000000000000; //LDR		R11,[R0],#0		    //R11 = 8192
            {instruction_mem[75], instruction_mem[74], instruction_mem[73], instruction_mem[72]} <= 32'b1110_01_0_0100_0_0000_0010_000000000100; //STR		R2 ,[R0],#4		    //MEM[1028] = -1073741824
            {instruction_mem[79], instruction_mem[78], instruction_mem[77], instruction_mem[76]} <= 32'b1110_01_0_0100_0_0000_0011_000000001000; //STR		R3 ,[R0],#8		    //MEM[1032] = -2147483648
            {instruction_mem[83], instruction_mem[82], instruction_mem[81], instruction_mem[80]} <= 32'b1110_01_0_0100_0_0000_0100_000000001101; //STR		R4 ,[R0],#13	    //MEM[1036] = 41
            {instruction_mem[87], instruction_mem[86], instruction_mem[85], instruction_mem[84]} <= 32'b1110_01_0_0100_0_0000_0101_000000010000; //STR		R5 ,[R0],#16	    //MEM[1040] = -123
            {instruction_mem[91], instruction_mem[90], instruction_mem[89], instruction_mem[88]} <= 32'b1110_01_0_0100_0_0000_0110_000000010100; //STR		R6 ,[R0],#20	    //MEM[1044] = 9
            {instruction_mem[95], instruction_mem[94], instruction_mem[93], instruction_mem[92]} <= 32'b1110_01_0_0100_1_0000_1010_000000000100; //LDR		R10,[R0],#4		    //R10 = -1073741824
            {instruction_mem[99], instruction_mem[98], instruction_mem[97], instruction_mem[96]} <= 32'b1110_01_0_0100_0_0000_0111_000000011000; //STR		R7 ,[R0],#24	    //MEM[1048] = -123
            {instruction_mem[103], instruction_mem[102], instruction_mem[101], instruction_mem[100]} <= 32'b1110_00_1_1101_0_0000_0001_000000000100; //MOV		R1 ,#4			    //R1 = 4
            {instruction_mem[107], instruction_mem[106], instruction_mem[105], instruction_mem[104]} <= 32'b1110_00_1_1101_0_0000_0010_000000000000; //MOV		R2 ,#0			    //R2 = 0
            {instruction_mem[111], instruction_mem[110], instruction_mem[109], instruction_mem[108]} <= 32'b1110_00_1_1101_0_0000_0011_000000000000; //MOV		R3 ,#0			    //R3 = 0
            {instruction_mem[115], instruction_mem[114], instruction_mem[113], instruction_mem[112]} <= 32'b1110_00_0_0100_0_0000_0100_000100000011; //ADD		R4 ,R0,R3,LSL #2	//R4 = 1024 + 4 * R3
            {instruction_mem[119], instruction_mem[118], instruction_mem[117], instruction_mem[116]} <= 32'b1110_01_0_0100_1_0100_0101_000000000000; //LDR		R5 ,[R4],#0         //R5 = MEM[R4]
            {instruction_mem[123], instruction_mem[122], instruction_mem[121], instruction_mem[120]} <= 32'b1110_01_0_0100_1_0100_0110_000000000100; //LDR		R6 ,[R4],#4         //R6 = MEM[R4 + 4]
            {instruction_mem[127], instruction_mem[126], instruction_mem[125], instruction_mem[124]} <= 32'b1110_00_0_1010_1_0101_0000_000000000110; //CMP		R5 ,R6              //
            {instruction_mem[131], instruction_mem[130], instruction_mem[129], instruction_mem[128]} <= 32'b1100_01_0_0100_0_0100_0110_000000000000; //STRGT	R6 ,[R4],#0         //MEM[R4] = R6
            {instruction_mem[135], instruction_mem[134], instruction_mem[133], instruction_mem[132]} <= 32'b1100_01_0_0100_0_0100_0101_000000000100; //STRGT	R5 ,[R4],#4         //MEM[R4 + 4] = R5
            {instruction_mem[139], instruction_mem[138], instruction_mem[137], instruction_mem[136]} <= 32'b1110_00_1_0100_0_0011_0011_000000000001; //ADD		R3 ,R3,#1           //R3 = R3 + 1
            {instruction_mem[143], instruction_mem[142], instruction_mem[141], instruction_mem[140]} <= 32'b1110_00_1_1010_1_0011_0000_000000000011; //CMP		R3 ,#3              //
            {instruction_mem[147], instruction_mem[146], instruction_mem[145], instruction_mem[144]} <= 32'b1011_10_1_0_111111111111111111110111   ; //BLT		#-9                 //Goto :  29             
            {instruction_mem[151], instruction_mem[150], instruction_mem[149], instruction_mem[148]} <= 32'b1110_00_1_0100_0_0010_0010_000000000001; //ADD		R2 ,R2,#1           //R2 = 1
            {instruction_mem[155], instruction_mem[154], instruction_mem[153], instruction_mem[152]} <= 32'b1110_00_0_1010_1_0010_0000_000000000001; //CMP		R2 ,R1              //
            {instruction_mem[159], instruction_mem[158], instruction_mem[157], instruction_mem[156]} <= 32'b1011_10_1_0_111111111111111111110011   ; //BLT		#-13                //Goto : 28
            {instruction_mem[163], instruction_mem[162], instruction_mem[161], instruction_mem[160]} <= 32'b1110_01_0_0100_1_0000_0001_000000000000; //LDR		R1 ,[R0],#0		    //R1 = -2147483648
            {instruction_mem[167], instruction_mem[166], instruction_mem[165], instruction_mem[164]} <= 32'b1110_01_0_0100_1_0000_0010_000000000100; //LDR		R2 ,[R0],#4		    //R2 = -1073741824
            {instruction_mem[171], instruction_mem[170], instruction_mem[169], instruction_mem[168]} <= 32'b1110_01_0_0100_1_0000_0011_000000001000; //LDR		R3 ,[R0],#8		    //R3 = 41
            {instruction_mem[175], instruction_mem[174], instruction_mem[173], instruction_mem[172]} <= 32'b1110_01_0_0100_1_0000_0100_000000001100; //LDR		R4 ,[R0],#12	    //R4 = 8192
            {instruction_mem[179], instruction_mem[178], instruction_mem[177], instruction_mem[176]} <= 32'b1110_01_0_0100_1_0000_0101_000000010000; //LDR		R5 ,[R0],#16	    //R5 = -123
            {instruction_mem[183], instruction_mem[182], instruction_mem[181], instruction_mem[180]} <= 32'b1110_01_0_0100_1_0000_0110_000000010100; //LDR		R6 ,[R0],#20	    //R6 = 9
            {instruction_mem[187], instruction_mem[186], instruction_mem[185], instruction_mem[184]} <= 32'b1110_10_1_0_111111111111111111111111   ; //B		#-1
        end
    end

endmodule