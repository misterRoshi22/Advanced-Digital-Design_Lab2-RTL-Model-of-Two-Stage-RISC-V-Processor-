module FETCH(clk, reset_n, branch, jump, jalr,
branch_address, jump_address, jalr_address,
instruction, pc_NEXT, pc_plus_4);

	//Inputs
	input 		clk, reset_n;
	input		branch, jump, jalr;
	input 	[10:0]	branch_address, jump_address, jalr_address;
	
	//Internal Signals
	wire 	[10:0] 	pc_IN, pc_OUT;
	wire 		VCC, GND;
	wire 	[10:0] 	four;
	wire 	[1:0] 	pc_mux_select;
	
	//Outputs
	output 	[31:0] 	instruction;
	output 	[10:0] 	pc_NEXT;
	output 	[10:0] 	pc_plus_4;
	
	//Program Counter
	register pc(clk, reset_n, VCC, pc_IN, pc_OUT);
	defparam pc.n = 11;
	
	//Adder to calculate PC + 4
	adder pc_adder(pc_OUT, four, GND, pc_plus_4, ); 
   	defparam pc_adder.AB_width = 11; 
	
	//MUX Used to select input into PC
	mux_4to1 pc_mux(pc_plus_4, branch_address, jump_address, jalr_address,
	pc_mux_select, pc_IN);
	defparam pc_mux.AB_width = 11;
	
	//Simple control unit used to determine pc_mux select line
	pc_control pc_control(branch, jump, jalr, pc_mux_select );

	//Instruction ROM used to store instuctions
	instruction_memory instruction_ROM(clk, pc_OUT, instruction);
	
	
	assign VCC = 1'b1;
	assign GND = 1'b0;
	assign four = 11'd4;
	assign pc_NEXT = pc_OUT;

endmodule //FETCH
