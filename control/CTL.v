module control(
    input [31:26]op,    //from instruction[31:26]
    input [20:16]br_div,
    output R_format,    //1:r_format;
    output RegDST,  //1:target reg:rd
    output ALUSrc,  //1:2nd op num:immediate
    output MemtoReg,//1:read data from mem to reg
    output RegWrite,//1:write reg
    output MemWrite,//1:write mem
    output Branch,  //1:beq
    output nBranch, //1:bne
    output BGEZ,BGTZ,BLEZ,BLTZ,
    output lb,lbu,sb,
    output jal,
    output Jmp,     //1:j
    output ExtOp,   //0:z_ext  1:s_ext
    output reg[4:0] ALUop
);

assign Branch=(!op[31]&&!op[30]&&!op[29]&&op[28])||(!op[31]&&!op[30]&&!op[29]&&!op[28]&&!op[27]&&op[26]);
assign nBranch=(!op[31]&&!op[30]&&!op[29]&&op[28]&&!op[27]&&op[26]);
assign lb=(op[31]&&!op[30]&&!op[29]&&!op[28]&&!op[27]&&!op[26]);
assign lbu=(op[31]&&!op[30]&&!op[29]&&op[28]&&!op[27]&&!op[26]);
assign sb=(op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&!op[26]);
assign Jmp=!op[31]&&!op[30]&&!op[29]&&!op[28]&&op[27];
assign R_format=(op==6'b000000)?1'b1:1'b0;
assign RegDST=R_format;
assign ALUSrc=(!op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&op[26])||(op[31]&&!op[30]&&!op[28]&&op[27]&&op[26])
||(!op[31]&&!op[30]&&op[29]&&op[28]&&op[27]&&op[26])||(!op[31]&&!op[30]&&op[29]&&!op[28]&&op[27])
||(op[31]&&!op[30]&&!op[29]&&!op[27]&&!op[26])||(op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&!op[26])
||(!op[31]&&!op[30]&&op[29]&&op[28]&&!op[27])||(!op[31]&&!op[30]&&op[29]&&op[28]&&op[27]&&!op[26]);

assign MemWrite=(op[31]&&!op[30]&&op[29]&&!op[28]&&op[27]&&op[26])
||(op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&!op[26]);

assign MemtoReg= (op[31]&&!op[30]&&!op[29]&&!op[28]&&op[27]&&op[26])
||(op[31]&&!op[30]&&!op[29]&&!op[27]&&!op[26]);

assign RegWrite=(!op[31]&&!op[30]&&!op[29]&&!op[28]&&!op[27]&&!op[26])
||(!op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&op[26])||(op[31]&&!op[30]&&!op[29]&&!op[28]&&op[27]&&op[26])
||(!op[31]&&!op[30]&&op[29]&&op[28]&&op[27]&&op[26])||(!op[31]&&!op[30]&&op[29]&&!op[28]&&op[27])
||(op[31]&&!op[30]&&!op[29]&&!op[27]&&!op[26])||(!op[31]&&!op[30]&&op[29]&&op[28]&&!op[27])
||(!op[31]&&!op[30]&&op[29]&&op[28]&&op[27]&&!op[26])||(!op[31]&&!op[30]&&!op[29]&&!op[28]&&op[27]&&op[26]);

assign ExtOp=(!op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&op[26])
||(!op[31]&&!op[30]&&op[29]&&!op[28]&&op[27])||(op[31]&&!op[30]&&!op[29]&&!op[28]&&!op[27]&&!op[26])
||(op[31]&&!op[30]&&!op[29]&&!op[28]&&op[27]&&op[26])||(op[31]&&!op[30]&&!op[29]&&op[28]&&!op[27]&&!op[26])
||(op[31]&&!op[30]&&op[29]&&!op[28]&&!op[27]&&!op[26])||(op[31]&&!op[30]&&op[29]&&!op[28]&&op[27]&&op[26]);

assign jal=(!op[31]&&!op[30]&&!op[29]&&!op[28]&&op[27]&&op[26]);

always@(*)begin
    case(op)   //I-Type,Jal
        6'b001001:ALUop<=5'b00000;//addiu
        6'b000100:ALUop<=5'b00001;//beq
        6'b000101:ALUop<=5'b00001;//bne
        6'b100011:ALUop<=5'b00000;//lw
        6'b101011:ALUop<=5'b00000;//sw
        6'b001111:ALUop<=5'b10000;//lui
        6'b001010:ALUop<=5'b00010;//slti
        6'b001011:ALUop<=5'b01001;//sltiu
        6'b001100:ALUop<=5'b00011;//andi
        6'b001101:ALUop<=5'b00101;//ori
        6'b001110:ALUop<=5'b00110;//xori
        6'b101000:ALUop<=5'b00000;//sb
        6'b100000:ALUop<=5'b00000;//lb
        6'b100100:ALUop<=5'b00000;//lbu
    endcase
end


assign BGEZ=(!op[31]&&!op[30]&&!op[29]&&!op[28]&&!op[27]&&op[26]
&&!br_div[20]&&!br_div[19]&&!br_div[18]&&!br_div[17]&&br_div[16]);
assign BLTZ=(!op[31]&&!op[30]&&!op[29]&&!op[28]&&!op[27]&&op[26]
&&!br_div[20]&&!br_div[19]&&!br_div[18]&&!br_div[17]&&!br_div[16]);
assign BGTZ=!op[31]&&!op[30]&&!op[29]&&op[28]&&op[27]&&op[26];
assign BLEZ=!op[31]&&!op[30]&&!op[29]&&op[28]&&op[27]&&!op[26];

always@(*)begin
    case(op)    //Br-Type
        6'b000001:case(br_div)
            5'b00001: ALUop<=5'b10001;  //bgez
            5'b00000: ALUop<=5'b10100; endcase  //bltz
        6'b000111: ALUop<=5'b10010;  //bgtz
        6'b000110: ALUop<=5'b10011;  //blez
    endcase
end

endmodule