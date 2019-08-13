`timescale 1ns/1ns
module test_cpu();
	
	reg reset;
	reg clk;
	wire [31:0] a0,a1,v0,t0,t1,t2,t3,t4,ra,sp,pc,epc;
	wire [31:0] stack[0:15];
	wire [31:0] stack_p[0:15];
	wire [31:0] num;
	wire [7:0] leds;
	wire clk_ecp,rx_ecp;
    parameter delay=200;
    parameter gap=2000;
    reg rx;
    wire tx;
    
    wire [6:0] digit_led;
    wire [7:0] digits;
    assign digit_led=cpu1.data_memory1.PERI_data[4][6:0];
    assign digits=cpu1.data_memory1.PERI_data[12][7:0];
	
    assign num=cpu1.data_memory1.PERI_data[4];
    assign leds=cpu1.data_memory1.PERI_data[3][7:0];
    assign clk_ecp=cpu1.clk_ecp;
    assign epc=cpu1.epc;
    assign rx_ecp=cpu1.rx_ecp;
	
	assign a0=cpu1.register_file1.RF_data[4];
	assign a1=cpu1.register_file1.RF_data[5];
	assign v0=cpu1.register_file1.RF_data[2];
	assign t0=cpu1.register_file1.RF_data[8];
	assign t1=cpu1.register_file1.RF_data[9];
	assign t2=cpu1.register_file1.RF_data[10];
	assign t3=cpu1.register_file1.RF_data[11];
	assign t4=cpu1.register_file1.RF_data[12];
	assign ra=cpu1.register_file1.RF_data[31];
	assign sp=cpu1.register_file1.RF_data[29];
	assign pc=cpu1.if_pc;
    assign stack[0]=cpu1.data_memory1.RAM_data[511];
    assign stack[1]=cpu1.data_memory1.RAM_data[510];
    assign stack[2]=cpu1.data_memory1.RAM_data[509];
    assign stack[3]=cpu1.data_memory1.RAM_data[508];
    assign stack[4]=cpu1.data_memory1.RAM_data[507];
    assign stack[5]=cpu1.data_memory1.RAM_data[506];
    assign stack[6]=cpu1.data_memory1.RAM_data[505];
    assign stack[7]=cpu1.data_memory1.RAM_data[504];
    assign stack[8]=cpu1.data_memory1.RAM_data[503];
    assign stack[9]=cpu1.data_memory1.RAM_data[502];
    assign stack[10]=cpu1.data_memory1.RAM_data[501];
    assign stack[11]=cpu1.data_memory1.RAM_data[500];
    assign stack[12]=cpu1.data_memory1.RAM_data[499];
    assign stack[13]=cpu1.data_memory1.RAM_data[498];
    assign stack[14]=cpu1.data_memory1.RAM_data[497];
    assign stack[15]=cpu1.data_memory1.RAM_data[496];
    
    assign stack_p[0]=cpu1.data_memory1.PERI_data[0];
    assign stack_p[1]=cpu1.data_memory1.PERI_data[1];
    assign stack_p[2]=cpu1.data_memory1.PERI_data[2];
    assign stack_p[3]=cpu1.data_memory1.PERI_data[3];
    assign stack_p[4]=cpu1.data_memory1.PERI_data[4];
    assign stack_p[5]=cpu1.data_memory1.PERI_data[5];
    assign stack_p[6]=cpu1.data_memory1.PERI_data[6];
    assign stack_p[7]=cpu1.data_memory1.PERI_data[7];
    assign stack_p[8]=cpu1.data_memory1.PERI_data[8];
    assign stack_p[9]=cpu1.data_memory1.PERI_data[9];
    assign stack_p[10]=cpu1.data_memory1.PERI_data[10];
    assign stack_p[11]=cpu1.data_memory1.PERI_data[11];
    assign stack_p[12]=cpu1.data_memory1.PERI_data[12];
    assign stack_p[13]=cpu1.data_memory1.PERI_data[13];
    assign stack_p[14]=cpu1.data_memory1.PERI_data[14];
    assign stack_p[15]=cpu1.data_memory1.PERI_data[15];
    CPU cpu1(reset, clk, rx, tx);
	initial begin
		reset = 1;
		clk = 1;
		rx = 1;
		#100 reset = 0;
		
		#4500;
        #delay rx<=0;
        
        #delay rx<=1;
        #delay rx<=0;
        #delay rx<=1;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        
        #delay rx<=1;
        #gap rx<=0;
        
        #delay rx<=0;
        #delay rx<=1;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        
        #delay rx<=1;
        #gap rx<=0;
        
        #delay rx<=1;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        
        #delay rx<=1;
        #gap rx<=0;
        
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=1;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        
        #delay rx<=1;
        #gap rx<=0;
        
        #delay rx<=1;
        #delay rx<=1;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        #delay rx<=0;
        
        #delay rx<=1;
	end
	
	always #50 clk = ~clk;
	

		
endmodule
