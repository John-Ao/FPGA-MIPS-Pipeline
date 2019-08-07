module top(clk,rst,pc_led,sp_select,sp_led,sp_led_select);
    input clk,rst;
    input [1:0] sp_select;
    output [7:0] pc_led;
    output [6:0] sp_led;
    output [3:0] sp_led_select;
    wire [15:0] num;
    reg clk_;
    reg [26:0] divider;
    always@(posedge clk)
        if (divider==27'd100_000_000) begin
            divider<=27'd2;
            clk_=~clk_;
        end
        else
            divider<=divider+27'd2;
            
    CPU cpu(rst,clk_);
    assign num=(sp_select==2'b00)?top.cpu.register_file1.RF_data[4]:   //$a0
               (sp_select==2'b01)?top.cpu.register_file1.RF_data[2]:   //$v0
               (sp_select==2'b10)?top.cpu.register_file1.RF_data[29]:  //$sp
               top.cpu.register_file1.RF_data[31];                     //$ra
    assign pc_led=top.cpu.PC[7:0];
    display d(clk,num,sp_led_select,sp_led);
   
endmodule

