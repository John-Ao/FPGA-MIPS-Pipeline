
module InstructionMemory(Address, Instruction);
    input [31:0] Address;
    output reg [31:0] Instruction;
    
    always @(*)
        case (Address[31])
            1'b0:case (Address[9:2])
                8'd0:   Instruction<=32'b001000_00000_00001_00000_00000_111100;
                8'd1:   Instruction<=32'b000000_11101_00001_11101_00000_100010;
                8'd2:   Instruction<=32'b000000_00000_11101_10101_00000_100001;
                8'd3:   Instruction<=32'b001001_00000_00100_00000_00000_111111;
                8'd4:   Instruction<=32'b101011_11101_00100_00000_00000_000000;
                8'd5:   Instruction<=32'b001001_00000_00100_00000_00000_000110;
                8'd6:   Instruction<=32'b101011_11101_00100_00000_00000_000100;
                8'd7:   Instruction<=32'b001001_00000_00100_00000_00001_011011;
                8'd8:   Instruction<=32'b101011_11101_00100_00000_00000_001000;
                8'd9:   Instruction<=32'b001001_00000_00100_00000_00001_001111;
                8'd10:  Instruction<=32'b101011_11101_00100_00000_00000_001100;
                8'd11:  Instruction<=32'b001001_00000_00100_00000_00001_100110;
                8'd12:  Instruction<=32'b101011_11101_00100_00000_00000_010000;
                8'd13:  Instruction<=32'b001001_00000_00100_00000_00001_101101;
                8'd14:  Instruction<=32'b101011_11101_00100_00000_00000_010100;
                8'd15:  Instruction<=32'b001001_00000_00100_00000_00001_111101;
                8'd16:  Instruction<=32'b101011_11101_00100_00000_00000_011000;
                8'd17:  Instruction<=32'b001001_00000_00100_00000_00000_000111;
                8'd18:  Instruction<=32'b101011_11101_00100_00000_00000_011100;
                8'd19:  Instruction<=32'b001001_00000_00100_00000_00001_111111;
                8'd20:  Instruction<=32'b101011_11101_00100_00000_00000_100000;
                8'd21:  Instruction<=32'b001001_00000_00100_00000_00001_101111;
                8'd22:  Instruction<=32'b101011_11101_00100_00000_00000_100100;
                8'd23:  Instruction<=32'b001001_00000_00100_00000_00001_110111;
                8'd24:  Instruction<=32'b101011_11101_00100_00000_00000_101000;
                8'd25:  Instruction<=32'b001001_00000_00100_00000_00001_111100;
                8'd26:  Instruction<=32'b101011_11101_00100_00000_00000_101100;
                8'd27:  Instruction<=32'b001001_00000_00100_00000_00000_111001;
                8'd28:  Instruction<=32'b101011_11101_00100_00000_00000_110000;
                8'd29:  Instruction<=32'b001001_00000_00100_00000_00001_011110;
                8'd30:  Instruction<=32'b101011_11101_00100_00000_00000_110100;
                8'd31:  Instruction<=32'b001001_00000_00100_00000_00001_111001;
                8'd32:  Instruction<=32'b101011_11101_00100_00000_00000_111000;
                8'd33:  Instruction<=32'b001001_00000_00100_00000_00001_110001;
                8'd34:  Instruction<=32'b101011_11101_00100_00000_00000_111100;
                8'd35:  Instruction<=32'b001111_00000_10000_01000_00000_000000;
                8'd36:  Instruction<=32'b001000_00000_10001_00000_00000_000001;
                8'd37:  Instruction<=32'b001000_00000_00001_00000_00000_000100;
                8'd38:  Instruction<=32'b000000_11101_00001_01001_00000_100010;
                8'd39:  Instruction<=32'b001000_00000_00001_00000_00000_010100;
                8'd40:  Instruction<=32'b000000_11101_00001_11101_00000_100010;
                8'd41:  Instruction<=32'b000000_00000_11101_01000_00000_100001;
                8'd42:  Instruction<=32'b001000_00000_00100_00000_00000_000101;
                8'd43:  Instruction<=32'b101011_10000_10001_00000_00000_011100;
                8'd44:  Instruction<=32'b000101_00100_00000_11111_11111_111111;
                8'd45:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd46:  Instruction<=32'b101011_10000_00000_00000_00000_011100;
                8'd47:  Instruction<=32'b000000_00000_01000_00100_00000_100001;
                8'd48:  Instruction<=32'b000000_00000_01001_00101_00000_100001;
                8'd49:  Instruction<=32'b001000_00000_00001_00000_00000_010100;
                8'd50:  Instruction<=32'b000000_11101_00001_11101_00000_100010;
                8'd51:  Instruction<=32'b101011_10000_00000_00000_00000_001000;
                8'd52:  Instruction<=32'b100011_10000_10100_00000_00000_010100;
                8'd53:  Instruction<=32'b000011_00000_00000_00000_00001_010011;
                8'd54:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd55:  Instruction<=32'b100011_10000_01001_00000_00000_010100;
                8'd56:  Instruction<=32'b001111_00000_00001_00000_00000_000001;
                8'd57:  Instruction<=32'b001101_00001_00001_10000_11010_100000;
                8'd58:  Instruction<=32'b000000_00000_00001_00100_00000_100010;
                8'd59:  Instruction<=32'b101011_10000_00100_00000_00000_000000;
                8'd60:  Instruction<=32'b101011_10000_00100_00000_00000_000100;
                8'd61:  Instruction<=32'b000000_00000_00000_11011_00000_100001;
                8'd62:  Instruction<=32'b001000_00000_00100_00000_00000_000011;
                8'd63:  Instruction<=32'b101011_10000_00100_00000_00000_001000;
                8'd64:  Instruction<=32'b000000_01001_10100_01001_00000_100010;
                8'd65:  Instruction<=32'b000000_00000_01001_10011_00000_100001;
                8'd66:  Instruction<=32'b001000_00000_00010_00000_00000_000101;
                8'd67:  Instruction<=32'b100011_11101_01001_00000_00000_000000;
                8'd68:  Instruction<=32'b101011_10000_01001_00000_00000_100100;
                8'd69:  Instruction<=32'b101011_10000_10001_00000_00000_101000;
                8'd70:  Instruction<=32'b100011_10000_01001_00000_00000_101100;
                8'd71:  Instruction<=32'b000100_01001_00000_11111_11111_111110;
                8'd72:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd73:  Instruction<=32'b101011_10000_00000_00000_00000_101000;
                8'd74:  Instruction<=32'b101011_10000_00000_00000_00000_101100;
                8'd75:  Instruction<=32'b001000_11101_11101_00000_00000_000100;
                8'd76:  Instruction<=32'b001000_00000_00001_00000_00000_000001;
                8'd77:  Instruction<=32'b000000_00010_00001_00010_00000_100010;
                8'd78:  Instruction<=32'b000101_00010_00000_11111_11111_110100;
                8'd79:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd80:  Instruction<=32'b001000_11101_11101_00000_00000_010100;
                8'd81:  Instruction<=32'b000010_00000_00000_00000_00000_100011;
                8'd82:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd83:  Instruction<=32'b001000_00000_00001_00000_00000_000100;
                8'd84:  Instruction<=32'b000000_11101_00001_11101_00000_100010;
                8'd85:  Instruction<=32'b101011_11101_11111_00000_00000_000000;
                8'd86:  Instruction<=32'b000000_00101_00100_01000_00000_100010;
                8'd87:  Instruction<=32'b001000_01000_01000_00000_00000_000100;
                8'd88:  Instruction<=32'b000000_00000_01000_01001_00011_000011;
                8'd89:  Instruction<=32'b000000_00000_01001_01001_00010_000000;
                8'd90:  Instruction<=32'b000000_01001_00100_01010_00000_100000;
                8'd91:  Instruction<=32'b100011_01010_01010_00000_00000_000000;
                8'd92:  Instruction<=32'b000000_00000_00100_01000_00000_100001;
                8'd93:  Instruction<=32'b000000_00000_00101_01001_00000_100001;
                8'd94:  Instruction<=32'b100011_01000_01011_00000_00000_000000;
                8'd95:  Instruction<=32'b001000_01000_01000_00000_00000_000100;
                8'd96:  Instruction<=32'b000000_01011_01010_00001_00000_101010;
                8'd97:  Instruction<=32'b000101_00001_00000_11111_11111_111100;
                8'd98:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd99:  Instruction<=32'b001000_00000_00001_00000_00000_000100;
                8'd100: Instruction<=32'b000000_01000_00001_01000_00000_100010;
                8'd101: Instruction<=32'b100011_01001_01011_00000_00000_000000;
                8'd102: Instruction<=32'b001000_00000_00001_00000_00000_000100;
                8'd103: Instruction<=32'b000000_01001_00001_01001_00000_100010;
                8'd104: Instruction<=32'b000000_01010_01011_00001_00000_101010;
                8'd105: Instruction<=32'b000101_00001_00000_11111_11111_111011;
                8'd106: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd107: Instruction<=32'b001000_01001_01001_00000_00000_000100;
                8'd108: Instruction<=32'b000000_01001_01000_00001_00000_101010;
                8'd109: Instruction<=32'b000101_00001_00000_00000_00000_001000;
                8'd110: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd111: Instruction<=32'b100011_01000_01011_00000_00000_000000;
                8'd112: Instruction<=32'b100011_01001_01100_00000_00000_000000;
                8'd113: Instruction<=32'b101011_01001_01011_00000_00000_000000;
                8'd114: Instruction<=32'b101011_01000_01100_00000_00000_000000;
                8'd115: Instruction<=32'b001000_01000_01000_00000_00000_000100;
                8'd116: Instruction<=32'b001000_00000_00001_00000_00000_000100;
                8'd117: Instruction<=32'b000000_01001_00001_01001_00000_100010;
                8'd118: Instruction<=32'b000000_01001_01000_00001_00000_101010;
                8'd119: Instruction<=32'b000100_00001_00000_11111_11111_100110;
                8'd120: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd121: Instruction<=32'b001000_00000_00001_00000_00000_001000;
                8'd122: Instruction<=32'b000000_11101_00001_11101_00000_100010;
                8'd123: Instruction<=32'b101011_11101_00101_00000_00000_000000;
                8'd124: Instruction<=32'b101011_11101_01000_00000_00000_000100;
                8'd125: Instruction<=32'b000000_00100_01001_00001_00000_101010;
                8'd126: Instruction<=32'b000100_00001_00000_00000_00000_000100;
                8'd127: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd128: Instruction<=32'b000000_00000_01001_00101_00000_100001;
                8'd129: Instruction<=32'b000011_00000_00000_00000_00001_010011;
                8'd130: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd131: Instruction<=32'b100011_11101_00101_00000_00000_000000;
                8'd132: Instruction<=32'b100011_11101_00100_00000_00000_000100;
                8'd133: Instruction<=32'b001000_11101_11101_00000_00000_001000;
                8'd134: Instruction<=32'b000000_01000_00101_00001_00000_101010;
                8'd135: Instruction<=32'b000100_00001_00000_00000_00000_000011;
                8'd136: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd137: Instruction<=32'b000011_00000_00000_00000_00001_010011;
                8'd138: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd139: Instruction<=32'b100011_11101_11111_00000_00000_000000;
                8'd140: Instruction<=32'b001000_11101_11101_00000_00000_000100;
                8'd141: Instruction<=32'b000000_11111_00000_00000_00000_001000;
                8'd142: Instruction<=32'b000000_00000_00000_00000_00000_000000;
                default: Instruction <= 32'h00000000;
            endcase
        1'b1:case (Address[9:2])
                8'd0:   Instruction<=32'b000010_00000_00000_00000_00000_000110;
                8'd1:   Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd2:   Instruction<=32'b000010_00000_00000_00000_00000_010110;
                8'd3:   Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd4:   Instruction<=32'b000010_00000_00000_00000_00000_011101;
                8'd5:   Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd6:   Instruction<=32'b000101_11011_00000_00000_00000_000100;
                8'd7:   Instruction<=32'b000000_00000_00000_00000_00000_000000;
                8'd8:   Instruction<=32'b001001_00000_11011_00000_00000_001000;
                8'd9:   Instruction<=32'b000000_00000_10011_11000_00000_100001;
                8'd10:  Instruction<=32'b000000_00000_10001_11001_00000_100001;
                8'd11:  Instruction<=32'b001100_11000_01111_00000_00000_001111;
                8'd12:  Instruction<=32'b000000_00000_01111_01111_00010_000000;
                8'd13:  Instruction<=32'b000000_10101_01111_01111_00000_100000;
                8'd14:  Instruction<=32'b100011_01111_01111_00000_00000_000000;
                8'd15:  Instruction<=32'b101011_10000_11001_00000_00000_110000;
                8'd16:  Instruction<=32'b101011_10000_01111_00000_00000_010000;
                8'd17:  Instruction<=32'b000000_00000_11001_11001_00001_000000;
                8'd18:  Instruction<=32'b000000_00000_11000_11000_00100_000011;
                8'd19:  Instruction<=32'b001000_00000_00001_00000_00000_000001;
                8'd20:  Instruction<=32'b000000_11011_00001_11011_00000_100010;
                8'd21:  Instruction<=32'b010000_10000_00000_00000_00000_011000;
                8'd22:  Instruction<=32'b100011_10000_11010_00000_00000_011000;
                8'd23:  Instruction<=32'b101011_11101_11010_00000_00000_000000;
                8'd24:  Instruction<=32'b101011_10000_00000_00000_00000_100000;
                8'd25:  Instruction<=32'b001000_11101_11101_00000_00000_000100;
                8'd26:  Instruction<=32'b001000_00000_00001_00000_00000_000001;
                8'd27:  Instruction<=32'b000000_00100_00001_00100_00000_100010;
                8'd28:  Instruction<=32'b010000_10000_00000_00000_00000_011000;
                8'd29:  Instruction<=32'b000010_00000_00000_00000_00000_011101;
                8'd30:  Instruction<=32'b000000_00000_00000_00000_00000_000000;
                default: Instruction <= 32'h00000000;
            endcase
        endcase
endmodule
