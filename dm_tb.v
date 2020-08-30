module dm_tb;

reg sb,lb,lbu;
reg[11:0] addr;
reg[31:0] din;
reg MemWr,clk;
wire[31:0] dout;

dm_4k dm(sb,lb,lbu,addr,din,MemWr,clk,dout);

initial begin
    sb=0;lb=0;lbu=0;
    addr=12'b0;din=32'b0;MemWr=0;
    clk=0;
    #10 MemWr=1;din=32'h00000004;addr=12'b0;
    #20 din=32'h00000012;addr=12'b000000000100;
    #10 sb=1;din=32'h00301046;addr=12'b0;
    #15 sb=0;lb=1;din=32'h00301046;addr=12'b000000000010;
    #10 lb=0;lbu=1;din=32'h00301046;addr=12'b000000000011;
end

always #10 clk=~clk;

endmodule