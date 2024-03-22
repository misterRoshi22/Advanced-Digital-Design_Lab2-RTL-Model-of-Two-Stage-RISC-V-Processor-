module tb_cpu();

	reg clk, reset_n;
	
	cpu uut(clk, reset_n);
	
	initial begin
		clk  = 0;
		reset_n = 1;
		#10 reset_n = 0;
	
		#1000;
		$finish;
	end
	
	always begin
		#5 clk = ~clk;
	end



endmodule //tb_cpu
