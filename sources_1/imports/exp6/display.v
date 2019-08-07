module display(clk,freq,led_on,leds);
    input clk;
    input [15:0] freq;
    output reg [3:0] led_on;
    output [6:0] leds;
    reg [3:0] din;
    reg [19:0] counter;
    always@(posedge clk) begin
        counter=counter+20'd1;
        if(counter==20'd100_000) begin
            counter<=20'd0;
            case(led_on)
                4'b0001:begin
                    led_on<=4'b0010;
                    din<=freq[7:4];
                end
                4'b0010:begin
                    led_on<=4'b0100;
                    din<=freq[11:8];
                end
                4'b0100:begin
                    led_on<=4'b1000;
                    din<=freq[15:12];
                end
                default:begin
                    led_on<=4'b0001;
                    din<=freq[3:0];
                end
            endcase
        end
    end
    BCD7 bcd(din,leds);
endmodule