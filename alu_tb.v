module alu_tb;
reg[31:0] a,b;
reg[4:0] aluc;
reg[4:0] shamt;
wire[31:0] r;
wire zero,carry,overflow;

ALU alu(a,b,aluc,r,shamt,zero,carry,overflow);

initial begin
    a=32'b0;b=32'b0;
    aluc=5'b0;shamt=5'b0;

    #10 a=32'h00000003;b=32'h00000001;aluc=5'b0;//addu
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b00011;//and
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b00101;//or
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b00110;//xor
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b00100;//nor
    #10 a=32'h00000003;b=32'hfffffff1;aluc=5'b00111;shamt=5'b00100;//sll
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b00010;//slt
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b01001;//sltu
    #10 a=32'h00000003;b=32'hfffffff1;aluc=5'b01000;shamt=5'b00100;//srl
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b00001;//subu
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b10000;//lui
    #10 a=32'hfffffff3;b=32'h00000001;aluc=5'b10001;//bgez
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b10010;//bgtz
    #10 a=32'hfffffff3;b=32'h00000001;aluc=5'b10011;//blez
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b10100;//bltz
    #10 a=32'h00000003;b=32'hfffffff1;aluc=5'b01101;//sra
    #10 a=32'h00000003;b=32'hfffffff1;aluc=5'b01110;//srav
    #10 a=32'h00000003;b=32'hfffffff1;aluc=5'b01111;//srlv
    #10 a=32'h00000003;b=32'hfffffff1;aluc=5'b01100;//sllv
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b01011;//jr
    #10 a=32'h00000003;b=32'h00000001;aluc=5'b01010;//jalr
end


endmodule