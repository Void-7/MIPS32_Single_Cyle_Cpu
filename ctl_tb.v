module control_test;

 reg [5:0] op;reg[4:0]br_div;
 wire R_format,Branch,nBranch,Jump,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,ExtOp
 ,BGEZ,BGTZ,BLEZ,BLTZ,lb,lbu,sb,jal; 
 wire[4:0] ALUop; 
 
 control CTL(op,br_div,R_format,RegDst,ALUSrc,MemtoReg,RegWr,MemWr,Branch,nBranch,BGEZ,BGTZ,BLEZ,BLTZ,lb,lbu,sb,jal,Jump,ExtOp,ALUop); 

 initial begin
        op[5:0]=6'b001001;//addiu
        #10 op[5:0]=6'b000100;//beq
        #10 op[5:0]=6'b000101;//bne
        #10 op[5:0]=6'b100011;//lw
        #10 op[5:0]=6'b101011;//sw
        #10 op[5:0]=6'b001111;//lui
        #10 op[5:0]=6'b001010;//slti
        #10 op[5:0]=6'b001011;//sltiu
        #10 op[5:0]=6'b001100;//andi
        #10 op[5:0]=6'b001101;//ori
        #10 op[5:0]=6'b001110;//xori
        #10 op[5:0]=6'b101000;//sb
        #10 op[5:0]=6'b100000;//lb
        #10 op[5:0]=6'b100100;//lbu
        #10 op[5:0]=6'b000011;//jal
        #10 op[5:0]=6'b000001;br_div[4:0]=5'b00001; //bgez
        #10 op[5:0]=6'b000001;br_div[4:0]=5'b00000; //bltz
        #10 op[5:0]=6'b000111;//bgtz
        #10 op[5:0]=6'b000110;//blez
 end 

endmodule