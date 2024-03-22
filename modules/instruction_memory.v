module instruction_memory(clk, address, read_data);

input clk;
 input [10:0] address;
 output reg [31:0] read_data;

reg [7:0] memory[0:2047];
initial begin

		memory[0] = 8'h13;    //addi x1 x0 52
		memory[1] = 8'hd0;
		memory[2] = 8'h00;
		memory[3] = 8'h08;

		memory[4] = 8'h13;    //addi x2 x0 21
		memory[5] = 8'h54;
		memory[6] = 8'h00;
		memory[7] = 8'h10;

		memory[8] = 8'h13;    //ori x3 x0 4
		memory[9] = 8'h13;
		memory[10] = 8'h00;
		memory[11] = 8'h18;

		memory[12] = 8'h33;    //add x4 x1 x2
		memory[13] = 8'h00;
		memory[14] = 8'h44;
		memory[15] = 8'h20;

		memory[16] = 8'h33;    //sub x5 x1 x2
		memory[17] = 8'h00;
		memory[18] = 8'h45;
		memory[19] = 8'h28;

		memory[20] = 8'hb3;    //sll x6 x1 x3
		memory[21] = 8'h00;
		memory[22] = 8'h46;
		memory[23] = 8'h30;

		memory[24] = 8'h93;    //srli x7 x2 1
		memory[25] = 8'h06;
		memory[26] = 8'h80;
		memory[27] = 8'h38;

		memory[28] = 8'h33;    //sub x8 x0 x7
		memory[29] = 8'h00;
		memory[30] = 8'h0f;
		memory[31] = 8'h40;

		memory[32] = 8'h33;    //slt x9 x8 x7
		memory[33] = 8'h01;
		memory[34] = 8'h0e;
		memory[35] = 8'h4a;

		memory[36] = 8'hb3;    //sltu x10 x8 x7
		memory[37] = 8'h01;
		memory[38] = 8'h0e;
		memory[39] = 8'h52;

		memory[40] = 8'h33;    //xor x11 x7 x8
		memory[41] = 8'h02;
		memory[42] = 8'hd0;
		memory[43] = 8'h59;

		memory[44] = 8'h13;    //slti x12 x1 -1
		memory[45] = 8'hfd;
		memory[46] = 8'h7f;
		memory[47] = 8'h60;

		memory[48] = 8'h93;    //sltiu x13 x1 -1
		memory[49] = 8'hfd;
		memory[50] = 8'h7f;
		memory[51] = 8'h68;

		memory[52] = 8'h93;    //slli x14 x1 8
		memory[53] = 8'h20;
		memory[54] = 8'h40;
		memory[55] = 8'h70;

		memory[56] = 8'h93;    //andi x15 x8 -25
		memory[57] = 8'h9f;
		memory[58] = 8'h3f;
		memory[59] = 8'h7a;

		memory[60] = 8'h13;    //xori x16 x8 -122
		memory[61] = 8'h1a;
		memory[62] = 8'h3e;
		memory[63] = 8'h82;

		memory[64] = 8'hb7;    //lui x17 12345
		memory[65] = 8'h1c;
		memory[66] = 8'h18;
		memory[67] = 8'h88;

		memory[68] = 8'h13;    //addi x18 x0 678
		memory[69] = 8'h98;
		memory[70] = 8'h0a;
		memory[71] = 8'h90;

		memory[72] = 8'h33;    //or x17 x17 x18
		memory[73] = 8'h03;
		memory[74] = 8'h64;
		memory[75] = 8'h8c;

		memory[76] = 8'h13;    //addi x18 x0 122
		memory[77] = 8'he8;
		memory[78] = 8'h01;
		memory[79] = 8'h90;

end
wire [10:0] add0, add1, add2, add3;

assign add0 = (address & 11'h7ffc) + 11'd0;
assign add1 = (address & 11'h7ffc) + 11'd1;
assign add2 = (address & 11'h7ffc) + 11'd2;
assign add3 = (address & 11'h7ffc) + 11'd3;
always @(negedge clk) begin //reading done at negative edges
	read_data <= {memory[add3], memory[add2], memory[add1], memory[add0]};
end

endmodule // instruction_memory

