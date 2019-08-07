
module InstructionMemory(Address, Instruction);
	input [31:0] Address;
	output reg [31:0] Instruction;
	
	always @(*)      //use negedge to make sure that PC is calculated
		case (Address[9:2])
			8'd0:	Instruction<=32'b001000_00000_00100_00000_00000_000011;
            8'd1:	Instruction<=32'b000011_00000_00000_00000_00000_000011;
            8'd2:	Instruction<=32'b000100_00000_00000_11111_11111_111111;
            8'd3:	Instruction<=32'b001000_11101_11101_11111_11111_111000;
            8'd4:	Instruction<=32'b101011_11101_11111_00000_00000_000100;
            8'd5:	Instruction<=32'b101011_11101_00100_00000_00000_000000;
            8'd6:	Instruction<=32'b001010_00100_01000_00000_00000_000001;
            8'd7:	Instruction<=32'b000100_01000_00000_00000_00000_000011;
            8'd8:	Instruction<=32'b000000_00000_00000_00010_00000_100110;
            8'd9:	Instruction<=32'b001000_11101_11101_00000_00000_001000;
            8'd10:	Instruction<=32'b000000_11111_00000_00000_00000_001000;
            8'd11:	Instruction<=32'b001000_00100_00100_11111_11111_111111;
            8'd12:	Instruction<=32'b000011_00000_00000_00000_00000_000011;
            8'd13:	Instruction<=32'b100011_11101_00100_00000_00000_000000;
            8'd14:	Instruction<=32'b100011_11101_11111_00000_00000_000100;
            8'd15:	Instruction<=32'b001000_11101_11101_00000_00000_001000;
            8'd16:	Instruction<=32'b000000_00100_00010_00010_00000_100000;
            8'd17:	Instruction<=32'b000000_11111_00000_00000_00000_001000;
			default: Instruction <= 32'h00000000;
		endcase
		
endmodule
