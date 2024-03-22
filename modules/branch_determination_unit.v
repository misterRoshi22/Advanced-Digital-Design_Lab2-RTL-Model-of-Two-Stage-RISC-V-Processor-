module branch_determination_unit(ALU_Result, Zero, Branch, branch);

	input 		[31:0] 	ALU_Result;
	input						Zero;
	input 		[3:0] 	Branch;
	
	output reg				branch;
	
	wire Less;
	
	always@(*) begin
		branch <= 0;
		
		case(Branch) 
			4'b1000: branch <= Zero;  	//BEQ
			4'b1001: branch <= !Zero; 	//BNE
			4'b1100: branch <= Less;	//BLT
			4'b1101: branch <= !Less; 	//BGE
			4'b1110: branch <= Less;	//BLTU
			4'b1111: branch <= !Less;	//BGEU
			
			default: branch <= 0;
		endcase
	
	
	end
	
	assign Less = ALU_Result[0];

endmodule //branch_determination_unit