module aluctl_tb;
reg[5:0]func;
reg Rtype;
wire[4:0]aluc;
wire sftmd,jr,jalr;

ALUctl aluctl(func,Rtype,aluc,sftmd,jr,jalr);

initial begin
    func=6'b0;Rtype=0;
        #10 func=6'b100001;//addu
        #10 func=6'b100011;//subu
        #10 func=6'b101010;//slt
        #10 func=6'b100100;//and
        #10 func=6'b100111;//nor
        #10 func=6'b100110;//or
        #10 func=6'b100110;//xor
        #10 func=6'b000000;//sll
        #10 func=6'b000010;//srl
        #10 func=6'b101011;//sltu
        #10 func=6'b001001;Rtype=1;//jalr
        #10 func=6'b001000;Rtype=1;//jr
        #10 func=6'b001000;//sllv
        #10 func=6'b000011;//sra
        #10 func=6'b000111;//srav
        #10 func=6'b000110;//srlv
end

endmodule