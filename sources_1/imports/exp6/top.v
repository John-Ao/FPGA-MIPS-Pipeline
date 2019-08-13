module top(clk,rst,leds,digits,digit_led_1,digit_led_2,Rx,Tx);
    input clk,rst;
    output [7:0] leds;
    output [6:0] digit_led_1,digit_led_2;
    output [7:0] digits;
    input Rx;
    output Tx;
    wire [31:0] num;
//    reg clk_;
//    reg [26:0] divider;
//    always@(posedge clk)
//        if (divider==27'd100_000_000) begin
//            divider<=27'd2;
//            num<=num+32'h1234;
//            clk_=~clk_;
//        end
//        else
//            divider<=divider+27'd2;
            
    CPU cpu(rst,clk,Rx,Tx);
    assign num=top.cpu.data_memory1.PERI_data[4];
    assign leds=top.cpu.data_memory1.PERI_data[3][7:0];
    display d1(clk,num[15:0],digits[3:0],digit_led_1);
    display d2(clk,num[31:16],digits[7:4],digit_led_2);
   
endmodule

