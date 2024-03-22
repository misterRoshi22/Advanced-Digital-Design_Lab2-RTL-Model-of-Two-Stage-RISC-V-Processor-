module register_file(Clock, Reset_n, Read_addr1, Read_addr2, Write_addr, Write_En, Write_data, Read_data1, Read_data2);
	input  			Clock, Reset_n;	// Clock and Reset
	input  [4:0] 	Read_addr1;			// Address of register 1
	input  [4:0] 	Read_addr2;			// Address of register 2
	input  [4:0] 	Write_addr;			// Used in load operation, (write_address)
	input  			Write_En;			// This will only be 1 in load operation else its zero
	input  [31:0] 	Write_data;			// Used in load operation, (write_data = &Op2 from RAM)
	output [31:0] 	Read_data1;			// Value stored in register 1
	output [31:0] 	Read_data2;			// Value stored in register 2

	reg 	[31:0] 	registers [0:31];	// The 32 registers comprising the register file
	
	integer i;

	// Register write
	always @(negedge Clock) begin 	// Negative Edge
		if(Reset_n) begin 
			for( i = 0; i < 32; i = i + 1)
				registers[i] = 0;
			registers[2] = 1024;			// On reset the value of sp is set to 1024
		end
	
		else if (Write_En)
			registers[Write_addr] <= Write_data;
	
		registers[0] <= 0;          	// Value of register 0 must always be zero
		
	
	end

	assign Read_data1 = registers[Read_addr1]; 
	assign Read_data2 = registers[Read_addr2];

endmodule //register_file