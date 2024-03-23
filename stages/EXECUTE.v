module EXECUTE(clk, reset_n, instruction, pc, pc_plus_4, 
 opcode, rs1, rs2, rd, funct3, add_sub,branch_address,
 jump_address, jalr_address, branch, jump, jalr, flush);

	//Universal Inputs
	input 		clk, reset_n;
	
	//Inputs From REG
	input	[31:0]	instruction;
	input	[10:0] 	pc, pc_plus_4;
	input	[6:0]  	opcode;
	input	[4:0]	rs1, rs2, rd;
	input 	[2:0]	funct3;
	input 		add_sub;
	
	//Outputs To FETCH
	output 	[10:0] 	branch_address, jump_address, jalr_address;
	output 		branch, jump, jalr;
	
	//Outputs To REG
	output		flush;
	
	//Reference Voltages
	wire 		GND, VCC;
	
	//Outputs from Control Unit
	wire  	[3:0] 	Branch;
	wire  	[1:0]	Jump;
	wire 		MemRead, MemWrite; 
	wire 	[3:0]	ALUOp;
	wire 	[1:0]	MemtoReg; 
	wire		ALUSrc;
	wire 		RegWrite;
	
	//Outputs from Register File
	wire 	[31:0]	Read_data1, Read_data2;
	
	//Outputs from Immediate
	wire 	[31:0] Immediate;
		
	//Output From ALU MUX
	wire 	[31:0] 	ALU_B;
	
	//Outputs from ALU
	wire 	[31:0]	ALU_Result;
	wire		Zero;
	
	//Outputs from MemToReg MUX
	wire 	[31:0]	write_data_reg_file;
	wire 	[31:0] 	jal_ra;
	
	//Outputs from Data Memory
	wire 	[31:0] 	read_data_memory;
	
	//Inputs to Register File
	wire 	[4:0]	WriteReg;
	wire 	[4:0]	ra;
	
	//Inputs to Jalr Adder
	wire 	[10:0] 	JALR_A, JALR_B;
	
	//Inputs to Branch Adder
	wire 	[10:0] 	BRANCH_A, BRANCH_B;
		
	//Inputs to Data Memory
	wire 	[10:0] 	address;
	wire 	[31:0]	write_data_memory;
	
	//Determines Control Signals For Rest of Modules
	control_unit control_unit(opcode, funct3, add_sub, Branch, Jump, MemRead,
   	MemWrite, ALUOp, MemtoReg, ALUSrc, RegWrite);
	
	//32x32 bit Register File used to store recent values
	register_file register_file(clk, reset_n, rs1, rs2,
	WriteReg, RegWrite, write_data_reg_file, Read_data1, Read_data2);
	
	//Calculates Immediate For I-Type instructions
	immediate_gen immediate_gen(instruction, Immediate);
	
	//Used To determine ALU_B
	mux_2to1 alu_b_mux(Read_data2, Immediate, ALUSrc, ALU_B);
	
	//Performs Operations based on ALUOp
	alu alu(Read_data1, ALU_B, ALU_Result, ALUOp, Zero);
	
	//Determines Whether or not we branch to different instruction
	branch_determination_unit branch_determination_unit(ALU_Result, Zero, Branch, branch);
 
	//Caluculates JALR target 
	adder jalr_target_adder(JALR_A, JALR_B, GND, jalr_address, );
	defparam jalr_target_adder.AB_width = 11;
	
	//Calculates BRANCH target
	adder branch_target_adder(BRANCH_A, BRANCH_B, GND, branch_address, );
	defparam branch_target_adder.AB_width = 11;
	
	//4096x32 bit Data Memory Used to less used values
	data_memory data_memory(clk, reset_n, address,
	MemWrite, MemRead, write_data_memory, read_data_memory);
	
	//Used to Determine what to write to Register File
	mux_4to1 mem_to_reg_mux(ALU_Result, read_data_memory, jal_ra, GND, MemtoReg, write_data_reg_file);

	//Used to Change Write Register in case of JAL as WriteReg is implicitly x1
	mux_2to1 write_reg_mux(rd, ra, jal, WriteReg);
	defparam write_reg_mux.AB_width = 5;
	
	//Assignments
	assign GND = 1'b0;
	assign VCC = 1'b1;
	assign JALR_A = Read_data1[10:0];
	assign JALR_B = Immediate[10:0];
	assign BRANCH_A = pc;
	assign BRANCH_B = {Immediate[10:0], 1'b0}; // immediate x 2
	assign jump_address = branch_address;
	assign address = ALU_Result[10:0];
	assign write_data_memory = Read_data2;
	assign jump = Jump[0] ^ Jump[1];
	assign jalr = Jump[1] & Jump[0];
	assign jal	= Jump[1] & !Jump[0];
	assign flush = branch || jump || jalr;
	assign ra = 5'b00001;
	assign jal_ra = {20'b0, pc};
	
endmodule 
