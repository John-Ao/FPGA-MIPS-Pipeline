module Control(OpCode, Funct,
    PCSrc, Branch, RegWrite, RegDst, 
    MemRead, MemWrite, MemtoReg, 
    ALUSrc1, ALUSrc2, ExtOp, LuOp, ALUOp, Legit);
    input [5:0] OpCode;
    input [5:0] Funct;
    output [1:0] PCSrc;
    output Branch;
    output RegWrite;
    output [1:0] RegDst;
    output MemRead;
    output MemWrite;
    output [1:0] MemtoReg;
    output ALUSrc1;
    output ALUSrc2;
    output ExtOp;
    output LuOp;
    output [3:0] ALUOp;
    output Legit;
    
    assign PCSrc=(OpCode[5:1]==5'h01)?2'b01:(OpCode==6'h00&&(Funct[5:1]==5'h04))?2'b11:2'b00;
    assign Branch=(OpCode[5:1]==5'h02);
    assign RegWrite=((OpCode==6'h0&&(Funct[5:4]==2'h2||Funct==6'h9||Funct[5:2]==4'h0))||OpCode[5:3]==3'h1||OpCode==6'h23||OpCode==6'h03);
    assign RegDst=(OpCode==6'h23||OpCode==6'h2b||OpCode==6'h0f||OpCode[5:2]==4'h02||OpCode==6'h0c)?2'b00:(OpCode==6'h03||(OpCode==6'h00&&Funct==6'h09))?2'b10:2'b01;
    assign MemRead=(OpCode==6'h23);
    assign MemWrite=(OpCode==6'h2b);
    assign MemtoReg=(OpCode==6'h23)?2'b01:(OpCode==6'h03||(OpCode==6'h00&&Funct==6'h09))?2'b10:2'b00;
    assign ALUSrc1=(OpCode==6'h00&&(Funct==6'h00||Funct[5:1]==5'h01));
    assign ALUSrc2=(OpCode==6'h23||OpCode==6'h2b||OpCode==6'h0f||OpCode[5:2]==4'h02||OpCode==6'h0c);
    assign ExtOp=(OpCode==6'h23||OpCode==6'h2b||OpCode[5:1]==5'h04||OpCode==6'h0a||OpCode[5:1]==5'h02);
    assign LuOp=(OpCode==6'h0f);
    assign Legit=(OpCode[5:1]==5'h1||OpCode[5:1]==5'h2||OpCode[5:1]==5'h4||OpCode[5:1]==5'h5||OpCode==6'hc||OpCode==6'hf||OpCode==6'h23||OpCode==6'h2b)||
                 (OpCode==6'h0&&(Funct==6'h0||Funct[5:1]==5'h1||Funct[5:1]==5'h4||Funct[5:3]==3'b100||Funct[5:1]==5'b10101))||
                 (OpCode==6'h10&&Funct==6'h18);
    
    assign ALUOp[2:0] = 
        (OpCode == 6'h00)? 3'b010: 
        (OpCode == 6'h04)? 3'b001: 
        (OpCode == 6'h0c)? 3'b100: 
        (OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
        3'b000;
        
    assign ALUOp[3] = OpCode[0];
    
endmodule