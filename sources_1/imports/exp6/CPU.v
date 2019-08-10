module CPU(reset, clk);
    input reset, clk;
    
    reg [31:0] clk_count;          // system clock count
    
    always @(posedge clk or posedge reset) begin
       if (reset)
           clk_count<=32'b0;
       else
           clk_count<=clk_count+32'b1;
    end
    
    wire clk_ecp;           // clock exception
    reg [31:0] epc;
    
    // IF/ID
    reg [31:0] id_pc_4,id_pc_8,id_inst;
    
    // ID/IF
    wire id_branch,id_zero; //put branch in ID
    wire [1:0] id_pc_src;  // TODO
    wire [31:0] id_pc_imm,id_data1,id_data2;
    
    wire id_hazard; //load-use hazard detection

    // ID/EX
    reg [31:0] ex_data1,ex_data2,ex_imm,ex_inst,ex_pc_8;
    wire [31:0] ex_aluout;
    reg [4:0] ex_rd;
    
    reg [4:0] ex_aluop;
    reg ex_alusrc1,ex_alusrc2;
    
    reg ex_memread,ex_memwrite;
    
    reg ex_regwrite;
    reg [1:0] ex_memtoreg;
    
    // EX/MEM
    reg [31:0] mem_aluout,mem_data2,mem_pc_8,mem_inst;
    reg [4:0] mem_rd;

    reg mem_memread,mem_memwrite;
    
    reg mem_regwrite;
    reg [1:0] mem_memtoreg;
    wire [31:0] mem_read_data,mem_out;      // TODO: this is forwarded to ID for 'beq', potentially elongate path.

    // MEM/WB
    reg [31:0] wb_out;
    
    reg wb_regwrite;
    reg [4:0] wb_rd;
        
    // IF
    reg [31:0] if_pc;
//    reg [1:0] if_pc_src;
    wire [31:0] if_pc_4,if_pc_8,if_pc_next,if_inst;
    wire [4:0] if_rs,if_rt;
    wire if_memwrite;
    assign if_rs=if_inst[25:21];
    assign if_rt=if_inst[20:16];
    assign if_memwrite=(if_inst[31:26]==6'h2b)?1'b1:1'b0;
    assign if_pc_4=if_pc+32'd4;
    assign if_pc_8=if_pc+32'd8; // delay slot jump
    // beq and jump dealt at ID stage, so it will affect next IF
    // if_pc_src: 0-beq , 1-j/jal , 2-jr/jalr
    assign if_pc_next=id_hazard?if_pc:      // if there's a load-use hazard, stall
                      (id_pc_src==2'd0)?((id_branch&id_zero)?id_pc_imm:if_pc_4):
                      (id_pc_src==2'd1)?{if_pc_4[31:28], id_inst[25:0], 2'b00}:id_data1;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            if_pc<=32'hffff_fffc;
            id_pc_4<=32'd0;
            id_pc_8<=32'd0;
            id_inst<=32'd0;
        end else begin
            if_pc<=if_pc_next;
            id_pc_4<=if_pc_4;
            id_pc_8<=if_pc_8;
            id_inst<=id_hazard?32'b0:if_inst;
        end
    end
    InstructionMemory instruction_memory1(.Address(if_pc), .Instruction(if_inst));
    
    // ID & WB // TODO: is it OK to use wb_out? No! Use mem_out & mem_regwrite
    wire [31:0] id_data1_,id_data2_;
    wire [4:0] id_rs,id_rt;
    assign id_rs=id_inst[25:21];
    assign id_rt=id_inst[20:16];
    RegisterFile register_file1(.reset(reset), .clk(clk), .RegWrite(mem_regwrite), 
        .Read_register1(if_rs), .Read_register2(if_rt), .Write_register(mem_rd),
        .Write_data(mem_out), .Read_data1(id_data1_), .Read_data2(id_data2_));
        
    // TODO: if the critical path is too long, stall before beq
    assign id_data1=(ex_regwrite&&(ex_rd==id_rs))?
                     ((ex_memtoreg==2'b0)?ex_aluout:ex_pc_8):    // load-use should've been avoided before this
                    (mem_regwrite&&(mem_rd==id_rs))?
                     ((mem_memtoreg==2'b0)?mem_aluout:
                      (mem_memtoreg==2'b1)?mem_read_data:mem_pc_8
                     ):(wb_regwrite&&(wb_rd==id_rs))?wb_out:id_data1_;    // WB/ID forwarding
    assign id_data2=(ex_regwrite&&(ex_rd==id_rt))?
                     ((ex_memtoreg==2'b0)?ex_aluout:ex_pc_8):    // load-use should've been avoided before this
                    (mem_regwrite&&(mem_rd==id_rt))?
                     ((mem_memtoreg==2'b0)?mem_aluout:
                      (mem_memtoreg==2'b1)?mem_read_data:mem_pc_8
                     ):(wb_regwrite)?wb_out:id_data2_;
    assign id_zero=((id_data1==id_data2)^(id_inst[31:26]==6'h5)); // bne
    
    wire [1:0] id_regdst;
    wire id_memread;
    wire [1:0] id_memtoreg;
    wire [3:0] id_aluop;
    wire id_extop;
    wire id_luop;
    wire id_memwrite;
    wire id_alusrc1;
    wire id_alusrc2;
    wire id_regwrite_;
    wire id_regwrite;
    
    
    Control control1(
        .OpCode(id_inst[31:26]), .Funct(id_inst[5:0]),
        .PCSrc(id_pc_src), .Branch(id_branch), .RegWrite(id_regwrite_), .RegDst(id_regdst), 
        .MemRead(id_memread),    .MemWrite(id_memwrite), .MemtoReg(id_memtoreg),
        .ALUSrc1(id_alusrc1), .ALUSrc2(id_alusrc2), .ExtOp(id_extop), .LuOp(id_luop), .ALUOp(id_aluop));

    // load-use hazard, unless it's load-store
    assign id_hazard=id_memread&&(|id_rt)&&((id_rt==if_rs)||((id_rt==if_rt)&&(!if_memwrite)));

    wire [31:0] id_imm;
    assign id_imm=id_luop? {id_inst[15:0], 16'h0000}:
                           {id_extop? {16{id_inst[15]}}: 16'h0000, id_inst[15:0]};
    assign id_pc_imm={id_imm[29:0],2'b00}+id_pc_4;
    wire [4:0] ex_rd_;
    assign ex_rd_=(id_regdst == 2'b00)? id_rt: (id_regdst == 2'b01)? id_inst[15:11]: 5'b11111;
    assign id_regwrite=(id_regwrite_&&(|ex_rd_))?1'b1:1'b0;         // make sure it's not going to write $zero
    always @(posedge clk or posedge reset) begin
       //TODO forward read_out
       if (reset) begin
           ex_data1<=32'b0;
           ex_data2<=32'b0;
           ex_imm<=32'b0;
           ex_inst<=32'b0;
           ex_pc_8<=32'b0;
           ex_rd<=5'b0;
           ex_aluop<=5'b0;
           ex_alusrc1<=1'b0;
           ex_alusrc2<=1'b0;
           
           ex_memread<=1'b0;
           ex_memwrite<=1'b0;
           
           ex_regwrite<=1'b0;
           ex_memtoreg<=2'b0;
       end else begin
           ex_data1<=id_data1;
           ex_data2<=id_data2;
           ex_imm<=id_imm;
           ex_inst<=id_inst;
           ex_pc_8<=id_pc_8;
           ex_rd<=ex_rd_;
           
           ex_aluop<=id_aluop;
           ex_alusrc1<=id_alusrc1;
           ex_alusrc2<=id_alusrc2;
           
           ex_memread<=id_memread;
           ex_memwrite<=id_memwrite;
           
           ex_regwrite<=id_regwrite;
           ex_memtoreg<=id_memtoreg;
       end
    end
    
    // EX
    wire [4:0] ex_aluctrl;
    wire ex_sign;
    ALUControl alu_control1(.ALUOp(ex_aluop), .Funct(ex_inst[5:0]), .ALUCtl(ex_aluctrl), .Sign(ex_sign));
    
    wire [31:0] ex_alu_in1, ex_alu_in2;
    assign ex_alu_in1 = ex_alusrc1? {17'h00000, ex_inst[10:6]}: ex_data1;
    assign ex_alu_in2 = ex_alusrc2? ex_imm: ex_data2;
    ALU alu1(.in1(ex_alu_in1), .in2(ex_alu_in2), .ALUCtl(ex_aluctrl), .Sign(ex_sign), .out(ex_aluout));
    
    wire [31:0] mem_data2_;
    // load-store
    assign mem_data2_=(mem_memread&&(mem_rd==ex_rd))?mem_read_data:ex_data2;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            mem_aluout<=32'b0;
            mem_data2<=32'b0;
            mem_pc_8<=32'b0;
            mem_inst<=32'b0;
            mem_rd<=5'b0;
            
            mem_memread<=1'b0;
            mem_memwrite<=1'b0;
            mem_regwrite<=1'b0;
            mem_memtoreg<=1'b0;
        end else begin
            mem_aluout<=ex_aluout;
            mem_data2<=mem_data2_;
            mem_pc_8<=ex_pc_8;
            mem_inst<=ex_inst;
            mem_rd<=ex_rd;
            
            mem_memread<=ex_memread;
            mem_memwrite<=ex_memwrite;
            mem_regwrite<=ex_regwrite;
            mem_memtoreg<=ex_memtoreg;
        end
    end
    
    //MEM
    DataMemory data_memory1(.reset(reset), .clk(clk), .clk_count(clk_count), .Address(ex_aluout), .Write_data(mem_data2_),
                            .Read_data(mem_read_data), .MemRead(ex_memread), .MemWrite(ex_memwrite), .clk_ecp(clk_ecp));
    assign mem_out = (mem_memtoreg == 2'b00)? mem_aluout: (mem_memtoreg == 2'b01)? mem_read_data: mem_pc_8;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wb_out<=32'b0;
            wb_regwrite<=1'b0;
            wb_rd<=5'b0;
        end else begin
            wb_out<=mem_out;
            wb_regwrite<=mem_regwrite;
            wb_rd<=mem_rd;
        end
    end

endmodule
    