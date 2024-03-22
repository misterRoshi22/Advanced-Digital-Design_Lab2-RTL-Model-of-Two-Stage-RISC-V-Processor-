module pc_control(branch, jump, jalr, pc_mux_select);

	input branch, jump, jalr;		//inputs from EXE stage used to determine if we should jump or not
	output reg [1:0] pc_mux_select;	//pc_mux select line used to determine input to mux
	
	//assuming that only one of the inputs is high (which should be true under the right conditions)
	always@(*) begin
		if(branch) pc_mux_select<= 2'b01;
		else if(jump) pc_mux_select <= 2'b10;
		else if(jalr) pc_mux_select <= 2'b11;
		else pc_mux_select <= 2'b00;
	
	end


endmodule //pc_control