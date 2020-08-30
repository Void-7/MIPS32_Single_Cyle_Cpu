module ALU(
    input [31:0] a,
    input [31:0] b,
    input [4:0] aluc,
    output [31:0] r,
    input [4:0] shamt,  //input offset for shift inst.
    output zero,
    output carry,
    output overflow
);
reg[32:0] result;

parameter Addu = 5'b00000;
parameter And = 5'b00011;
parameter Or = 5'b00101;
parameter Xor= 5'b00110;
parameter Nor=5'b00100;
parameter Sll= 5'b00111;
parameter Slt= 5'b00010;
parameter Sltu= 5'b01001;
parameter Srl=5'b01000;
parameter Subu=5'b00001;
parameter Lui=5'b10000;
parameter Bgez=5'b10001;
parameter Bgtz=5'b10010;
parameter Blez=5'b10011;
parameter Bltz=5'b10100;
parameter Sra=5'b01101;
parameter Srav=5'b01110;
parameter Srlv=5'b01111;
parameter Sllv=5'b01100;
parameter Jr=5'b01011;
parameter Jalr=5'b01010;

wire signed [31:0] signed_a=a,signed_b=b;

always@(*) begin
    case(aluc)
        Addu:begin  result=a+b;end
        And:begin  result=a&b;end
        Or:begin  result=a|b;end
        Nor:begin result=~(a|b);end
        Sll:begin  result=b<<shamt;end
        Srl:begin result=b>>shamt;end
        Slt:begin result=signed_a<signed_b?1:0;end
        Sltu:begin result=a<b?1:0;end
        Xor:begin result=a^b;end
        Sra:begin result=signed_b>>>shamt;end
        Srav:begin result=signed_b>>>a;end
        Srlv:begin result=b>>a;end
        Sllv:begin result=b<<a;end
        Subu:begin result=a-b;end
        Lui:begin result = {b[15:0], 16'b0};end
        Bgez:begin result=signed_a>=0?1:0;end
        Bgtz:begin result=signed_a>0?1:0;end
        Blez:begin result=signed_a<=0?1:0;end
        Bltz:begin result=signed_a<0?1:0;end
        Jr,Jalr:begin result=a+32'h00003000;end
        default: result=a+b;
    endcase
end
assign r=result[31:0];
assign carry=result[32];
assign zero=(result==32'b0)?1:0;
assign overflow=result[32];

endmodule