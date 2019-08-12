module DataMemory(reset, clk, clk_count, Address, Write_data, Read_data, MemRead, MemWrite, clk_ecp, rx, tx, rx_ecp, peri_addr);
    input reset, clk, rx, peri_addr;
    input [31:0] clk_count, Address, Write_data;
    input MemRead, MemWrite;
    output reg [31:0] Read_data;
    output reg clk_ecp;
    output rx_ecp, tx;
    
    parameter RAM_SIZE = 512;
    parameter RAM_SIZE_BIT = 9;
    parameter PERI_SIZE = 16;
    parameter PERI_SIZE_BIT = 4;
    
    reg [31:0] RAM_data[RAM_SIZE - 1: 0];
    reg [31:0] PERI_data[PERI_SIZE - 1: 0];

    // Address Table
    // 0x0000 0000 ~ 0x0000 07FF Data Memory
    
    // 0x4000 0000               Timer Reset Value
    // 0x4000 0004               Timer Counter
    // 0x4000 0008               Timer Control Bits
    //        [Enable][Exception Enable][Exception]
    // 0x4000 000C               LEDs
    // 0x4000 0010               digit display
    // 0x4000 0014               system clock counter
    
    // 0x4000 0018               UART receive data
    // 0x4000 001C               UART receive enable
    // 0x4000 0020               UART receive done
    
    // 0x4000 0024               UART send data
    // 0x4000 0028               UART send enable
    // 0x4000 002C               UART send done

//    wire peri_addr;
//    assign peri_addr=(Address[31:28]==4'h4);
    wire [RAM_SIZE_BIT - 1:0] addr_;
    wire [PERI_SIZE_BIT - 1:0] p_addr_;
    assign addr_=Address[RAM_SIZE_BIT + 1:2];
    assign p_addr_=Address[PERI_SIZE_BIT + 1:2];

    
    wire rx_en,tx_en_,rx_done,tx_done;
    wire [7:0] rx_out,tx_in_;
    reg tx_en;
    reg [7:0] tx_in;
    assign rx_en=(!PERI_data[7][0]||PERI_data[8][0])||rx;
    assign tx_en_=PERI_data[10][0]&&!PERI_data[11][0];
    assign rx_ecp=PERI_data[8][0];
    assign tx_in_=PERI_data[9][7:0];
   
    always @(posedge clk) begin  // if 0x4xxx xxx, use PERI_data
//       Read_data <= MemRead? (peri_addr?PERI_data[addr_]:RAM_data[addr_]): 32'h00000000;
       Read_data <= (peri_addr?PERI_data[p_addr_]:RAM_data[addr_]);
       tx_en<=tx_en_;
       tx_in<=tx_in_;
    end
    
    
    uart_rx rx1(clk,rx_en,rx_done,rx_out);
    uart_tx tx1(clk,tx_en,tx_in,tx,tx_done);
    
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
                if (peri_addr) begin
                    if (p_addr_!=6) PERI_data[p_addr_] <= Write_data;
                end else begin
                    RAM_data[addr_] <= Write_data;
                end
            end
            PERI_data[5]<=clk_count;
            if (PERI_data[2][0]) begin              // timer enabled
                if (&PERI_data[1]) begin            // time up
                    PERI_data[1]<=PERI_data[0];
                    if (PERI_data[2][1]) begin            // Exception enabled
                        PERI_data[2][2]<=1'b1;
                        clk_ecp<=1'b1;
                    end
                end else begin
                    clk_ecp<=1'b0;
                    PERI_data[1]<=PERI_data[1]+32'b1;   // timer add 1
                end
            end else
                clk_ecp<=1'b0;
            if (!MemWrite||p_addr_!=8) PERI_data[8][0]<=rx_done|PERI_data[8][0];   // uart receive done
            if (!MemWrite||p_addr_!=11) PERI_data[11][0]<=tx_done|PERI_data[11][0];   // uart receive done
            PERI_data[6][7:0]<=rx_out;
        end
    end
endmodule