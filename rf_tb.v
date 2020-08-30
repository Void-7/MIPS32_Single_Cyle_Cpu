module rf_tb;
reg clk,rst,we;
reg[4:0]ra,rb,rw;
reg[31:0]busW;
wire[31:0]busA,busB;

regfile rf(clk,rst,we,ra,rb,rw,busW,busA,busB);

initial begin
    clk = 0;
    rst = 1;
    #6 rst = 0;
    #4 we=1;rw=5'b00001;busW=32'h00006666;
    #20 rw=5'b00100;busW=32'h00004444;
    #5 we=0;ra=5'b00001;rb=5'b00100;
end

always #10 clk = ~clk;
    
endmodule