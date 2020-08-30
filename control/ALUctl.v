module ALUctl(
    input [5:0] func, //from instruction[5:0]
    input R_Type,
    output reg[4:0] aluc,    //ALUctl
    output sftmd,   //1:shift inst.
    output jr_out,
    output jalr_out
);
wire jr,jalr;

always@(*)begin
    case(func)   //R-Type
        6'b100001:aluc<=5'b00000;//addu
        6'b100011:aluc<=5'b00001;//subu
        6'b101010:aluc<=5'b00010;//slt
        6'b100100:aluc<=5'b00011;//and
        6'b100111:aluc<=5'b00100;//nor
        6'b100101:aluc<=5'b00101;//or
        6'b100110:aluc<=5'b00110;//xor
        6'b000000:aluc<=5'b00111;//sll
        6'b000010:aluc<=5'b01000;//srl
        6'b101011:aluc<=5'b01001;//sltu
        6'b001001:aluc<=5'b01010;//jalr
        6'b001000:aluc<=5'b01011;//jr
        6'b000100:aluc<=5'b01100;//sllv
        6'b000011:aluc<=5'b01101;//sra
        6'b000111:aluc<=5'b01110;//srav
        6'b000110:aluc<=5'b01111;//srlv
    endcase
end

assign sftmd=(!func[5]&&!func[4]&&!func[3]&&!func[2]&&!func[0])
||(!func[5]&&!func[4]&&!func[3]&&!func[2]&&func[1]&&func[0]);   //1:sll,srl,sra

assign jr=(!func[5]&&!func[4]&&func[3]&&!func[2]&&!func[1]&&!func[0]);
assign jr_out=(R_Type==1)?jr:1'b0;

assign jalr=(!func[5]&&!func[4]&&func[3]&&!func[2]&&!func[1]&&func[0]);
assign jalr_out=(R_Type==1)?jalr:1'b0;

endmodule