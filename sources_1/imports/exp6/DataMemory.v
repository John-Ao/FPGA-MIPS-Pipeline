module DataMemory(reset, clk, clk_count, Address, Write_data, Read_data, MemRead, MemWrite, clk_ecp);
    input reset, clk;
    input [31:0] clk_count, Address, Write_data;
    input MemRead, MemWrite;
    output reg [31:0] Read_data;
    output reg clk_ecp;
    
    parameter RAM_SIZE = 512;
    parameter RAM_SIZE_BIT = 9;
    parameter PERI_SIZE = 512;
    parameter PERI_SIZE_BIT = 9;
    
    reg [31:0] RAM_data[RAM_SIZE - 1: 0];
    reg [31:0] PERI_data[PERI_SIZE - 1: 0];

    // Address Table
    // 0x0000 0000 ~ 0x0000 07FF Data Memory
    // 0x4000 0000               Timer Reset Value
    // 0x4000 0004               Timer Counter
    // 0x4000 0008               Timer Control Bits
    //        [Enable][Interrupt Enable][Interrupt]
    // 0x4000 000C               LEDs
    // 0x4000 0010               digit display
    // 0x4000 0014               system clock counter

    wire peri_addr;
    assign peri_addr=(Address[31:28]==4'h4);
    wire [PERI_SIZE_BIT - 1:0] addr_;
    assign addr_=Address[PERI_SIZE_BIT + 1:2];

    always @(posedge clk)  // if 0x4xxx xxx, use PERI_data
//       Read_data <= MemRead? (peri_addr?PERI_data[addr_]:RAM_data[addr_]): 32'h00000000;
       Read_data <= (peri_addr?PERI_data[addr_]:RAM_data[addr_]);
    
    integer i;
    always @(posedge reset or posedge clk) begin
        if (reset) begin
            for (i = 0; i < RAM_SIZE; i = i + 1)
                RAM_data[i] <= 32'h00000000;
            for (i = 0; i < PERI_SIZE; i = i + 1)
                PERI_data[i] <= 32'h00000000;
            clk_ecp<=1'b0;
        end else begin
            if (MemWrite) begin
                if (peri_addr)
                    PERI_data[addr_] <= Write_data;
                else
                    RAM_data[addr_] <= Write_data;
            end
            PERI_data[5]<=clk_count;
            if (PERI_data[2][0]) begin
                if (&PERI_data[1]) begin
                    PERI_data[1]<=PERI_data[0];
                    clk_ecp<=1'b1;
                    if (PERI_data[2][1]) PERI_data[2][2]<=1'b1;
                end else
                    clk_ecp<=1'b0;
            end else
                clk_ecp<=1'b0;
        end
    end
endmodule