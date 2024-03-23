module data_memory(clk, reset_n, address,
write_enable, read_enable, write_data, read_data);

	input 			clk;				//CLOCK
	input 			reset_n;			//Universal Reset
   	input [10:0] 		address;			//Address used for reading and writing
   	input [31:0] 		write_data;			//Store Byte/Word
	input 			read_enable; 			//1 in case of SW 
   	input 			write_enable;			//1 in case of LW
   	output reg [31:0] 	read_data;			//Load Byte/Word
	 
   	reg [7:0] memory[0:2047];				//the 2048 registers comprising the data memory
	 
	wire [10:0] add0, add1, add2, add3;			//Addresses used to read individual words
	integer i;
	 
	//Round down the address to nearest word as word alignment might not gaurenteed
	assign add0 = (address & 11'hffc)+ 11'd0;
	assign add1 = (address & 11'hffc)+ 11'd1;
	assign add2 = (address & 11'hffc)+ 11'd2;
	assign add3 = (address & 11'hffc)+ 11'd3;
	 
	 
	 
	always@(negedge clk) begin //posedge for writing
		
			if(reset_n)  
				begin 
					for( i = 0; i < 2047; i = i + 1)
						 memory[i] = 0;
						 
			{memory[3],memory[2],memory[1],memory[0]} = 32'h0;
			{memory[7],memory[6],memory[5],memory[4]} = 32'h1;
			{memory[11],memory[10],memory[9],memory[8]} = 32'h2;
			{memory[15],memory[14],memory[13],memory[12]} = 32'h3;
			{memory[19],memory[18],memory[17],memory[16]} = 32'h4;
			{memory[23],memory[22],memory[21],memory[20]} = 32'h5;
			{memory[27],memory[26],memory[25],memory[24]} = 32'h6;
			{memory[31],memory[30],memory[29],memory[28]} = 32'h7;
			{memory[35],memory[34],memory[33],memory[32]} = 32'h8;
			{memory[39],memory[38],memory[37],memory[36]} = 32'h9;


			{memory[67],memory[66],memory[65],memory[64]} = 32'h9;
			  end
			  

		
			if(write_enable) begin
				memory[add0] = write_data[7:0];
				memory[add1] = write_data[15:8];
				memory[add2] = write_data[23:16];
				memory[add3] = write_data[31:24];
			end
			
	end
	 
	always@(posedge clk) begin //negedge for reading
	 
			 read_data <= 32'b0;
			 
			if(read_enable) begin 
				read_data[7:0] <= memory[add0];		
				read_data[15:8] <= memory[add1];
				read_data[23:16] <= memory[add2];
				read_data[31:24] <= memory[add3];
			end
	end
	 
endmodule //data_memory
