`timescale 1ns/1ns
module test_cpu();
	
	reg reset;
	reg clk;
	wire [31:0] a0,t0,v0,ra,sp;
	
	assign a0=cpu1.register_file1.RF_data[4];
	assign v0=cpu1.register_file1.RF_data[2];
	assign t0=cpu1.register_file1.RF_data[8];
	assign ra=cpu1.register_file1.RF_data[31];
	assign sp=cpu1.register_file1.RF_data[29];
	
	CPU cpu1(reset, clk);
	initial begin
		reset = 1;
		clk = 1;
		#100 reset = 0;
	end
	
	always #50 clk = ~clk;
		
endmodule
