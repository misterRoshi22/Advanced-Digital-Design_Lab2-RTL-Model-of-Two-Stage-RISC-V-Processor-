module alu(A, B, ALU_Result, ALUOpCode, Zero);
 
	
	input 		[31:0] 	A, B; 				// Operands
	input 		[3:0]	ALUOpCode;			// Operation
	
	output reg	[31:0] 	ALU_Result; 			// Result
	output reg 		Zero; 				// Zero flag

	always @ (ALUOpCode or A or B) begin
	
		Zero = 0; //By default Zero Flag is equal to 0
			
		
		case(ALUOpCode)
							
				4'b0000:	// ADD
				ALU_Result = $signed(A) + $signed(B);

				4'b0001:	// SLL
				ALU_Result = A << B;

				4'b0010:	// SLT
				ALU_Result = ( $signed(A) < $signed(B) ) ? 1 : 0;

				4'b0011:	// SLTU
				ALU_Result = ( (A) < (B) ) ? 1 : 0;

				4'b0100:	// XOR 
				ALU_Result = A ^ B;

				4'b0101:	// SRL
				ALU_Result = A >> B;

				4'b0110:	// OR
				ALU_Result = A | B;

				4'b0111:	// AND
				ALU_Result = A & B;
				
				4'b1000:	// SUB
				ALU_Result = $signed(A) - $signed(B);
				
				4'b1001:	// LUI
				ALU_Result = B;
					
			
			endcase
			
		Zero = (ALU_Result == 32'b0) ? 1 : 0;
 	
	end

endmodule //alu
