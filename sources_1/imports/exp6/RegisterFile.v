module RegisterFile(reset, clk, RegWrite, Read_register1, Read_register2, Write_register, Write_data, Read_data1, Read_data2);
    input reset, clk;
    input RegWrite;
    input [4:0] Read_register1, Read_register2, Write_register;
    input [31:0] Write_data;
    output reg [31:0] Read_data1, Read_data2;
    
    reg [31:0] RF_data[31:1];
    
    integer i;
    always @(posedge reset or posedge clk) begin     // read and write on posedge, use forwarding.
        Read_data1 <= (Read_register1 == 5'b00000)? 32'h00000000: RF_data[Read_register1];
        Read_data2 <= (Read_register2 == 5'b00000)? 32'h00000000: RF_data[Read_register2];
        if (reset) begin
            for (i = 1; i < 29; i = i + 1)
                RF_data[i] <= 32'h00000000;
            RF_data[29]<=32'h7fff_fffc;
            RF_data[30]<=32'h00000000;
            RF_data[31]<=32'h00000000;
        end else if (RegWrite && (Write_register != 5'b00000))
            RF_data[Write_register] <= Write_data;
    end
endmodule