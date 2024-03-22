module IF_EXE_REG(clk, reset_n, flush, instruction_in, pc_in, pc_plus_4_in,
instruction, pc, pc_plus_4, opcode,
 rs1, rs2, rd, funct3, add_sub);

	input 					clk, reset_n;
	
	input 					flush;
	
	input 		[31:0] 	instruction_in;
	input 		[10:0] 	pc_in;
	input 		[10:0] 	pc_plus_4_in;
	
	output reg	[31:0]	instruction;		//used for immediate generation
	output reg	[10:0] 	pc;					//used to calculate branch target
	output reg	[10:0] 	pc_plus_4;			//used to store incase of jalr
	
	output reg	[6:0] 	opcode;				//used in control unit
	output reg	[4:0] 	rs1, rs2, rd;		//operands for alu
	
	output reg	[2:0] 	funct3;				//used to determine alu mode of operation
	output reg				add_sub;
	
	always@(negedge clk) begin
	
		if(reset_n || flush) begin
			instruction <= 0;
			pc <= 0;
			pc_plus_4 <= 0;
			opcode <= 0;
			rs1 <= 0;
			rs2 <= 0;
			rd <= 0;
			funct3 <= 0;
			add_sub <= 0;
		end
		
		else begin
			instruction <= instruction_in;
			pc <= pc_in;
			pc_plus_4 <= pc_plus_4_in;
			opcode <= instruction_in[6:0];
			rs1 <= instruction_in[26:22];
			rs2 <= instruction_in[21:17];
			rd  <= instruction_in[31:27];
			funct3 <= instruction_in[9:7];
			add_sub <= instruction_in[16];
		end
		
		
	end
		
endmodule //IF_EXE_REG