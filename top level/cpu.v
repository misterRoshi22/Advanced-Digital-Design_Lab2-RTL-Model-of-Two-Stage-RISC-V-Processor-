module cpu(clk, reset_n);

	//Universal Inputs
	input 		clk, reset_n; 	
	
	//Reference Voltages
	wire 		VCC, GND;
	
	//IF -> REG
	wire [31:0] 	instruction_if;
	wire [10:0] 	pc_if, pc_plus_4_if;
	
	//REG -> EXE
	wire [31:0]	instruction_reg;
	wire [10:0] 	pc_reg, pc_plus_4_reg;
	wire [6:0]  	opcode_reg;
	wire [4:0]	rs1_reg, rs2_reg, rd_reg;
	wire [2:0]	funct3_reg;
	wire 		add_sub_reg;
	
	
	//EXE -> IF
	wire [10:0] 	branch_address_exe, jump_address_exe, jalr_address_exe;
	wire  		branch_exe, jump_exe, jalr_exe;
	
	//EXE -> REG
	wire		flush_exe;
	
	FETCH if_stage(clk, reset_n, branch_exe, jump_exe, jalr_exe,
	branch_address_exe, jump_address_exe, jalr_address_exe,
	instruction_if, pc_if, pc_plus_4_if);
	
	IF_EXE_REG if_exe_reg(clk, reset_n, flush_exe, instruction_if, pc_if, pc_plus_4_if,
	instruction_reg, pc_reg, pc_plus_4_reg, opcode_reg, 
	rs1_reg, rs2_reg, rd_reg, funct3_reg, add_sub_reg);
	
	EXECUTE exe_stage(clk, reset_n, instruction_reg, pc_reg, pc_plus_4_reg, 
	opcode_reg, rs1_reg, rs2_reg, rd_reg, funct3_reg, add_sub_reg, 
	branch_address_exe, jump_address_exe, jalr_address_exe, 
	branch_exe, jump_exe, jalr_exe, flush_exe);
	
	assign VCC = 1'b1;
	assign GND = 1'b0;
	
endmodule //cpu


//inputs named after module they came from
//output named after module that made them
