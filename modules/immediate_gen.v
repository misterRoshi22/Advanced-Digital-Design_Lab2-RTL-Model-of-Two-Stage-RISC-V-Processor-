module immediate_gen(instruction, immediate);
   input [31:0] instruction;
	
   output [31:0] immediate;
	
   reg[31:0] IMM_OUT; //Sign Extended Immediate
   wire[6:0] OpCode;


	
   always @(*)  begin
	
		case(OpCode)
			7'b1100111: IMM_OUT <= {{7{instruction[31]}},instruction[31:7]};  			//J
			7'b1101111: IMM_OUT <= {{7{instruction[31]}},instruction[31:7]}; 			//JAL
			7'b0110111: IMM_OUT <= {instruction[26:7], 12'b0};					//LUI
			7'b0010011: IMM_OUT <= {{20{instruction[21]}},instruction[21:10]}; 			//I
			7'b0000011: IMM_OUT <= {{20{instruction[21]}},instruction[21:10]}; 			//LW
			7'b1100011: IMM_OUT <= {{20{instruction[31]}},instruction[31:27],instruction[16:10]}; 	//B
			7'b1101011: IMM_OUT <= {{20{instruction[21]}},instruction[21:10]}; 			//JALR
			7'b0100011: IMM_OUT <= {{20{instruction[31]}},instruction[31:27],instruction[16:10]}; 	//SW
				
			default: IMM_OUT <= 32'b0;
		 endcase
	end
	
	
	assign immediate = IMM_OUT;
   assign OpCode = instruction[6:0];

endmodule //immediate_gen
