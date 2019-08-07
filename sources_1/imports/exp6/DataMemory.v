module DataMemory(reset, clk, clk_count, Address, Write_data, Read_data, MemRead, MemWrite);
	input reset, clk;
	input [31:0] clk_count, Address, Write_data;
	input MemRead, MemWrite;
	output reg [31:0] Read_data;
	
	parameter RAM_SIZE = 512;
	parameter RAM_SIZE_BIT = 9;
	parameter PERI_SIZE = 512;
	parameter PERI_SIZE_BIT = 9;
	
	reg [31:0] RAM_data[RAM_SIZE - 1: 0];
	reg [31:0] PERI_data[PERI_SIZE - 1: 0];
	always @(posedge clk)  // if 0x4xxx xxx, use PERI_data
	   Read_data <= MemRead? (Address[30]?PERI_data[Address[PERI_SIZE_BIT + 1:2]]:RAM_data[Address[RAM_SIZE_BIT + 1:2]]): 32'h00000000;
	
	integer i;
    always @(posedge reset or posedge clk) begin
        if (reset) begin
            for (i = 0; i < RAM_SIZE; i = i + 1)
                RAM_data[i] <= 32'h00000000;
            for (i = 0; i < PERI_SIZE; i = i + 1)
                PERI_data[i] <= 32'h00000000;
        end else begin
            if (MemWrite) begin
                if (Address[30])
                    PERI_data[Address[PERI_SIZE_BIT + 1:2]] <= Write_data;
                else
                    RAM_data[Address[RAM_SIZE_BIT + 1:2]] <= Write_data;
            end
            PERI_data[5]<=clk_count;
            if (PERI_data[2][0]) begin
                if (&PERI_data[1]) begin
                    PERI_data[1]<=PERI_data[0];
                    if (PERI_data[2][1]) PERI_data[2][2]<=1'b1;
                end
            end
        end
    end
endmodule