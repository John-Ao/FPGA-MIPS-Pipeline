`timescale 1ns/1ns
module test_cpu();
	
	reg reset;
	reg clk;
	wire [31:0] a0,v0,t0,ra,sp,pc;
	wire [31:0] stack[1:0];
	
	
	assign a0=cpu1.register_file1.RF_data[4];
	assign v0=cpu1.register_file1.RF_data[2];
	assign t0=cpu1.register_file1.RF_data[8];
	assign ra=cpu1.register_file1.RF_data[31];
	assign sp=cpu1.register_file1.RF_data[29];
	assign pc=cpu1.if_pc;
    assign stack[0]=cpu1.data_memory1.RAM_data[511];
    assign stack[1]=cpu1.data_memory1.RAM_data[510];

	CPU cpu1(reset, clk);
	initial begin
		reset = 1;
		clk = 1;
		#100 reset = 0;
	end
	
	always #50 clk = ~clk;
		
endmodule
