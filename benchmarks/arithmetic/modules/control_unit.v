module control_unit(OPCODE, FUNCT3, ADD_SUB, Branch, Jump, MemRead,
MemWrite, ALUOp, MemtoReg, ALUSrc, RegWrite);

	input [6:0] OPCODE;
	input [2:0] FUNCT3;
	input ADD_SUB; 				// Instruction[16] 17th bit
	
	output reg [3:0] Branch;
	output reg [1:0] Jump;
	output reg MemRead;
	output reg MemWrite;
	output reg [3:0] ALUOp;
	output reg [1:0] MemtoReg;
	output reg ALUSrc;
	output reg RegWrite;
	
	
	always @(*) begin
		{RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, ALUOp, Branch, Jump} <= 0; //By Default all Control Signals are equal to zero
			
		case (OPCODE)
		
			7'b0110011: begin	//R-Type
				RegWrite <= 1;
				
				case(FUNCT3) 
					3'b000: begin //ADD-SUB
						ALUOp <= (ADD_SUB) ? 4'b1000 : 4'b0000;
					end
					
					default: begin //AND OR SLL SRL XOR SLT SLTU
						ALUOp <= {1'b0,FUNCT3};
					end
					
				endcase
				
				RegWrite <= 1;
			end
			
			7'b0010011: begin	//I-Type
				RegWrite <= 1;
				ALUSrc <= 1;
				ALUOp <= {1'b0, FUNCT3};
			end
			
			7'b1100011: begin //B-Type
				Branch <= {1'b1,FUNCT3};					// Type of Branch
				
				if (!FUNCT3[2]) ALUOp <= 4'b1000;    	// Subtract
				else if(FUNCT3[1]) ALUOp <= 4'b0011; 	// Unsigned Comparasion
				else ALUOp <= 4'b0010;			  			// Signed Comparasion
			end
			
			7'b0000011: begin //LW
				MemRead <= 1;
				MemtoReg <= 2'b01;
				RegWrite <= 1;
				ALUOp <= 4'b0000;
				ALUSrc <= 1;
			end
			
			7'b0100011: begin	//SW
				MemWrite <= 1;
				ALUSrc <= 1;
				ALUOp <= 4'b0000;	
			end
			
			7'b1100111: begin //J
				Jump <= 2'b01;
			end
			
			7'b1101111: begin //JAL
				Jump <= 2'b10;
				MemtoReg <= 2'b10;
				RegWrite <= 1;
			end
			
			7'b1101011: begin //JALR 
				Jump <= 2'b11;
				MemtoReg <= 2'b10;
				RegWrite <= 1;
			end
			
			7'b0110111: begin //LUI
				RegWrite <= 1;
				ALUOp <= 4'b1001;
				ALUSrc <= 1;
			end		
			
			
		endcase		

	end	
	


endmodule //control_unit