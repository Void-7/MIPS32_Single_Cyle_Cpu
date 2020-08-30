module testbench();

reg clk;
reg rst;

mips mips(clk, rst);

initial begin
    clk <= 0;
    rst <= 1;
    #15 rst <= 0;
end

always begin
    #15 clk <= 1;
    #15 clk <= 0;
end

endmodule